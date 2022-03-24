class ReviewsController < ApplicationController

    before_action :authenticate_user!
    before_action :find_idea
    def create
        @review = Review.new(params.require(:review).permit(:body))
        @review.idea = @idea;
        @review.user = current_user
        if @review.save
            redirect_to idea_path(@idea.id), status: 303
        else
            @reviews = @idea.reviews
            render '/ideas/show', status: 303
        end
        
    end
    
    def destroy
        @review = Review.find params[:id]
        if can?(:crud, @review)
            @review.destroy
            redirect_to idea_path(@review.idea)
        else
            redirect_to root_path, alert: "Not Authorized"
        end
    end


    private

    def find_idea
        @idea = Idea.find params[:idea_id]
    end
    
    

end
