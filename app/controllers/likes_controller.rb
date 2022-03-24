class LikesController < ApplicationController

    def create
        idea = Idea.find params[:idea_id]
        like = Like.new(idea: idea, user: current_user)

        if can?(:like, idea)
            if like.save
                flash.notice = "idea liked!"
            else
                flash.alert = like.errors.full_messages.join(', ')
            end
        else
            flash.alert = "You can not like this idea"
        end
        redirect_to idea_path(idea)
    end

    def destroy
        like = current_user.likes.find params[:id]
        if can?(:destroy, like)
            like.destroy
            flash.notice = "idea Unliked!"
        else
            flash.alert = "Can't unlike it!"
        end
        redirect_to idea_path(like.idea)
    end

end
