require 'appium_lib'
require 'watir'
require 'active_record'
require 'webdrivers'



Before('@web_tests') do |scenario|
  set_scenario_session
  puts "Starting Web Execution for scenario: #{scenario.name}"
  @browser = Utilities.local_capabilities
  Utilities::maximize_browser_window(@browser)
  puts "\nBASE Web Tests are has started for scenario: #{scenario.name.upcase}"
end

After('@web_tests') do |scenario|
  @browser.close
end

Before('@api') do |scenario|
  set_scenario_session
end

After('@api') do |scenario|

end

Before ('@onceload') do
  Data_Access::load
  set_scenario_session
  $onceload ||= false
  unless $onceload
    #clean_database
    #create_full_data
    $onceload = true
  end
end

def set_scenario_session
  Data_Access::load
  #@redis = Redis.new
  #remove_all_redis_key
  #clean_database
  #create_full_data
  @scenario_session = Scenario_Session.new
end








