class ContestsController < AuthorizedController
  before_action :set_contest, only: [:show, :edit, :update, :destroy]
  before_action :set_contest_contest_id, only: [:complete, :incomplete, :upvote]

  rescue_from ActionController::ParameterMissing, with: :missing_parameter_error

  # GET /contests
  # GET /contests.json
  def index
    @contests = Contest.all.where(parent_id: nil)
    @contest = Contest.new("contests" => @contests)
    @new_sub_contest = @contests.build
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
    @new_sub_contest = @contest.contests.build
  end

  # GET /contests/new
  def new
    @contest = Contest.new
  end

  # GET /contests/1/edit
  def edit
  end

  # POST /contests
  # POST /contests.json
  def create
    @contest = Contest.new(contest_params)

    respond_to do |format|
      if @contest.save
        format.html { redirect_to Contest.find(@contest.parent_id || @contest.id), notice: 'Contest was successfully created.' }
        format.json { render :show, status: :created, location: Contest.find(@contest.parent_id || @contest.id) }
      else
        format.html { render :new }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
    @contest.update({"completed": true})

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Completed!' }
      format.json { render :show, status: :ok, location: :back }
    end
  end

  def incomplete
    @contest.update({"completed": false})

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Un completed' }
      format.json { render :show, status: :ok, location: :back }
    end
  end

  def upvote
    @contest.votes << Vote.new({contest_id: @contest.id})
    @contest.save

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Vote counted' }
      format.json { render :show, status: :ok, location: :back }
    end
  end

  # PATCH/PUT /contests/1
  # PATCH/PUT /contests/1.json
  def update
    respond_to do |format|
      if @contest.update(contest_params)
        logger.info params["completed"]
        if params["completed"] == true
          format.html { redirect_to :back, notice: 'Contest was successfully updated.' }
          format.json { render :show, status: :ok, location: :back }
        else
          format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
          format.json { render :show, status: :ok, location: @contest }
        end
      else
        format.html { render :edit }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    @contest.destroy
    respond_to do |format|
      if @contest.parent_id 
        @redirect = Contest.find(@contest.parent_id)
      else
        @redirect = contests_url
      end
      format.html { redirect_to @redirect, notice: 'Contest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @contest = Contest.includes(:votes).find(params[:id])
    end

  def set_contest_contest_id
    @contest = Contest.includes(:votes).find(params[:contest_id])
  end

    # Only allow a list of trusted parameters through.
    def contest_params
      params.require(:contest).let do |contest|
        contest.require(:name)
        contest.permit(:name, :note, :parent_id, :completed)
      end
    end

  def missing_parameter_error(exception)
    if exception.is_a?(ActionController::ParameterMissing) && exception.param == :name
      flash[:contest_needs_name] = "Please create a name"
      # redirect back
      redirect_back fallback_location: root_path
    else
      raise exception
    end
  end
end
