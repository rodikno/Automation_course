require 'faker'

class RedmineIssue

  attr_reader :subject, :description
  attr_accessor :assigned_user, :id, :type

  def initialize(params={})
    @subject = params[:subject]             || Faker::Hacker.adjective.capitalize + Faker::Hacker.noun.capitalize
    @description = params[:description]     || Faker::Hacker.say_something_smart
    @assigned_user = params[:assigned_user] || nil
    @type = params[:type]                   || 'Bug'
    @id = params[:id]                       || nil
  end

end