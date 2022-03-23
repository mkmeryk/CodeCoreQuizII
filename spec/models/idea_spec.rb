require 'rails_helper'

RSpec.describe Idea, type: :model do
  describe "validares" do

    describe "title" do
      it "requires a title to be present" do
        #GIVEN
        idea = FactoryBot.build(:idea,title: nil)
        #WHEN
        idea.valid?
        #THEN 
        expect(idea.errors.messages).to(have_key(:title))
      end
      it "requires the title to be unique" do
        #GIVEN
        persisted_idea = FactoryBot.create(:idea)
        idea = FactoryBot.build(:idea,title: persisted_idea.title)
        #WHEN
        idea.valid?
        #THEN 
        expect(idea.errors.messages).to(have_key(:title))
      end
    end

    describe "description" do
      it "requires a description to be present" do
        #GIVEN
        idea = FactoryBot.build(:idea,description: nil)
        #WHEN
        idea.valid?
        #THEN 
        expect(idea.errors.messages).to(have_key(:description))
      end
    end
  end


end


#GIVEN#WHEN#THEN 