require './spec/spec_helper'

describe '[Issue]', :redmine, :issue do
  user = RedmineUser.new
  project = RedmineProject.new

  context 'Having an existing project' do
    include_context 'Register a new user', user
    include_context 'Create a new project', project

    context '[Create one issue of each type]' do
      issue_types = ['Bug', 'Feature', 'Support']

      issue_types.each do |itype|
        context "When I create a [#{itype}] issue" do
          issue = RedmineIssue.new(:type => itype)
          before do
            visit CreateIssuePage, :using_params => {:project_name => project.name} do |page|
              page.create_issue(issue)
            end
          end
          it ": Then [#{itype}] issue is created" do
            expect(on(IssueDetailsPage)).to have_success_message
          end
        end
      end
    end

    context '[Create issue of a random type and add myself to watchers]' do
      issue = RedmineIssue.new
      context 'When I create a new issue with random type' do
        before :all do
          issue.type = ['Bug', 'Feature', 'Support'].sample
          visit CreateIssuePage, :using_params => {:project_name => project.name} do |page|
            page.create_issue(issue)
          end
          # this context will be executed only if NOT 'Bug' was created previously
          unless issue.type == 'Bug'
            issue.type = 'Bug'
            visit CreateIssuePage, :using_params => {:project_name => project.name} do |page|
              page.create_issue(issue)
            end
          end
        end
        context 'And I start watching the issue' do
          before :all do
            on(IssueDetailsPage).watch_issue
          end
          it ': Then I see myself in the watchers list' do
            @current_page.refresh
            expect(on(IssueDetailsPage)).to be_watched_by(user)
          end
        end
      end

    end
  end

end