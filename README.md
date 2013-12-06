Student Portal Application
==================
Steps to be followed

- Step 1
    
    $ git clone https://github.com/ProjectAlex/laughing-adventure

    $ cd laughing-adventure
- Install all dependencies. 
    
    $ sudo xargs -a requirements.txt apt-get install
- Install all the required gems
    
    $ bundle install
- 

    $ cp config/database.example config/database.yml
    
    Note: You will have to modify the file config/database.yml in case you want to shift the DB to mysql, postgres or something. 
- 

    $ rake db:migrate
- Start the Rails Server 

    $ rails s
- go to localhost:3000 in your browser. 



A user has been created
name:common 
email:common@gmail.com
password:12345678
