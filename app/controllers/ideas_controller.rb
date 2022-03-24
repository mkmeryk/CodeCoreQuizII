class IdeasController < ApplicationController

    before_action :authenticate_user!, only:[ :new, :create, :destroy, :edit, :update ]

    def new
        @idea = Idea.new
    end

    def create

        @idea = Idea.create params.require(:idea).permit(:title,:description)
        @idea.user = current_user
        if @idea.save
            redirect_to idea_path(@idea)
        else
            render :new
        end

    end

    def show
       
        @idea = Idea.find params[:id]
        @review = Review.new
        @reviews = @idea.reviews
        
    end

    def index
        @ideas = Idea.all.order(created_at: :desc)
    end

    def edit
        @idea = Idea.find params[:id]
        if can?(:edit, @idea)
            render :edit
        else
            redirect_to root_path
        end

    end

    def update
        @idea = Idea.find params[:id]
        @idea.update params.require(:idea).permit(:title,:description)
        redirect_to @idea
    end

    def destroy
        @idea = Idea.find params[:id]
        if can?(:delete, @idea)
            @idea.destroy
            flash.alert = "Deleted the idea"
            redirect_to ideas_path           
        else
            flash.notice = "Access denied"
            redirect_to new_session_path
        end

    end    
end
