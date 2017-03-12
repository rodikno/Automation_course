namespace :cucumber do

  #task to launch registration tests
  task :register do
    sh 'cucumber --tags @registration'
  end

  # more tasks where each has :register task as dependency
  task :user => :register do
    sh 'cucumber --tags @user'
  end

  task :project => :register do
    sh 'cucumber --tags @project'
  end

  task :issue => :register do
    sh 'cucumber --tags @issue'
  end

  # big task to run all tests excluding register with a :register task as a dependency
  task :without_registration => :register do
    sh 'cucumber --tags ~@registration'
  end

end

namespace :rspec do
  namespace :trello do
    task :all do
      sh 'rspec --tag trello --format html -o reports/rspec/trello-report.html'
    end
  end


  namespace :redmine do
    task :all do
      sh 'rspec --tag redmine --tag ~trello --format html -o reports/rspec/redmine-report.html'
    end

    task :user do
      sh `rspec --tag redmine --tag user --format html -o reports/rspec/redmine-report.html`
    end

    task :project do
      sh `rspec --tag redmine --tag project --format html -o reports/rspec/redmine-report.html`
    end

    task :issue do
      sh `rspec --tag redmine --tag issue --format html -o reports/rspec/redmine-report.html`
    end

  end

end

