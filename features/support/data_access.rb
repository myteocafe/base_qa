module Data_Access

  def self.load
    @@data = {}
    load_customers
  end

  def self.load_customers
    begin
      customers_list = get_data_from_directory("#{Dir.pwd}/config/data/customers/user_*.yml")
      @@data[:customers] = customers_list
      @@data[:customers].each do |customer|
        symbolize!(customer)
      end
      true
    rescue => error
      puts "There was a problem loading the test data. \n #{error.to_s}"
      false
    end
  end



  def self.symbolize!(hash)
    hash.keys.each do |key|
      case hash[key]
        when Hash
          new_key = key.respond_to?(:to_sym) ? key.to_sym : key
          hash[new_key] = hash.delete(key)
          symbolize!(hash[new_key])
        when Array
          new_key = key.respond_to?(:to_sym) ? key.to_sym : key
          hash[new_key] = hash.delete(key)
          hash[new_key].each do |item|
            symbolize!(item)
          end
        else
          new_key = key.respond_to?(:to_sym) ? key.to_sym : key
          hash[new_key] = hash.delete(key)
      end
    end

  end

  def self.get_data_from_directory(directory)
    data_files_list = Dir[directory]
    data_list = []
    data_files_list.each do |yml_file_name|
      yml_info = YAML.load_file("#{yml_file_name}")
      if yml_info!=false
        data_list.push(yml_info)
      end
    end
    data_list
  end


  def self.get_customers
    @@data[:customers]
  end


  def self.get_customer(customer_name)
    get_customers.select { |customer| "#{customer[:first_name]} #{customer[:last_name]}" == customer_name }.first
  end

  def self.get_customer_for_accessToken(accessToken)
    get_customers.select { |customer| customer[:accessToken] == accessToken }.first
  end

  def self.all
    @@data
  end

end