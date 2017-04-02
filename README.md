# Automation_course
Tasks and homework from ITLabs Test Automation course

# Description
This is the Automated Testing Framework which is dedicated to be runned on http://demo.redmine.org/
The project is made as an educational within ITLabs QA Automation course.
It uses RSpec and Cucumber as a BDD tools, Watir/Selenium Webdriver as a Browser Control tool.
Also project includes some additional tests and classes regarding Trello (Trello object model) and some additional test tasks.

# How to run it
To run the project please clone this repository and checkout `master` branch.
You have to use Bundler gem to be able to install all dependencies automatically using Gemfile attached
- Use `gem install bundler` to install Bundler first (as a dependency manager gem)
- Then run `bundle install` and it will install all gems specified in Gemfile with their own dependency gems

To run the tests please choose the one task from `Rakefile` and run
`rake some:task`, where `some` is a namespace and `task` is a task nested to the namespace.
