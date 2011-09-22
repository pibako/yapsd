# Rename this file to deploy.rb

# Fill slice_url in - where you're installing your stack to
role :web_stack, "ip_address_or_url_of_your_box"

# Fill user in - if remote user is different to your local user
set :user, "sudo_user_on_your_box"

# Set password - optional
set :password, "password_for_sudo_user"

# You must use sudo if you follow the instruction - this is the default option
set :use_sudo, true

# Interactive mode
default_run_options[:pty] = true
