require 'faraday'
require './Main_Tasks/Exceptions/my_exceptions'

module OurModule

  include MyExceptions

  def get_http_response_code(url)
    response = Faraday.get(url)
    response.status
  end

  def find_element_by_name(name)
    @driver.find_element(:name, name)
  end

  def find_element_by_id(id)
    @driver.find_element(:id, id)
  end

  def find_element_by_class(classname)
    @driver.find_element(:class, classname)
  end

  def find_elements_by_class(classname)
    @driver.find_elements(:class, classname)
  end

  def find_element_by_css(css_string)
    @driver.find_element(:css, css_string)
  end

  def find_elements_by_css(css_string)
    @driver.find_elements(:css, css_string)
  end

  def find_element_by_xpath(xpath_string)
    @driver.find_element(:xpath, xpath_string)
  end

  def navigate_to(url)
    @driver.navigate.to(url)
  end

  # @param [RedmineUser] user
  def register_user(user)
    @driver.navigate.to 'http://demo.redmine.org'
    find_element_by_class('register').click
    @wait.until {find_element_by_id('user_login').displayed?}

    user_login = user.login
    password = user.password
    firstname = user.first_name
    lastname = user.last_name
    user_email = user.email

    find_element_by_id('user_login').send_keys user_login
    find_element_by_id('user_password').send_keys password
    find_element_by_id('user_password_confirmation').send_keys password
    find_element_by_id('user_firstname').send_keys firstname
    find_element_by_id('user_lastname').send_keys lastname
    find_element_by_id('user_mail').send_keys user_email
    find_element_by_name('commit').click
    user_id = find_element_by_css('div#loggedas>a').attribute('href').split('/').last
    user.id = user_id

    user
  end

  def log_out
    find_element_by_class('logout').click
  end

  def log_in(login, password)
    find_element_by_class('login').click

    username_field = find_element_by_name('username')

    @wait.until{username_field.displayed?}

    username_field.send_keys(login)
    find_element_by_name('password').send_keys(password)
    find_element_by_name('login').click
  end

  def create_project(name = 'rodioba_project_' + rand(99999).to_s)
    @driver.navigate.to('http://demo.redmine.org/projects')
    find_element_by_css('a.icon-add').click

    @wait.until{@driver.current_url == 'http://demo.redmine.org/projects/new'}

    find_element_by_id('project_name').send_keys(name)
    find_element_by_name('commit').click

    name
  end

  def open_random_project(name, retry_attempts = 3)
    project_name = name
    random_project_url = "http://demo.redmine.org/projects/#{project_name}"
    i = 0
    begin
      i += 1
      project_exists?(random_project_url)
    rescue ProjectNotFoundError
      create_project(project_name)
      retry if i < retry_attempts
    end
  end

  def create_issue(issue_type)

    capitalized_issue_type = issue_type.to_s.capitalize!
    issue_name = capitalized_issue_type + '_' + rand(99999).to_s
    issue_type_hash = {'Bug' => 1, 'Feature' => 2, 'Support' => 3}

    @driver.find_element(:class, 'new-issue').click

    @wait.until{find_element_by_id('issue_tracker_id').displayed?}

    my_select = Selenium::WebDriver::Support::Select.new(find_element_by_xpath("//select[@id='issue_tracker_id']"))
    my_select.select_by(:text, capitalized_issue_type)

    #some magic from Dima here
    @wait.until{find_element_by_css("#issue_tracker_id [value='#{issue_type_hash[capitalized_issue_type]}']").attribute('selected') == 'true'}
    @wait.until{find_element_by_id('ajax-indicator').attribute('style') == 'display: none;'}

    find_element_by_id('issue_subject').send_keys(issue_name)
    find_element_by_name('commit').click

    @wait.until{find_element_by_xpath("//a[@title='#{issue_name}']").displayed?}

    issue_url_slug = find_element_by_xpath("//a[@title='#{issue_name}']").attribute("href").split('/').last

    created_issue_url_slug = @driver.current_url.split('/').last

    #return hash with all issue data required
    {:issue_title => issue_name, :visible_issue_id => issue_url_slug, :created_issue_id => created_issue_url_slug}
  end

  def is_issue_watched?
    if find_element_by_css("a.icon-fav").displayed?
      true
    end
  end

  def project_exists?(project_url)
    status = get_http_response_code(project_url)
    if status == 200
      true
    else
      raise ProjectNotFoundError, "Project not found: #{project_url}"
    end
  end
end