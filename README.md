# Installation script for Debian Squeeze Box
## pre :install
- log in to your VPS slice using root account
- execute ```passwd``` to change root password
- add sudo and create new user

    apt-get install sudo
    add user user_name

- update ```/etc/sudoers.tmp``` using ```visudo``` adding the
  following line

    user_name   ALL=(ALL) ALL

- now you are ready to go with installation

## :install
- execute in some directory ```$DIR```:
```git clone git://github.com/pibako/yaps.git```
- edit ```$DIR/config/deploy-example.rb``` setting the following:

    role :web_stack, "ip_address_or_url_of_your_box"
    set :user, "sudo_user_on_your_box"
    set :password, "password_for_sudo_user"

and save it as: ```$DIR/config/deploy.rb```

## post :install
- if the process has finished without errors be happy :-)
- you have just installed: emacs, git, ruby enterprise edition, nginx,
  passenger and mysql

