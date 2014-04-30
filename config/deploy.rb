# config/deploy.rb
set :app_name, "alex"
set :user, "mithul"
set :application, "alex"
role :web, 'localhost'
default_run_options[:pty] = true

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export do
    run "cd Alex && #{sudo} foreman export upstart /etc/init -a #{app_name} -u #{user} -l /var/#{app_name}/log"
  end

  desc "Start the application services"
  task :start do
    run "#{sudo} service #{app_name} start"
  end

  desc "Stop the application services"
  task :stop do
    run "#{sudo} service #{app_name} stop"
  end

  desc "Restart the application services"
  task :restart do
    run "#{sudo} service #{app_name} start || #{sudo} service #{app_name} restart"
  end
end

namespace :deploy do
  task :restart do
    foreman.export

    set :ssh_options, {
   verbose: :debug
}

    # on OS X the equivalent pid-finding command is `ps | grep '/puma' | head -n 1 | awk {'print $1'}`
    run "(kill -s SIGUSR1 $(ps -C ruby -F | grep '/puma' | awk {'print $2'})) || #{sudo} service #{app_name} restart"

    # foreman.restart # uncomment this (and comment line above) if we need to read changes to the procfile
  end
end
