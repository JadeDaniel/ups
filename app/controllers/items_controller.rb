class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update, :destroy]


    def new
        @contest = Contest.find params[:contest_id]
        @item = Item.new
        @item.contest_id = @contest.id
    end

    def create
        @contest = Contest.find(params[:contest_id])
        item_params.require(:contest_id)
        @item = @contest.items.create item_params
        redirect_to @contest
    end

    def destroy
        @item.destroy
        redirect_to Contest.find(params[:contest_id]), notice: 'Item was successfully deleted'
    end

    def edit
        @contest = Contest.find params[:contest_id]
        @votes = @item.votes.sort_by{|v| v.created_at}.reverse
    end

    def update
        @item.update item_params
        redirect_to Contest.find params[:contest_id]
    end

    private
      def set_item
        @item = Item.find params[:id]  
      end
      
      def item_params
        params.require(:item).permit(:id, :name, :notes, :contest_id, :tag_list)
      end

end
