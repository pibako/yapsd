# Installation script for Debian Squeeze Box

### WHY?

there is plenty of passenger-stack's out there but none of them work

## Procedure

### pre :install

log in to your VPS slice using root account and
execute ```passwd``` to change root password.
Add sudo and create new user:

    # apt-get install sudo
    # adduser user_name

update ```/etc/sudoers.tmp``` using ```visudo``` adding the following line

    user_name   ALL=(ALL) ALL

now you are ready to go with installation

### :install

execute in some directory ```$DIR```:
```git clone git://github.com/pibako/yaps.git```
edit ```$DIR/config/deploy-example.rb``` setting the following:

    role :web_stack, "ip_address_or_url_of_your_box"
    set :user, "sudo_user_on_your_box"
    set :password, "password_for_sudo_user"

and save it as: ```$DIR/config/deploy.rb```

### post :install

if the process has finished without errors be happy :-)
you have just installed: emacs, git, ruby enterprise edition, nginx,
passenger and mysql.
Now you should customize your box by hand

# Contributors

Thanks to Josh Goebel (yyyc514)

