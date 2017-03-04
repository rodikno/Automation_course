
class ProjectOverviewPage < BasicPage
  include PageObject

  page_url 'http://demo.redmine.org/projects/<%=params[:project_name]%>'

  h1(:project_title, :css => '#header > h1')

end