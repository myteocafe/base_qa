require 'rspec'
require 'fig_newton'
require 'require_all'
require 'page-object'
require 'factory_bot'
require 'appium_lib'
require 'logger'
require 'rest-client'
require 'webdrivers'


if "#{FigNewton.proxy_enabled}" == 'true'
  Webdrivers.configure do |config|
    config.proxy_addr = ENV['BCP_PROXY_ADDRESS']
    config.proxy_port = ENV['BCP_PROXY_PORT']
    config.proxy_user = ENV['BCP_USR_CRED']
    config.proxy_pass = ENV['BCP_USR_PW']
  end
end

World(PageObject::PageFactory)
World(FactoryBot::Syntax::Methods)
