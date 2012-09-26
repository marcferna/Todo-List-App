### UTILITY METHODS ###
def define_list
  @list ||= {:id => 1, :user_id => @visitor[:id], :title => "Test List Title", :description => "Test List Description"}
end

def create_list
  visit new_user_list_path(@visitor[:id])
  fill_in "Title", :with => @list[:title]
  fill_in "Description", :with => @list[:description]
  click_button "Create List"
end

def edit_list
  visit edit_user_list_path(@visitor[:id], @list[:id])
  fill_in "Title", :with => @list[:title]
  fill_in "Description", :with => @list[:description]
  click_button "Update List"
end

## GIVEN ##
Given /^I have a list$/ do
  define_list
  create_list
end

## WHEN ##
When /^I create list with valid data$/ do
  define_list
  create_list
end

When /^I create list without a title$/ do
  define_list
  @list = @list.merge(:title => "")
  create_list
end

When /^I edit list with valid data$/ do
  pending
end

## THEN ## 
Then /^I should see a successful created list message$/ do
  page.should have_content "List created successfully"
end

Then /^I should see a successful updated list message$/ do
  page.should have_content "List updated successfully"
end

Then /^I should see a missing title message$/ do
  page.should have_content "can't be blank"
end
