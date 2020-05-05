class VotesController < ApplicationController
    before_action :set_vote, only: [:show, :edit, :update, :destroy]

    def create
        Vote.create vote_params
        redirect_to Contest.find params[:contest_id]
    end

    def destroy
        @vote.destroy
        @contest = Contest.find params[:contest_id]
        @item = Item.find params[:item_id]
        redirect_to edit_contest_item_path(@contest, @item)
    end

    private
      def set_vote
        @vote = Vote.find params[:id]
      end

      def vote_params
        params.require(:vote).permit(:item_id)
      end
end
