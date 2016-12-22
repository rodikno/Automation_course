module MyExceptions

  class ProjectNotFoundError < StandardError
    def initialize(msg = "Project not found")
      super
    end
  end
end