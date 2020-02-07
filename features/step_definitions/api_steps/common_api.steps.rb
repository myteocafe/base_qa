Transform /^(\d+)$/ do |number|
  number.to_i
end

Transform /^table:code,name,amount/ do |table|
  table.map_column!(:amount) {|count| count.to_i }
  table
end

Then(/^the response status should be (\d+)$/) do |status_code|
  @scenario_session.current_response[:code].should == status_code
end

Then(/^el estado de la respuesta debe ser (\d+)$/) do |status_code|
  @scenario_session.current_response[:code].should == status_code
end

Given(/^the user "([^"]*)" is BCP and Cashless client$/) do |customer_name|
  @scenario_session.customer= customer_name
end

And(/^the system returns an empty array of errors$/) do
  @scenario_session.current_response[:body]['status'].should == true
  @scenario_session.current_response[:body]['response'].key?('code').should == false
end

And(/^the system returns the error code "([^"]*)"$/) do |error_expected|
  #@scenario_session.current_response[:body]['status'].should == false
  @scenario_session.current_response[:body].key?('code').should == true
  @scenario_session.current_response[:body]['code'].should == error_expected
end



And(/^the system sends the confirmation message of the operation$/) do
  @scenario_session.current_response[:body]['status'].should == true
  @scenario_session.current_response[:body]['response']['isValid'].should == true
end

And(/^the system sends the confirmation message of the operation key "([^"]*)" and value "([^"]*)"$/) do |key, value|
  if value=='true' || value=='false' then val =  Utilities::to_boolean(value)  else val = value end
  @scenario_session.current_response[:body]['status'].should == true
  @scenario_session.current_response[:body]['response'][key].should == val
end


And(/^the system responds with status true and response null$/) do
  @scenario_session.current_response[:body]['status'].should == true
  @scenario_session.current_response[:body]['response'].should == nil
end
