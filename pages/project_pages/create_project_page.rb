require 'faker'

class CreateProjectPage < BasicPage
  include PageObject

  page_url 'http://demo.redmine.org/projects/new'

  text_field(:name, :id => 'project_name')
  text_area(:description, :id => 'project_description')
  button(:create, :name => 'commit')
  button(:create_and_continue, :name => 'continue')

  def create_project(project)
    self.name = project.name
    self.description = Faker::Hipster.sentence
    create
  end
end