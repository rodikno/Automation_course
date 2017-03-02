class ProjectSettingsPage
  include PageObject

  page_url 'http://demo.redmine.org/projects/<%=params[:project_name]%>/settings'

  div(:success_message, :id => 'flash_notice')
  h1(:project_title, :css => 'div#header > h1')

end