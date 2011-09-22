package :mysql, :provides => :database do
  description 'MySQL Database'

  apt %w(mysql-server mysql-client libmysqlclient-dev)

  verify do
    has_apt "mysql-server mysql-client libmysqlclient-dev"
    has_executable 'mysql'
  end

  optional :mysql_driver
end

package :mysql_driver, :provides => :ruby_database_driver do
  description 'Ruby MySQL database driver'

  gem 'mysql'

  verify do
    has_gem 'mysql'
  end

  requires :ruby_enterprise
end
