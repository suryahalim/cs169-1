# Computer Science 169 - Berkeley Fall 2015

This repository holds Bytlyn webpage.



# Instructions

### Run the Server
After downloading the files, change the directory to cs169/bytlyn. Then, type rails server
```
$ rails server
```

### Tests
To run the testing, stay in the current directory (cs169/bytlyn) and run rake test.
```
$ rake test
```

This is the same as 
```
$ bundle exec rake test
```
After test is raked, to see coverage report, check cs169/bytlyn/coverage/index.html

### Automated UI Test
We use the Selenium IDE for Automated UI Testing. These are the steps to use the test.
1. Download Firefox browser [here](https://www.mozilla.org/en-US/firefox/new/?utm_source=google&utm_medium=paidsearch&utm_campaign=sem2015Q4&utm_content=brand)
2. Download the Selenium IDE (recommended through the Firefox browser) [here](http://release.seleniumhq.org/selenium-ide/2.9.0/selenium-ide-2.9.0.xpi)
3. Run Firefox, select the Selenium IDE plugin at the top right of your browser.
4. File > Open Test Suites > (choose the test_suite - without number in the automated_ui_test folder)
5. Make sure the database is in a clean state by running
    ```
    rake db:reset
    ```
6. Make sure the server is also running
    ```
    rails server
    ```
7. Click the button "Play entire test suite"



To run a specific test, use: bundle exec rake test test/... (the directory). For example, to run waitlist_routes_test.rb inside integration test, use: bundle exec rake test test/integration/waitlist_routes_test.rb

```
$ bundle exec rake test test/integration/waitlist_routes_test.rb
```

### Credit

<icon> Restaurant by Federico Panzano from the Noun Project
