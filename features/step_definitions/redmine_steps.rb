Then(/^New user is registered$/) do
  expect(on(MyAccountPage)).to have_success_message
end

Then(/^I am logged in$/) do
  expect(on(TopMenuSection).active_user_element.text).to eql @user.login
end

When(/^I log out$/) do
  on(TopMenuSection).log_out
end


Then(/^I am logged out$/) do
  expect(on(TopMenuSection).log_in_element).to be_visible
end


Given(/^I register a user$/) do
  visit(RegistrationPage).register_user(@user)
end

And(/^I log in$/) do
  visit(LoginPage).log_in_as(@user)
end

When(/^I change password$/) do
  new_password = Faker::Internet.password(4)
  visit(ChangePasswordPage).change_password(@user, new_password)
end

Then(/^My password is changed$/) do
  expect(on(MyAccountPage)).to have_success_message
end

When(/^I create a project$/) do
  visit(CreateProjectPage).create_project(@project)
end

When(/^I create a project named '(.+)'$/) do |name|
  @project[:name] = name
  visit(CreateProjectPage).create_project(@project[:name])
end

Then(/^Project is created$/) do
  on ProjectSettingsPage, :using_params => {:project_name => @project.name} do |page|
    expect(page).to have_success_message
  end
end

When(/^I try to open random project with (\d+) retries$/) do |retries_count|
  random_name = Faker::Hipster.word.capitalize
  random_project_url = BasicPage::BASIC_URL + '/projects/' + random_name

  project_exists = open_url_with_retries(random_project_url, retries_count.to_i)

  if project_exists
    puts "Project with name [#{random_name}] already exists"
  else
    @project.name = random_name
    visit(CreateProjectPage).create_project(@project)
    puts "New project [#{@project.name}] created"
  end
end

Then(/^Desired project is created$/) do
  expect(on(ProjectSettingsPage).project_title).to eql @project.name
end

And(/^I create a version$/) do
  version_name = Faker::Hacker.noun
  visit CreateVersionPage, :using_params => {:project_name => @project.name} do |page|
    page.create_version(version_name)
  end
end

Then(/^Version settings page is displayed$/) do
  on VersionSettingsPage, :using_params => {:project_name => @project.name} do |page|
    expect(page.success_message_element).to be_visible
  end
end

And(/^I create a '(.+)' issue$/) do |issue_type|
  @issue.type = issue_type
  visit CreateIssuePage, :using_params => {:project_name => @project.name} do |page|
    page.create_issue(@issue)
  end
end

And(/^I create a '(.+)' issue if it wasn't created$/) do |issue_type|

  unless @issue.type == issue_type
    @issue.type = issue_type
    visit CreateIssuePage, :using_params => {:project_name => @project.name} do |page|
      page.create_issue(@issue)
    end
  end
end

And(/^I create a random issue$/) do
  @issue.type = ['Bug', 'Feature', 'Support'].sample
  visit CreateIssuePage, :using_params => {:project_name => @project.name} do |page|
    page.create_issue(@issue)
  end
end

And(/^I start watching the issue$/) do
  on(IssueDetailsPage).watch_issue
end

Then(/^Issue is created$/) do
  expect(on(IssueDetailsPage)).to have_success_message
end


Then(/^I see my user in the list of issue watchers$/) do
  @current_page.refresh
  expect(on(IssueDetailsPage)).to be_watched_by(@user)
end