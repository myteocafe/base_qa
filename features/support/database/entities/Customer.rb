require 'rubygems'
require 'active_record'

class Customer < ActiveRecord::Base

  self.default_timezone = :local
  self.table_name = 'dbo.customer'
  self.primary_key = 'id'


end