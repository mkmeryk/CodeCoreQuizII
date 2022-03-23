require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    
    describe "#new" do
        it "requires a render of a new template" do
            #GIVEN
            #WHEN
            get(:new)
            #THEN 
            expect(response).to(render_template(:new))
        end
        it "requires setting an instance variable with a new idea" do
            #GIVEN
            #WHEN
            get(:new)
            #THEN 
            expect(assigns(:idea)).to(be_a_new(Idea))
        end
    end
    
    describe "#create" do
        context "with valid params" do
            def valid_request
                post(:create, params: {idea: FactoryBot.attributes_for(:idea) })
            end
            it "requires a new creation of a Idea in the database" do
                #GIVEN
                count_before = Idea.count
                #WHEN
                valid_request
                #THEN 
                count_after = Idea.count
                expect(count_after).to(eq(count_before + 1))
            end
            it "requires a redirect to the show page for the new idea" do
                #GIVEN
                #create a new idea
                #WHEN
                valid_request
                #THEN 
                idea = Idea.last
                expect(response).to(redirect_to (idea_path(idea.id)))
            end
        end

        context "with invalid params" do
            def invalid_request
                post(:create, params: { idea: FactoryBot.attributes_for(:idea, title: nil) })
            end
            it "requires that the database dose not saves the new record of idea" do
            #GIVEN
            count_before = Idea.count
            #WHEN
            invalid_request
            #THEN  
            count_after = Idea.count
            expect(count_after).to(eq(count_before))
            end
            it "requires a render of the new idea template" do
                #GIVEN
                #on the new template creating a new record of Idea
                #WHEN
                invalid_request
                #THEN 
                expect(response).to render_template(:new)
            end
        end   
    end

    describe "#show" do
        it "requires a render of the  show template"do
           #GIVEN
           idea = FactoryBot.create(:idea)
           #WHEN
           get(:show, params:{id: idea.id})
           #THEN  
           expect(response).to render_template(:show)
        end
        it "requires setting an instance variable idea for show"do
            #GIVEN
            idea = FactoryBot.create(:idea)
            #WHEN
            get(:show, params:{id: idea.id})
            #THEN 
            expect(assigns(:idea)).to(eq(idea))
        end
    end

    describe "#index" do
        it "requires a render of the index template" do
            #GIVEN
            #index action triggered
            #WHEN
            get(:index)
            #THEN 
            expect(response).to render_template(:index)
        end
        it "requires assigning an instance variable idea which contains all ideas in the db" do
            #GIVEN
            idea_1 = FactoryBot.create(:idea)
            idea_2 = FactoryBot.create(:idea)
            idea_3 = FactoryBot.create(:idea)
            #WHEN
            get(:index)
            #THEN 
            expect(assigns(:ideas)).to(eq([idea_3,idea_2,idea_1]))
        end
    end

    describe "#destroy" do
        before do
          #GIVEN
          @idea = FactoryBot.create(:idea)
          #WHEN
          delete(:destroy, params: {id: @idea.id})   
        end
        it "requires a record of idea to be removed from the database" do
            #THEN
            expect(Idea.find_by(id: @idea.id)).to be(nil)
        end
        it "requires a redirect to ideas index page" do
            #THEN
            expect(response).to redirect_to(ideas_path)
        end
        it "requires a flash message that the record was deleted" do
            #THEN
            expect(flash[:alert]).to be
        end
    end

    describe "#edit" do
        it "renders the edit template" do
           #GIVEN
           idea = FactoryBot.create(:idea)
           #WHEN
           get(:edit, params: {id: idea.id})
           #THEN 
           expect(response).to render_template :edit
        end
    end

    describe "#update" do
        before do
            #GIVEN
            @idea = FactoryBot.create(:idea)
        end
        context "with valid params" do
            it "requires an update of the idea with new attribiutes" do
                #GIVEN
                new_title = "#{@idea.title} plus a change"
                #WHEN
                patch(:update, params: {id: @idea.id,idea:{title:new_title}})
                #THEN
                expect(@idea.reload.title).to(eq(new_title))
            end
            it "requires a redirect to teh show page of the updated idea" do
                #GIVEN
                new_title = "#{@idea.title} plus a change"
                #WHEN
                patch(:update, params: {id: @idea.id,idea:{title:new_title}})
                #THEN 
                expect(response).to redirect_to(@idea)
            end
        end

        context "with invalid params" do
            it "requires a redord of idea not to be updated in the database" do
                #WHEN
                patch(:update, params: {id: @idea.id, idea: {title: nil}})
                idea_after_update = Idea.find(@idea.id)
                #THEN 
                expect(idea_after_update.title).to(eq(@idea.title))                
            end
        end
    end
    
end

#GIVEN#WHEN#THEN 