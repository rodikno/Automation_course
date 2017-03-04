
class VersionSettingsPage < BasicPage
  include PageObject

  page_url BASIC_URL + '/projects/<%=params[:project_name]%>/settings/versions'

  div(:success_message, :id => 'flash_notice')
end