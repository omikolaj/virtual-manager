## Virtual Dealership Manager
Ruby on Rails application built with Postgres database that mimics car dealership assets management. Users can sign up as employees or managers. This application implements security measures for authentication and authorization. As a manager user has the ability to generate reports, modify employees' permission levels and create and delete dealerships. Check it out,we need new employees and managers to join the family!

## Usage
This application has been deployed to Heroku. You can find the live version on http://virtual-dealership.herokuapp.com
After you have cloned the repository run "bundle install" and then run rake db:migrate.

## Development
After cloning the repository run 'bundle install'. Run 'rake db:migrate' to set up the database schema. The application is set up to run the seed file to populate the database if it detects that the database is empty. 

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/'omikolaj'/virtual-dealership-manager. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License
Copyright 2018

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.