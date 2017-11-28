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

Modifying the database from the server command line:
    This is important because the website is not setup currently to delete,edit, create, or update certain things. If a database problem occurs because of a website malfunction, the only way to solve it may to manage the database from the command line. The following will explain how the databases relate to each other as well as a brief explanation of the syntax of creating, editing, and deleting database records.

    List of different databases:
        -Users
        -Attendance Record
        -Announcements
        -Approved Time Off
        -Coaching Sessions
        -Corrective Actions
        -Missed Hours(Not Currently Implemented as of 11/27/17)

    Creating Records

        In order to get to the production console that allows you to send commands to the database navigate to the directory containing the ruby on rails app. Then type the command "rails console --production" This will indicate that you are intending to edit the database for the production environment of the website.

        All database records, excluding announcements, belong or relate to a User record. As a result, the majority of records are created via a User record. For instance, if you would like to create a corrective action for a User "Joe," you would create it from the User record. So you would have to first find the User "Joe." The following is an example of what may be typed in the console.

        #select user
        user = User.find(<joes user id number>)
            or 
        user = User.find_by(name: "Joe")#by replacing name: with any other database field such as email: you can find a user by that field

        #create corrective action
        corrective = user.corrective.build(description: "Description", supervisor: "Supervisor name", typeOf: "Type Of Corrective Action", plan: "Plan", action: "Action")
            or 
        corrective = user.corrective.build() #This will initiate a corrective action record with every field instantiated as nil except the automatically generated fields such as                                            #created_at and user_id

        #save action
        corrective.save

        If any error appears, repeat the most recent command with the suggested changes to resolve the error. Most errors will be caused by syntax or validation that is performed upon a database record creation. To view these validations. Find the corresponding model.rb page in the model directory inside the app directory of the main directory. Every new database record can be created like this with the exception of User, Announcement, or Coach.

        In order to create a User, Announcement, or Coach record, you may input the following.

        user = User.new(<parameters for user record>)
        user.save
            or 
        coach = Coach.new(<parameters for coach record>)
        coach.save
            or 
        announcement = Announcement.new(<parameters for announcement record>)

        If you would like to see the different parameters for a record simply type the name of that database, example "Coach" or "User." This will display each field of the database record and the datatype stored in that field, string, datetime, integer, etc. 

        NOTE: The first time you upload the app to a new server, you will have to create the first Admin user via the server command line. Once that first user is created, everything else can normally be done from the website unless a malfunction occurs or you are doing something not intended to be done for the website.

        NOTE 2: attrecord database records are created automatically by the website when a user is first created. If you are creating a user via the server command line, you will also have to initiate a new attrecord for the user as well. Plans are currently in place to have this happen as part of User creation validation but has not been implemented as of (11/27/17). This implementation will reside in the "init" function in the file /app/models/user.rb.

    Updating and deleting Records
        In order to update or delete a record you will first need to find that record. This can be done the same way finding a user is described in the previous section. You can also find a record by getting all of the records and then searching for the id number of the record you would like to edit or delete. This can be done by the command:

            User.all
            Coach.all
            Announcement.all

        Or you can do it for a specific user by the command:

            user = User.find_by(name: "User's Name")
            user.corrective
            user.attrecord
            etc.

        Either of these commands will return an array of the database records. Selecting an object can be done as follows.

            user = User.find_by(name: "User's Name")
            correctives = user.corrective
            corrective = correctives[0]

        Once you have a record selected you can then update or delete the object. This is simply done by:

            #update record
            corrective.update_attributes(<attributes to be updated>)
                or
            #delete record
            corrective.delete
        Errors that occur in this process will be caused by the same reasons as database creation and can be resolved by the same processes. 