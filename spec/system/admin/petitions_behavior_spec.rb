require 'rails_helper'

describe "interaction for Admin::PetitionsController", type: :feature do
  include HotGlue::ControllerHelper
  
    let!(:user1) {create(:user, name: FFaker::Name.name)}
  let!(:petition1) {create(:petition , question1:  FFaker::Lorem.paragraphs(10).join(), 
      question2:  FFaker::Lorem.paragraphs(10).join(), 
      question3:  FFaker::Lorem.paragraphs(10).join(), 
      accepted_at: DateTime.current + rand(1000).seconds, 
      rejected_at: DateTime.current + rand(1000).seconds )}
   

  describe "index" do
    it "should show me the list" do
      visit admin_petitions_path




      expect(page).to have_content(petition1.accepted_at.in_time_zone(current_timezone).strftime('%m/%d/%Y @ %l:%M %p ').gsub('  ', ' ') + timezonize(current_timezone)  )
      expect(page).to have_content(petition1.rejected_at.in_time_zone(current_timezone).strftime('%m/%d/%Y @ %l:%M %p ').gsub('  ', ' ') + timezonize(current_timezone)  )
    end
  end




  describe "edit & update" do
    it "should return an editable form" do
      visit admin_petitions_path
      find("a.edit-petition-button[href='/admin/petitions/#{petition1.id}/edit']").click

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


end

