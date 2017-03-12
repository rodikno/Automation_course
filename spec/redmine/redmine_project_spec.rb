require './spec/spec_helper'

describe '[Project]' do
  user = RedmineUser.new
  context 'As an existing user' do
    include_context 'Register a new user', user

    describe '[Create]' do
      context 'When I create a project' do
        project = RedmineProject.new
        include_examples 'Successfully created project', project
      end
    end

    describe '[Open random project]' do
      describe 'When I try to open random project with retries', :retries => 3 do

        project = RedmineProject.new

        it ': Then desired project is created' do |example|
          random_name = Faker::Hipster.word.capitalize
          random_project_url = BasicPage::BASIC_URL + '/projects/' + random_name
          project_exists = open_url_with_retries(random_project_url, example.metadata[:retries])
          if project_exists
            puts "Project with name [#{random_name}] already exists"
          else
            project.name = random_name
            visit(CreateProjectPage).create_project(project)
            puts "New project [#{project.name}] created"
          end
        end

      end
    end

    describe '[Create version]' do
      context 'Having an existing project' do
        project = RedmineProject.new
        include_context 'Create a new project', project
        context 'When I create a new version' do
          before :all do
            version_name = Faker::Hacker.noun
            visit CreateVersionPage, :using_params => {:project_name => project.name} do |page|
              page.create_version(version_name)
            end
          end
          it ': Then new version is created' do
            on VersionSettingsPage, :using_params => {:project_name => project.name} do |page|
              expect(page.success_message_element).to be_visible
            end
          end
        end
      end
    end

  end
end