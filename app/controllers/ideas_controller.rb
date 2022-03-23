class IdeasController < ApplicationController


    def new
        @idea = Idea.new
    end

    def create

        @idea = Idea.create params.require(:idea).permit(:title,:description)
        if @idea.save
            redirect_to idea_path(@idea)
        else
            render :new
        end

    end

    def show
        @idea = Idea.find params[:id]
    end

    def index
        @ideas = Idea.all.order(created_at: :desc)
    end

    def destroy
        @idea = Idea.find params[:id]
        @idea.destroy
        flash.alert = "deleted idea"
        redirect_to ideas_path
    end

    def edit

    end

    def update
        @idea = Idea.find params[:id]
        @idea.update params.require(:idea).permit(:title,:description)
        redirect_to @idea
    end
end
