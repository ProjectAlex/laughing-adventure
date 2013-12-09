namespace :bootstrap do
      desc "Add the default user"
      task :default_user => :environment do
        User.create( :name => 'default', :password => 'password' )
      end
end
