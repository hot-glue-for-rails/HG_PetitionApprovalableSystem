require 'rails_helper'

describe "interaction for PetitionsController", type: :feature do
  include HotGlue::ControllerHelper
  let(:current_user) {create(:user)}
    
  let!(:petition1) {create(:petition, user: current_user , question1:  FFaker::Lorem.paragraphs(10).join(), 
      question2:  FFaker::Lorem.paragraphs(10).join(), 
      question3:  FFaker::Lorem.paragraphs(10).join() )}
   
  before(:each) do
    login_as(current_user)
  end 

  describe "index" do
    it "should show me the list" do
      visit petitions_path



    end
  end

  describe "new & create" do
    it "should create a new Petition" do
      visit petitions_path
      click_link "New Petition"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Petition")]')

      new_question1 = 'new_test-email@nowhere.com' 
      find("[name='petition[question1]']").fill_in(with: new_question1)
      new_question2 = 'new_test-email@nowhere.com' 
      find("[name='petition[question2]']").fill_in(with: new_question2)
      new_question3 = 'new_test-email@nowhere.com' 
      find("[name='petition[question3]']").fill_in(with: new_question3)
      click_button "Save"
      expect(page).to have_content("Successfully created")

      expect(page).to have_content(new_question1)
      expect(page).to have_content(new_question2)
      expect(page).to have_content(new_question3)

    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit petitions_path
      find("a.edit-petition-button[href='/petitions/#{petition1.id}/edit']").click

      expect(page).to have_content("Editing #{petition1.to_label || "(no name)"}")
      new_question1 = FFaker::Lorem.paragraphs(3).join 
      find("textarea[name='petition[question1]']").fill_in(with: new_question1)
      new_question2 = FFaker::Lorem.paragraphs(3).join 
      find("textarea[name='petition[question2]']").fill_in(with: new_question2)
      new_question3 = FFaker::Lorem.paragraphs(3).join 
      find("textarea[name='petition[question3]']").fill_in(with: new_question3)
      click_button "Save"
      within("turbo-frame#petition__#{petition1.id} ") do


        expect(page).to have_content(new_question1)
        expect(page).to have_content(new_question2)
        expect(page).to have_content(new_question3)

      end
    end
  end

  describe "destroy" do
    it "should destroy" do
      visit petitions_path
      accept_alert do
        find("form[action='/petitions/#{petition1.id}'] > input.delete-petition-button").click
      end
#      find("form[action='/petitions/#{petition1.id}'] > input.delete-petition-button").click

      expect(page).to_not have_content(petition1.to_label)
      expect(Petition.where(id: petition1.id).count).to eq(0)
    end
  end
end

