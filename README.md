Student Portal Application
==================
Steps to be followed

- Cloning the repo
    
            $ git clone https://github.com/ProjectAlex/laughing-adventure && cd laughing-adventure

- Install all dependencies. 
    
            $ sudo xargs -a requirements.txt apt-get install

- Install all the required gems
    
            $ bundle install --without production

- We have some sample database and config files that we will need to copy. Use the following command
    
            $ sh configure.sh
    
    Note: You will have to modify the file config/database.yml in case you want to shift the DB to mysql, postgres or something. 

- You will have to insert your gmail id and password in the config/environments/development.rb

- If you don't want to use your gmail id to send, then you might want to check the section below on using the Mailcatcher gem. 

- You will need to start solr by typing the following command. 
            $ rake sunspot:solr:start 

- Migrate the database
            $ rake db:migrate

- Start the Rails Server 

            $ rails s
- go to [localhost:3000]{localhost:3000} in your browser. 

- Development sites (The servers might not be on all the time) at 


        - [http://17748bc1.ngrok.com/]{http://17748bc1.ngrok.com/}
        - [https://56374f6c.ngrok.com/]{https://56374f6c.ngrok.com/}
	    - [https://alex.ngrok.com/]{https://alex.ngrok.com/}

Using the Mailcatcher gem
----------
- if you want to use mailcatcher, instead of sending emails, edit config/environments/development.rb accordingly

            $ gem install mailcatcher 
    
            $ mailcatcher
    
- on browser navigate to [http://127.0.0.1:1080/]{http://127.0.0.1:1080/} to view mails that were sent 

License
----------

This work is Licensed under the terms of the MIT License

Copyright (c) 2013 ProjectAlex
