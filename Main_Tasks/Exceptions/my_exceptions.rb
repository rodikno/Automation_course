module MyExceptions

  class ProjectNotFoundError < StandardError
    def initialize(msg="The project not found")
      super
    end
  end
end