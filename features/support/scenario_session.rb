class Scenario_Session

  attr_accessor :start_date_time

  def customer
    @customer ||= nil
  end

  def customer=(customer_name)
    @customer = Data_Access::get_customer(customer_name)
  end

  def update_customer=(customer)
    @customer = customer
  end


  def all
    Data_Access::all
  end


  #######for api#########
  def current_response
    @current_response ||= {}
  end

  def current_response=(current_response)
    @current_response = {:headers =>  current_response.headers, :body => API_Helper::get_response_body(current_response), :code => current_response.code }
  end
  #######################

  def save_any_data=(data)
    @any_data = data
  end

  def get_any_data
    @any_data
  end


end
