
class VersionSettingsPage < BasicPage
  include PageObject

  page_url 'http://demo.redmine.org/projects/<%=params[:project_name]%>/settings/versions'

  div(:success_message, :id => 'flash_notice')
end