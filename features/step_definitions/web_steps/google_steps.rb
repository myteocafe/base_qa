Given(/^El usuario "([^"]*)" es un usuario registrado$/) do |customer_name|
  @scenario_session.customer = customer_name
end

When(/^El robot accede a Goole$/) do
  visit(GooglePage).loaded?.should == true
end

And(/^se busca al usuario por nickname$/) do
  nick_name = @scenario_session.customer[:nick_name]
  on(GooglePage).set_search(nick_name)
end

Then(/^el primer resultado de la búsqueda es accesado$/) do
  nick_name = @scenario_session.customer[:nick_name]
  on(GooglePage).get_first_google_result.downcase.include?(nick_name.downcase).should == true
end