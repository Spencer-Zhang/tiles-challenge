# The Tiles Challenge 

This repo is hosted on Heroku at http://tiles-challenge-6178.herokuapp.com/

For the moment, I've turned off the Sidekiq worker on Heroku, so click counts will not be updated. You can check on the status of Sidekiq queues here:

http://tiles-challenge-6178.herokuapp.com/sidekiq/


## Specs

I've written feature specs for this project using RSpec, Capybara, and Selenium. Chrome-driver is needed to run the specs with Selenium. I used Homebrew to install chromedriver on my machine.

```brew install chromedriver```
