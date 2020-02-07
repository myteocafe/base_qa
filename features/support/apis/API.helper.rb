module API_Helper

  def self.send_get(info)
    unless info.key?(:headers)
      info[:headers] = {}
    end
    info[:headers]['Content-Type'] = "application/json"
    begin
      response = RestClient.get info[:url], info[:headers]
      print_r(info[:url], 'GET',response)
      if response.nil?
        print_nil_response_error(response, info[:url].to_s, info[:headers].to_s)
      else
        return response
      end

    rescue => error
      print_response_error(error, info[:url], info[:headers], info[:payload])
      return error.response
    end
  end

  def self.send_post(info)
    unless info.key?(:headers)
      info[:headers] = {}
    end
    unless info.key?(:payload)
      info[:payload] = {}
    end
    unless info[:headers].key?('Content-Type')
      info[:headers]['Content-Type'] = "application/json"
    end
    #info[:headers]['Content-Type'] = "application/json"
    begin
      response = RestClient.post info[:url], info[:payload], info[:headers]
      # print_response(response, info[:url], info[:headers], info[:payload])
      print_r(info[:url], 'POST',response)
      response

    rescue RestClient::ExceptionWithResponse => error
      # print_response_error(error, info[:url], info[:headers], info[:payload])
      error.response
    rescue Errno::ECONNREFUSED => error
      # print_nil_response_error(info[:url], info[:headers], error, info[:payload])
      nil
    end

  end

  def self.send_put(info)
    unless info.key?(:headers)
      info[:headers] = {}
    end
    unless info.key?(:payload)
      info[:payload] = {}
    end
    info[:headers]['Content-Type'] = "application/json"
    begin
      response = RestClient.put info[:url], info[:payload], info[:headers]
      #print_response(response, info[:url], info[:headers], info[:payload])
      response

    rescue RestClient::ExceptionWithResponse => error
      print_response_error(error, info[:url], info[:headers], info[:payload])
      error.response
    rescue Errno::ECONNREFUSED => error
      print_nil_response_error(info[:url], info[:headers], error, info[:payload])
      nil
    end

  end

  def self.send_delete(info)
    unless info.key?(:headers)
      info[:headers] = {}
    end
    unless info.key?(:payload)
      info[:payload] = {}
    end
    info[:headers]['Content-Type'] = "application/json"
    begin
      response = RestClient.delete info[:url], info[:headers]
      #print_response(response, info[:url], info[:headers], info[:payload])
      response

    rescue RestClient::ExceptionWithResponse => error
      print_response_error(error, info[:url], info[:headers], info[:payload])
      error.response
    rescue Errno::ECONNREFUSED => error
      print_nil_response_error(info[:url], info[:headers], error, info[:payload])
      nil
    end

  end


  def print_response(response, url, request_header, payload)
    puts "\n #### HTTP REQUEST | BEGIN ####"
    puts '\n --- REQUEST INFO --- '
    puts "\n REQUEST URL: #{url}"
    puts "\n REQUEST HEADER: \n#{request_header}"
    puts "\n REQUEST PAYLOAD: \n#{payload}"

    puts '\n --- RESPONSE INFO ---'
    puts "\n RESPONSE HEADER: \n#{response.headers}"
    puts "\n RESPONSE CODE: \n#{response.code}"
    puts "\n RESPONSE COOKIES: \n#{response.cookies}"
    puts "\n RESPONSE BODY: \n#{response.body}\n"
    puts "\n ###### HTTP REQUEST | END ######"
    puts '\n'
  end

  def self.print_response_error(error, url, header, payload)
    puts "\n #### HTTP GET ERROR ####\n#{error.inspect}"
    puts "\n -- GET REQUEST INFO --"
    puts "\n REQUEST URL: #{url}"
    puts "\n REQUEST HEADER: \n#{header}"
    puts "\n REQUEST PAYLOAD: \n#{payload}"
    puts "\n"
  end

  def self.print_nil_response_error(service_url, headers, error, payload=nil)

    if payload.nil?
      payload = {}
    end
    puts "\n<<< Response is nil:"
    puts " ERROR : #{error.inspect}"
    puts "Are these ENVIRONMENTS UP?:"
    puts " * Stark Backend on #{FigNewton.stark_backend_url}"
    puts "Is post payload correctly specified?"
    puts " URL : #{service_url}"
    puts "Headers: #{headers}"
    puts "Payload: #{payload}"
  end

  def self.hash_json(json)
    json=Data_Access.symbolize!(json)
  end

  def self.get_status_code(response)
    return response.code
  end

  def self.get_response_body(response)
    body = response.body.to_s.empty?  ? "{}" : response.body
    JSON.parse(body)
  end

  def self.get_success_result(response)
    @data = get_response_body(response)
    return @data["success"]
  end

  def self.print_r(path, rest_type, response)
    puts "Request #{rest_type}: " + path
    puts "Response: " + response.to_s.force_encoding("UTF-8")
    puts "Response Headers: " + response.headers.to_s
    puts "Response Code: "+ response.code.to_s
  end

  def self.handle_error(method_name, service_url, error, additional_info_desc=nil)
    if additional_info_desc.nil?
      additional_info_desc = "No additional info provided by #{method_name}"
    end
    fail("\n<<< ERROR ON #{method_name}: Error while trying to perform this method>>>
              Service URL: #{service_url}
              Response: #{@current_response.inspect}
         \nAdditional Info: #{additional_info_desc}
         \nShowing Error Description:#{error.inspect}")
  end

end
World(API_Helper)