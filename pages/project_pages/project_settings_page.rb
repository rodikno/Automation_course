
class ProjectSettingsPage < BasicPage
  include PageObject

  page_url BASIC_URL + '/projects/<%=params[:project_name]%>/settings'

  div(:success_message, :id => 'flash_notice')
  h1(:project_title, :css => 'div#header > h1')

end