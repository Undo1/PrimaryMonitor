set :rvm_ruby_version, '2.3.0@primarymonitor'
set :passenger_restart_with_touch, true

server 'soprimaries.charcoal-se.org',
  user: 'ubuntu',
  roles: %w{web db app},
  ssh_options: {
    user: 'ubuntu', # overrides user setting above
    keys: %w(/Users/parkererway/Dropbox/SSHKeys/EC2KeypairExample.pem),
    forward_agent: false,
    auth_methods: %w(publickey) 
 }
