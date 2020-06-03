class VotesController < ApplicationController
    before_action :set_vote, only: [:show, :edit, :update, :destroy]

    def create
        Vote.create vote_params
        redirect_to request.referrer
    end

    def destroy
        @vote.destroy
        @contest = Contest.find params[:contest_id]
    end

    private
      def set_vote
        @vote = Vote.find params[:id]
      end

      def vote_params
        params.require(:vote).permit(:contest_id)
      end
end
