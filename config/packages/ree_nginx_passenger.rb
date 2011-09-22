# ========= Info ========= #
# The phusion guys have made it so that you can install nginx and passenger in one
# fell swoop, it is for this reason and cleanliness that I haven't decided to install
# nginx and passenger separately, otherwise nginx ends up being dependent on passenger
# so that it can call --add-module within its configure statement - That in itself would
# be strange.
#
# And I added Ruby Enterprise Edition because nginx and passenger
# depends on it

package :ree_nginx_passenger do
  requires :ruby_enterprise
  requires :nginx
end

package :ruby_enterprise do
  description 'Ruby Enterprise Edition'
  requires :ree_libs

  version '1.8.7-2011.03'
  REE_PATH = "/usr/local/ruby-enterprise"
  binaries = %w(bundle erb gem irb rackup rails rake rdoc ree-version ri ruby testrb)

  source "http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-#{version}.tar.gz" do
    custom_install './installer --auto=/usr/local/ruby-enterprise'
    binaries.each {|bin| post :install, "ln -s #{REE_PATH}/bin/#{bin} /usr/local/bin/#{bin}" }
  end

  verify do
    has_directory install_path
    has_executable "#{REE_PATH}/bin/ruby"
    binaries.each {|bin| has_symlink "/usr/local/bin/#{bin}", "#{REE_PATH}/bin/#{bin}" }
  end
end

package :ree_libs do
  requires :build_essential

  apt %w(zlib1g-dev libreadline5-dev libssl-dev)

  verify do
    has_apt "zlib1g-dev libreadline5-dev libssl-dev"
  end
end

package :nginx  do
  puts "** Nginx installed by passenger gem **"
  requires :passenger
  nginx_file = File.join(File.dirname(__FILE__), 'nginx', 'init')
  nginx_text = File.read(nginx_file)

  push_text nginx_text, '/tmp/nginx' do
    post :install, "chmod +x /tmp/nginx"
  end
  runner 'mv /tmp/nginx /etc/init.d/nginx' do
    post :install, "/usr/sbin/update-rc.d -f nginx defaults"
    post :install, "/etc/init.d/nginx start"
  end

  verify do
    has_executable "/usr/local/nginx/sbin/nginx"
    has_file "/etc/init.d/nginx"
  end
end

package :passenger do
  description 'Phusion Passenger (mod_rails)'
  version '3.0.9'

  requires :ruby_enterprise
  requires :passenger_libs

  binaries = %w(passenger-config passenger-install-nginx-module passenger-install-apache2-module passenger-make-enterprisey passenger-memory-stats passenger-spawn-server passenger-status passenger-stress-test)

  gem 'passenger', :version => version do
    # Install nginx and the module
    binaries.each {|bin| post :install, "ln -s #{REE_PATH}/bin/#{bin} /usr/local/bin/#{bin}"}
    post :install, "passenger-install-nginx-module --auto --auto-download --prefix=/usr/local/nginx"
    build_docs false
  end

  verify do
    has_gem "passenger", version
    binaries.each {|bin| has_symlink "/usr/local/bin/#{bin}", "#{REE_PATH}/bin/#{bin}" }
  end
end

package :passenger_libs do
  apt "libcurl4-openssl-dev"

  verify do
    has_apt "libcurl4-openssl-dev"
  end
end
