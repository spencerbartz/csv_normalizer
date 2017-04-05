Renewable Funding: Code Challenge
=================================

Welcome to My CSV Normalizer

1. This is a Ruby on Rails project using Rails 4.2.6 and Ruby 2.3.1. In case you
don't  have Nokogiri installed, [install it now](https://rubygems.org/gems/nokogiri/versions/1.7.0.1).
2. This project requires use of MySQL and knowledge of how to edit database.yml to configure it.
You must provide your own username and password for your local MySql instance.
3. I have tested the app on Ubuntu. I do not own or have access to a Mac.
4. Upon patching the repo with my submission, and getting mysql working,
open up a terminal, cd into the root directory and run

  ```bash
  % bundle install
  ```

  ```bash
  % rake db:drop && rake db:create && rake db:migrate
  ```
 This will set up your empty database.

5. To start the rails server run
  ```bash
  % rails s
  ```

6. Visit [localhost:3000](http://localhost:3000) and upload a file. The example file
included in this assignment as well as a malformed one are available in
*app/helpers/example_data.csv* and *app/helpers/bad_example.csv* respectively.
Attempting to upload malformed files is an idempotent operation that does not
alter the database in any way.

7. To run the test suite, cd into the app root directory and run
  ```bash
  % rspec spec
  ```
You should see a message with the output of 28 test cases with (96.47%) code coverage.

If you have trouble getting this it to work, please contact me at spencerbartz@gmail.com

**HAVE FUN!**
