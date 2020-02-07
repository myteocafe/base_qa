Given(/^Existen personas en el listado$/) do
  sleep 1
end

When(/^se solicita al sistema el listado$/) do
  @scenario_session.current_response= People_Api_Helper::people_list
end

And(/^el sistema retorna la información solicitada$/) do
  @scenario_session.current_response[:body]['success'].should == true
  @scenario_session.current_response[:body]['response']['employees'].each do |employe|
    employe['firstName'].nil?.should == false
    employe['lastName'].nil?.should == false
  end
  @scenario_session.current_response[:body]['response']['employees'].length.should == 3
end


When(/^se solicita al sistema el detalle del usuario$/) do
  @scenario_session.current_response= People_Api_Helper::people_detail(@scenario_session.customer)
end

And(/^el sistema retorna el detalle del usuario solicitado$/) do
  @scenario_session.current_response[:body]['success'].should == true
  @scenario_session.current_response[:body]['response']['Information']['firstName'].should == @scenario_session.customer[:first_name]
  @scenario_session.current_response[:body]['response']['Information']['lastName'].should == "#{@scenario_session.customer[:last_name]} #{@scenario_session.customer[:second_last_name]}"
  @scenario_session.current_response[:body]['response']['Information']['documentNumber'].should == @scenario_session.customer[:dni]
  @scenario_session.current_response[:body]['response']['Information']['phoneNumber'].should == @scenario_session.customer[:cellphone].to_s
  @scenario_session.current_response[:body]['response']['Information']['debt'].should_not ==  nil
  @scenario_session.current_response[:body]['errors'].length == 0
end

And(/^el monto de deuda es "([^"]*)"$/) do |debt|
  @scenario_session.current_response[:body]['response']['Information']['debt'].to_s.should ==  debt
end