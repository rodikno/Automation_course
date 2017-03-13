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
      sh 'rspec -t trello -f html -o reports/rspec/html/trello-report.html'
    end
  end

  namespace :redmine do
    namespace :all do
      task :report_html do
        sh 'rspec -t redmine -f html -o reports/rspec/html/redmine-report.html'
      end

      task :report_junit do
        sh 'rspec -t redmine -f RspecJunitFormatter -o reports/rspec/junit/redmine-report.xml'
      end

      # This doesn't work now, need to investigate
      # task :report_allure do
      #   sh 'rspec -t redmine -f AllureRSpec::Formatter -o reports/rspec/allure/'
      # end
    end

    task :user do
      sh `rspec -t redmine -t user -f html -o reports/rspec/redmine-report.html`
    end

    task :project do
      sh `rspec -t redmine -t project -f html -o reports/rspec/redmine-report.html`
    end

    task :issue do
      sh `rspec -t redmine -t issue -f html -o reports/rspec/redmine-report.html`
    end

  end

end

