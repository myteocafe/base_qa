module People_Api_Helper

  def self.people_list
    begin
      service_url = Utilities::get_be_base_url + "/api/teocafe/people"
      get_info = {:url => service_url}
      return API_Helper::send_get(get_info)
    rescue => error
      API_Helper::handle_error(__method__, service_url, error, "Error while trying to get information about customer enrollment")
    end
  end

  def self.people_detail(customer)
    begin
      service_url = Utilities::get_be_base_url + "/api/teocafe/people/#{customer[:dni]}"
      get_info = {:url => service_url}
      return API_Helper::send_get(get_info)
    rescue => error
      API_Helper::handle_error(__method__, service_url, error, "Error while trying to get information about customer enrollment")
    end
  end

end

World(People_Api_Helper)