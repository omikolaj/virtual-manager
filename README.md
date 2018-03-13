## Virtual Dealership Manager
Ruby on Rails application that mimics car dealership assets management. It uses Bootstrap for styling and JavaScript with jQuery. Users can sign up as employees or managers. This application implements security measures for authentication and authorization. As a manager user has the ability to generate reports, modify employees' permission levels and create and delete dealerships. Check it out,we need new employees and managers to join the family!

## Features
- Custom built authentication system
- Custom built authorization system with different permission levels
- OmniAuth Github strategy (Login with GitHub) 
- Full CRUD support (Create, Retrieve, Update, Delete) with complex inner joins relationships
- Asynchronous JavaScript and XML (AJAX) used to load 'Command Center', 'View All Dealerships' and 'View Vehicle' views
- With use of JavaScript fetch and jQuery user gets live feedback on validations when creating new dealerships 
- Handlebars templates (Easily maintainable and highly reusable templates) including partials and iterators
- '/dealerships', '/vehicles/:id', 'employees/:id' respond to .json requests using ActiveRecord serialization
- GitHub API integration, from the 'Developer' tab users can create new issues, list all open issues and fork the repository for this project, right from the 'Developer' view

## Usage
This application has been deployed to Heroku. You can find the live version on http://virtual-manager-js.herokuapp.com
After you have cloned the repository run "bundle install" and then run rake db:migrate. This application is set up to use postgreSQL database.

## Development
After cloning the repository run 'bundle install'. Run 'rake db:migrate' to set up the database schema. The application is set up to run the seed file to populate the database if it detects that the database is empty. 

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/'omikolaj'/virtual-dealership-manager. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License
This project is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT)