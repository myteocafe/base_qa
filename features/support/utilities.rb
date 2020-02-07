require 'active_support/time'
require 'watir'

module Utilities

  PLATFORM_NAME = 0
  PLATFORM_VERSION = 1
  DEVICE_NAME = 2
  ENVIRONMENT = 3
  APPIUM_VERSION = 4


  def self.get_config_mobile_caps
    @mobile_caps = ENV['CAPABILITIES'].split('/')
  end

  def self.get_platform_under_test
    platform = get_config_mobile_caps[PLATFORM_NAME].downcase.strip
    platform
  end

  def self.get_test_app_path
    "#{(get_platform_under_test == 'ios' ? "#{Dir.pwd}#{FigNewton.ios_app}" : "#{FigNewton.android_app}")}"
  end

  def self.establish_env_to_exe(execute_on)
    server_url = (execute_on == 'local' ? "#{FigNewton.falcon_appium_url}" : "#{FigNewton.docker_appium_url}")
    return server_url
  end

  def self.get_mobile_capabilities(scenario_name)

    puts "ENV['CAPABILITIES']: #{ENV['CAPABILITIES']}"
    @mobile_caps = get_config_mobile_caps
    platform = get_platform_under_test
    plat_version = @mobile_caps[PLATFORM_VERSION]
    device_name = @mobile_caps[DEVICE_NAME].gsub('_', ' ')
    file_path = get_test_app_path

    appium_server_env = establish_env_to_exe(@mobile_caps[ENVIRONMENT].downcase.strip)


    desired_caps =
        {
            caps: {
                platformName: platform,
                platformVersion: plat_version,
                deviceName: device_name,
                app: file_path,
                name: scenario_name,
                connectHardwareKeyboard: false,
                noReset: false
            },
            appium_lib:
                {
                    server_url: appium_server_env
                }
        }

    return desired_caps
  end

  def self.get_be_base_url
    FigNewton.base_url
  end

  def self.get_base_url_keyboard
    FigNewton.base_url_keyboard
  end

  def self.get_base_url_encrypt
    FigNewton.base_url_encrypt
  end

  def self.get_axioma_base_url
    FigNewton.axioma_url
  end

  def self.get_oauth_url
    FigNewton.oauth_url
  end

  def self.get_web_url
    FigNewton.url_web
  end

  def self.get_web_onboarding
    FigNewton.url_onboarding
  end

  def self.get_web_ecommerce
    FigNewton.url_platanitos
  end

  def self.replace_date(date)
    new_date = date
    if date.nil?
      return date
    elsif date.include? 'Date.today' and !date.nil?
      #new_date = eval(date).strftime("%d/%m/%Y").to_s
      new_date = eval(date).to_s
    elsif date.include? 'DateTime.now'
      new_date = eval(date).strftime("%d/%m/%Y %T").to_s
    end
    return new_date
  end

  def self.replace_time(time)
    new_time = time
    if time.include? 'Time.now' and !time.nil?
      new_time = eval(time)
    end
    return new_time
  end

  def self.to_boolean(value)
    return true if value == true || value =~ (/(true|t|yes|y|1)$/i)
    return false if value == false || value.blank? || value =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{value}\"")
  end

  def blank_nil(value)
    value.blank? ? nil : value
  end

  def self.send_sms(driver, phone_number, message)
    driver.send_sms(phone_number: phone_number, message: message)
  end

  def boolean_to_bit(value)
    return Constants::BIT_TRUE if value == true || value =~ (/(true|t|yes|y|1)$/i)
    return Constants::BIT_FALSE if value == false || value.blank? || value =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{value}\"")
  end

  def self.decode_base64(value)
    Base64.decode64(value)
  end

  def self.encode_base64(value)
    Base64.strict_encode64(value.to_s)
  end

  def self.cashless_mutual_auth_formula(value)
    ((value.to_i ** 2753) % 3233).to_i
  end

  # def self.is_element_present(how, what)
  #   @appium.manage.timeouts.implicit_wait = 0
  #   result = @appium.find_elements(how, what).size() > 0
  #   if result
  #     result = @appium.find_element(how, what).displayed?
  #   end
  #   @appium.manage.timeouts.implicit_wait = 30
  #   return result
  # end
  #

  def self.is_visible(element)
    begin
      return element.displayed?
    rescue
      return false
    end
  end

  def self.get_pin_position(pwd, array_pos)
    positions = []
    scramble = array_pos
    pwd.chars.each do |a|
      index = scramble.index(a)
      positions.push(index.to_s)
    end
    return positions
  end


  def self.maximize_browser_window(browser)
    screen_width = browser.execute_script('return screen.width;')
    screen_height = browser.execute_script('return screen.height;')
    browser.driver.manage.window.resize_to(screen_width, screen_height)
    browser.driver.manage.window.move_to(0, 0)
  end

  def self.local_capabilities
    puts "initializing #{ENV['BROWSER']} driver"
    return Watir::Browser.new ENV['BROWSER'].to_sym
  end


  def self.generate_token
    loop do
      token = SecureRandom.hex(10)
      break token if Data_Access.get_customer_for_accessToken(token).nil?
    end
  end

  def data_table_to_list(table, column_name = nil)
    list = []
    table.hashes.each do |array_item|
      if column_name.nil?
        column_name = table.column_names.last
      end
      list.push(array_item[column_name])
    end
    list
  end

end
World(Utilities)