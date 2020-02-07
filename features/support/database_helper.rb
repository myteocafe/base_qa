require 'active_record'

module Database_Helper

  def clean_database(table_list = nil)
    if table_list.nil?
      table_list = %w{ customer }
    end

    table_list.each do |table_name|
      table = "#{FigNewton.db_sql_name}.dbo.[#{table_name}]"
      ActiveRecord::Base.connection.execute("DELETE FROM #{table} WHERE id >= 0")
      ActiveRecord::Base.connection.execute("DBCC CHECKIDENT ([dbo.#{table_name}], RESEED, 0);")
    end
  end


  def create_full_data
    create_customer
    # create_web_users
    # create_providers
    # create_customers_to_be_enrolled
    # create_customers
    # create_notification
  end

  def create_customer
    Data_Access::get_customers.each do |customer|
      FactoryBot.create(:customer, nombre: customer[:first_name], apellido_paterno:  customer[:last_name])
    end
  end

  # def create_web_users
  #   Data_Access::get_web_users.each do |web_user|
  #     encrypt_pwd = Utilities::encrypt_pwd(web_user[:temp_password], web_user[:password])
  #     FactoryBot.create(:webUser, enabled: web_user[:enabled], user_name: web_user[:user_name], first_name: web_user[:first_name], middle_name: web_user[:middle_name],
  #                       last_name: web_user[:last_name], second_last_name: web_user[:second_last_name],
  #                        email: web_user[:email], cellphone: web_user[:cellphone],
  #                       islogin: web_user[:islogin], password: encrypt_pwd, temp_password: web_user[:temp_password])
  #   end
  # end
  #
  # def create_providers
  #   Data_Access::get_providers.each do |provider|
  #     provider_entity = FactoryBot.create(:provider, enabled: provider[:enabled], name: provider[:name], ruc: provider[:ruc],
  #                       email: provider[:email],
  #                       code: provider[:code], business_name: provider[:business_name].to_s.upcase,
  #                       program_member: provider[:program_member], url: provider[:url], order: provider[:order])
  #
  #     provider[:accounts].each do |account|
  #       FactoryBot.create(:providerAccount, enabled: account[:enabled], account_number: account[:account_number],
  #                         is_principal: account[:principal], provider: provider_entity)
  #     end
  #   end
  # end
  #
  #
  # def create_customers_to_be_enrolled
  #   Data_Access::get_customers.each do |customer|
  #     customer_entity = FactoryBot.create(:customerToBeEnrolled, customer[:model], enabled: customer[:enabled], first_name: customer[:first_name], middle_name: customer[:middle_name],
  #                                         last_name: customer[:last_name], second_last_name: customer[:second_last_name],
  #                                         document_number: customer[:dni], email: customer[:email], cellphone: customer[:cellphone],
  #                                         islogin: customer[:islogin], tem_password: Utilities::encrypt_pwd(true, customer[:password]))
  #     customer[:id_tobe_enrolled] = customer_entity.id
  #
  #     customer[:accounts].each do |account|
  #       FactoryBot.create(:customerAccountToBeEnrolled, account[:account_type], enabled: account[:enabled],
  #                         account_number: account[:account_number], label: account[:label],
  #                         customerToBeEnrolled: customer_entity)
  #     end
  #
  #   end
  #
  # end
  #
  # def create_customers
  #   order = 0
  #   Data_Access::get_customers_enrolled.each do |customer|
  #     customer_entity = FactoryBot.create(:customer, customer[:role], customer[:model],enabled: customer[:enabled], nick_name: customer[:nick_name], first_name: customer[:first_name],
  #                                         middle_name: customer[:middle_name], last_name: customer[:last_name],
  #                                         second_last_name: customer[:second_last_name], document_number: customer[:dni], email: customer[:email],
  #                                         cellphone: customer[:cellphone],
  #                                         is_easypay_approved: customer[:is_easypay_approved], is_tax_obligation: customer[:is_tax_obligation],
  #                                         is_data_protection_authorized: customer[:is_data_protection_authorized])
  #     customer[:id_customer] = customer_entity.id
  #
  #     Provider.all.each do |provider|
  #       customer_entity.providerCustomers.create(provider: provider).
  #           update(provider_customer_code: "#{customer[:first_name]}_#{provider[:code]}",
  #                  enabled: 1, providerCustomerOrder: order += 1)
  #     end
  #
  #     customer[:accounts].each do |account|
  #       FactoryBot.create(:account, account[:account_type], enabled: account[:enabled], card_number: account[:card_number],
  #                         account_number: account[:account_number], label: account[:label], is_blocked: account[:blocked], credit_amount: account[:credit_amount], credit_amount_available: account[:credit_amount_available],
  #                         customer: customer_entity)
  #     end
  #
  #     customer[:payments].each do |payment|
  #       provider_entity = Provider.where(:providerName => payment[:provider_name].to_s.upcase).last
  #
  #       payment_entity = FactoryBot.create(:payment, payment[:status], payment[:model],  enabled: payment[:enabled],
  #                                          transaction_date: Utilities::replace_date(payment[:transaction_date]),
  #
  #                                          due_date: Utilities::replace_date(payment[:due_date]), amount: payment[:amount],
  #                                          customer: customer_entity, provider: provider_entity)
  #
  #       payment[:transactions].each do |transaction|
  #         sourceAccountId, targetAccountId = source_account(transaction, customer_entity, provider_entity)
  #
  #         FactoryBot.create(:paymentTransaction, transaction[:status], transaction[:transaction_type], transaction[:amount_type],
  #                           payment[:transition],
  #                           transition_date: Utilities::replace_date(payment[:transaction_date]),
  #                           enabled: transaction[:enabled],
  #                           transaction_date: Utilities::replace_date(transaction[:transaction_date]), amount: transaction[:amount],
  #                           source_account_id: sourceAccountId,
  #                           target_account_id: targetAccountId,
  #                           payment: payment_entity)
  #
  #       end
  #
  #     end
  #   end
  # end
  #
  # def create_notification
  #   #TODO
  # end
  #
  # def source_account(payment_transaction, customer_entity, provider_entity)
  #   sourceAccountId = ""
  #   targetAccountId = ""
  #   if payment_transaction[:transaction_type] == 'easy_pay_to_provider' and payment_transaction[:amount_type] == 'principal_amount'
  #     provider_account_id = provider_entity.providerAccounts.where(:isPrincipal => 1).first.id
  #     account_pf_id = customer_entity.accounts.where(:accountTypeId => 1).first.id
  #     sourceAccountId = "CAC#{account_pf_id}"
  #     targetAccountId = "PAC#{provider_account_id}"
  #   end
  #   if payment_transaction[:transaction_type] == 'charge_account_to_easy_pay' and payment_transaction[:amount_type] == 'principal_amount'
  #     account_pf_id = customer_entity.accounts.where(:accountTypeId => 1).first.id
  #     account_ca_id = customer_entity.accounts.where(:accountTypeId => 5).first.id
  #     sourceAccountId = "CAC#{account_ca_id}"
  #     targetAccountId = "CAC#{account_pf_id}"
  #   end
  #   return sourceAccountId, targetAccountId
  # end



end
World(Database_Helper)
