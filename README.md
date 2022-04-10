This Ruby on Rails application is an employee and store management system for A&M Creamery. It was built as the final project for 67-272: Application Design and Development.
=

This particular version is in Rails 5.2.7 because of some callback bugs in the current 6.0 version of Rails.

The development database can be created and populated with a large number of realistic, but still fictitious, data by running the command `rails db:populate` on the command line of the main directory.  This will take a few minutes, but will give you:

1. Two admins, Alex and Mark.
2. Seven stores in the Pittsburgh area and a manager that is assigned to each.
3. 250 regular employees; each has one to three assignments. 
