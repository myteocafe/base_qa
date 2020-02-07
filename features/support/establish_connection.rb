
module EstablishConnection
  ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlserver',
      :host =>     FigNewton.db_sql_host,
      :database => FigNewton.db_sql_name,
      :username => FigNewton.db_sql_user,
      :password => FigNewton.db_sql_password
  )
end