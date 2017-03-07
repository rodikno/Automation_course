
class ProjectOverviewPage < BasicPage
  include PageObject

  page_url BASIC_URL + '/projects/<%=params[:project_name]%>'

  h1(:project_title, :css => '#header > h1')

end