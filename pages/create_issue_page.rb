
class CreateIssuePage < BasicPage
  include PageObject

  page_url BASIC_URL + '/projects/<%=params[:project_name]%>/issues/new'

  select_list(:issue_type, :css => 'select#issue_tracker_id')
  select_list(:assignee, :id => 'issue_assigned_to_id')
  text_field(:subject, :id => 'issue_subject')
  text_area(:description, :id => 'issue_description')
  button(:submit, :name => 'commit')

  def create_issue(issue)
    available_types = ['Bug', 'Feature', 'Support']

    if available_types.include?(issue.type)
      self.issue_type = issue.type
    else
      raise StandardError, "Issue type is not available - [#{issue.type}], please choose exisiting one from #{available_types}"
    end

    # form is fully reloaded after option is chosen in 'Issue Type' select
    # and then Selenium can't find the fields since they're not Attached to DOM
    # So retrying 3 times before to make it stable
    tries = 3
    begin
      self.subject = issue.subject
      self.description = issue.description
      submit
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      tries -= 1
      retry if tries > 0
    end

  end

end