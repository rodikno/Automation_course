require 'cucumber/rake/task'

namespace :cucumber do

  task :register do
    run_cucumber_task(@registration_task)
  end

  task :user => :register do
    run_cucumber_task(@user_task)
  end

  task :project => :register do
    run_cucumber_task(@project_task)
  end

  task :issue => :register do
    run_cucumber_task(@project_task)
  end

end

def run_cucumber_task(task)
  task.runner.run
end

@registration_task = Cucumber::Rake::Task.new(:registration) do |t|
  t.cucumber_opts = %w{--tags @registration}
  t.bundler = false
end


@user_task = Cucumber::Rake::Task.new(:user) do |t|
  t.cucumber_opts = %w{--tags @user}
  t.bundler = false
end


@project_task = Cucumber::Rake::Task.new(:project) do |t|
  t.cucumber_opts = %w{--tags @project}
  t.bundler = false
end

@issue_task = Cucumber::Rake::Task.new(:issue) do |t|
  t.cucumber_opts = %w{--tags @issue}
  t.bundler = false
end