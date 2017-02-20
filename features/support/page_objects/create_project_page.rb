class CreateProjectPage
  include PageObject

  page_url 'http://demo.redmine.org/projects/new'

  text_field(:name, :id => 'project_name')
  text_area(:description, :id => 'project_description')
  button(:create, :name => 'commit')
  button(:create_and_continue, :name => 'continue')

  def create_project(name)
    self.name = name
    self.description = "Some description"
    create
  end
end