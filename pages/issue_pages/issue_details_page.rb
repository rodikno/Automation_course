
class IssueDetailsPage < BasicPage
  include PageObject

  page_url BASIC_URL + '/issues/<%=params[:issue_id]%>'

  button(:submit, :css => "div#update input[name='commit']")
  cell(:issue_priority, :css => 'td.priority')
  cell(:issue_status, :css => 'td.status')
  div(:success_message, :id => 'flash_notice')
  link(:assigned_to, :css => 'td.assigned-to > a')
  link(:edit_issue, :css => 'a.icon-edit')
  link(:issue_link, :css => 'div#flash_notice > a')
  link(:log_time_link, :css => 'a.icon-time-add')
  link(:spent_time, :css => 'td.spent-time > a')
  link(:watch_issue, :css => 'a.icon-fav-off')
  select_list(:assignee_select, :id => 'issue_assigned_to_id')
  select_list(:status_select, :id => 'issue_status_id')
  unordered_list(:watchers_list, :css => 'ul.watchers')

  def assign_user(user)
    self.edit_issue
    self.assignee_select = user.full_name
    submit
  end

  def get_current_issue_id
    issue_link_element.when_present.attribute('href').split('/').last
  end

  def get_spent_time
    spent_time_element.when_present.attribute('text').gsub(/[^\d+\.\d+]/, '').to_i
  end

  def get_assigned_user_full_name
    assigned_to_element.when_present.text
  end

  def close_issue
    self.edit_issue
    self.status_select = 'Closed'
    submit
  end

  def is_closed?
    self.issue_status == 'Closed' ? true : false
  end

  def watched_by?(user)
    self.watchers_list.include?(user.full_name) ? true : false
  end

end