require './spec/spec_helper'

shared_examples 'Successfully created project' do |project|
  include_context 'Create a new project', project
  it 'success message is shown' do
    on ProjectSettingsPage, :using_params => {:project_name => project.name} do |page|
      expect(page).to have_success_message
    end
  end
  it 'correct project title is shown' do
    on ProjectSettingsPage, :using_params => {:project_name => project.name} do |page|
      expect(page.project_title).to eql project.name
    end
  end
end

shared_context 'Create a new project' do |project|
  before :all do
    visit(CreateProjectPage).create_project(project)
  end
end

shared_context 'Add user as a member to project' do |user, project|
  before :all do
    visit ProjectMembersPage, :using_params => {:project_name => project.name} do |page|
      page.add_member(user)
    end
  end
end