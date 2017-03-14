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

  task :run_all do
    sh 'cucumber -f AllureCucumber::Formatter -o reports/allure/ -f junit -o reports/ -f html -o reports/report.html'
  end

  task :registration_allure do
    sh 'cucumber -t @registration -f AllureCucumber::Formatter -o reports/allure/'
  end

end

