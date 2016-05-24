module OurModule

  def register_user
    @driver.navigate.to 'http://demo.redmine.org'
    @driver.find_element(:class, 'register').click


    @wait.until {@driver.find_element(:id, 'user_login').displayed?}

    user_login = ('login' + rand(99999).to_s)
    password = 's0meP@ssw0rd'
    firstname = 'George'
    lastname = 'Aobumeyang'
    user_email = user_login + 'myuser@xxx.com'

    @driver.find_element(:id, 'user_login').send_keys user_login
    @driver.find_element(:id, 'user_password').send_keys password
    @driver.find_element(:id, 'user_password_confirmation').send_keys password
    @driver.find_element(:id, 'user_firstname').send_keys firstname
    @driver.find_element(:id, 'user_lastname').send_keys lastname
    @driver.find_element(:id, 'user_mail').send_keys user_email

    @driver.find_element(:name, 'commit').click
  end

  def log_out
    @driver.find_element(:class, 'logout').click
  end

  def log_in(login, password)
    @driver.find_element(:class, 'login').click
    @driver.find_element(:name, 'username').send_keys(login)
    @driver.find_element(:name, 'password').send_keys(password)
    @driver.find_element(:name,'login').click
  end

  def create_project
    random_number_string = rand(99999).to_s
    project_name = 'rodioba_project_' + random_number_string

    @driver.navigate.to('http://demo.redmine.org/projects')
    @driver.find_element(:css, 'a.icon-add').click

    @wait.until{@driver.current_url == 'http://demo.redmine.org/projects/new'}

    @driver.find_element(:id, 'project_name').send_keys(project_name)
    @driver.find_element(:name, 'commit').click
    project_name
  end

  def create_issue(issue_type)

    capitalized_issue_type = issue_type.to_s.capitalize!
    issue_name = capitalized_issue_type + '_' + rand(99999).to_s
    issue_type_hash = {'Bug' => 1, 'Feature' => 2, 'Support' => 3}

    register_user
    create_project

    @driver.find_element(:class, 'new-issue').click

    @wait.until{@driver.find_element(:id, 'issue_tracker_id').displayed?}

    my_select = Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, "//select[@id='issue_tracker_id']"))
    my_select.select_by(:text, capitalized_issue_type)

    #some magic from Dima here
    @wait.until{@driver.find_element(:css, "#issue_tracker_id [value='#{issue_type_hash[capitalized_issue_type]}']").attribute('selected') == 'true'}

    @driver.find_element(:id, 'issue_subject').send_keys(issue_name)
    @driver.find_element(:name, 'commit').click

    @wait.until{@driver.find_element(:xpath, "//a[@title='#{issue_name}']").displayed?}

    issue_url_slug = @driver.find_element(:xpath, "//a[@title='#{issue_name}']").attribute("href").split('/').last
    created_issue_url_slug = @driver.current_url.split('/').last

    #return hash with all issue data required
    {:issue_name => issue_name, :issue_url_slug => issue_url_slug, :created_issue_url_slug => created_issue_url_slug}
  end
end