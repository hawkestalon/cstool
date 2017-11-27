# README

Ruby Version: 2.2.6
Rails Version: 5.1.3

Important Dependencies:
    Database: Sqlite (Not Postgresql or Mysql)
    Security: bcrypt gem used to hash passwords and session tokens
    Javascript file defaults to have //require tree when a rails app is created. I had to delete this line of code in order for the app to run on a windows machine. Does
        not effect Linux server deployments however. 

Things I think you should know:
    /config/routes.rb file routes urls to the right controller method. 

    To prevent sql injection and other security vulnerabilities, each controller will only allow specific paramters to be accepted into the database changes via
        the private user_params method.

    "logged_in" and "current_user" functions are located in /app/helpers/sessions_helper.rb. These functions are used by most controllers to control permissions for each
        user.

    I have not written any test classes to automate the testing of the app. All testing has been manually done.

    This site has not gone under substantial security testing. Various xss and sql injection attacks have been periodically tested, however. Passwords are hashed before
        they are stored as well.

    Model file contains the validation requirements for each of the database records. If a record does not meet these requirements it will not be committed to the database
        As of this writing, a lot of validation still needs to be added. 
    
Deployment: 
    I deployed this app using Nginx and Phusion Passenger and followed the tutorial found on Phusion Passenger's website.
    The app is setup in a way that should allow it to run on different web server software such as Apache. 

    1. Make sure the most updated code is where it needs to be on the server and ensure you are in the correct directory before performing commands. 
    2. Install dependencies with the "bundle install" command.
    3. Perform Database migration and precompile assets with the "bundle exec rake assets:precompile db:migrate RAILS_ENV=production" command.
    4. Restart the app to effect the changes ("passenger-config restart-app", if using passenger).
    5. Restart the nginx service with service nginx restart, if necessary.

    NOTE: In order to deploy to Heroku, the database would have to be changed to Postgresql. The rest of the app is not configured to run this way. Substantial changes 
        would have to be made. I do not reccommend this, nor is this app intended to be deployed to Heroku.
