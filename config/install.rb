# add the packages directory to load path
$LOAD_PATH << File.join(File.dirname(__FILE__), 'packages')

# require packages you need
packages = %w[essential utils ree_nginx_passenger mysql git libs]

packages.each do |package|
  require package
end

# build policy for role :web_stack
policy :passenger_stack_debian, :roles => :web_stack do
  requires :build_essential       # gcc, make, autotools...
  requires :utils                 # utils e.g. Emacs 23
  requires :ree_nginx_passenger   # ruby + server stack
  requires :database              # mysql
  requires :git                   # git
  requires :libs                  # libs e.g. libxml2-dev
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    recipes 'Capfile'
  end

  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end
