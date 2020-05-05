class TagsController < ApplicationController

    def show
        # tag_params = params.require(:tag).permit(:id)
        @tag = Tag.includes(:taggings => Tagging.get_taggable).find params[:id]
    end
end
