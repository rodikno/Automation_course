class CreateVersionPage
  include PageObject

  page_url 'http://demo.redmine.org/projects/<%=params[:project_name]%>/versions/new?back_url='

  text_field(:name, :id => 'version_name')
  text_field(:description, :id => 'version_description')
  button(:create, :name => 'commit')

  def create_version(name = 'Default')
    self.name = name
    self.description = "Some version"
    create
  end
end