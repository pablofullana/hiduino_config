### Prerequisites
1. Make sure **ruby 2.2.3** is installed. Either **rvm** or **rbenv** will do the trick:
  - https://rvm.io
  - https://github.com/rbenv/rbenv
2. Make sure bundler gem is installed. Hint: `gem install bundler`


### Installation
Install the application by just running: `bundle install`


### Run it!
Run the application by simply running: `bundle exec rails server`


### Share it (as quick as possible)
**Note:** This is not production!

You can expose the port where the application is running at (defaulted to 3000) using ngrok:

1. Install **ngrok**. Installation details at: https://ngrok.com
2. Expose application portby running: `ngrok 3000`
