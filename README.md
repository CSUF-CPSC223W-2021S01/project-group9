# project-group9
project-group9 created by GitHub Classroom

Monte Davityan 

Shiv Bhagat 

Justin Lee 

Dependencies:
Linkit: 
1. First download linkkit from https://github.com/plaid/plaid-link-ios/releases the 2.0.11 version. Download the zip version
2. Unzip the downloaded package
3. Inside FinanceTracker, double click on the project file (this should be the first item called FinanceTracker). 
4. Make sure you are on Targets > FinanceTracker
5. Scroll down to Frameworks, Libraries, and Embedded Content and click the + icon
6. Click Add Other, then Add Files then go to your unzipped folder (plaid-link-ios-ios-2.0.11) then click on the folder LinkKit.xcframework and press open

Charts:
1. sudo gem install cocoapods (if you get an error try: sudo gem install cocoapods -v 1.8.4)
2. cd to the project directory
3. pod init
4. open Podfile
5. Type pod 'Charts' before target 'FinanceTrackerTests' do
6. Save it and close the file
7. pod install (in the terminal)
8. open FinanceTracker.xcworkspace

To authenticate: 
1. Press the connect to bank account
2. Choose any bank
3. The username is: user_good
4. The password is: pass_good
