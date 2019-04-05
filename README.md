# COTA

COTA is a platform built for assessing interview candidates for [ClearStack](http://clearstack.io/)

## Steps to run this project

- Clone this repository
- Install MYSQL by running `brew install mysql` and complete the initial setup
- Run a mysql server `mysql -u root -p<password>`
- Create a database for the project `CREATE DATABASE cota_development;`
- Run `bundle install` to install all the required dependencies

- Edit the `config/database.yml` with the password for DB

  ```
  password: <password>
  ```

- Run `rake db:migrate`
- Run `rails s` to run the server
- Run `rake jobs:work` to start the worker for Excel sheets
