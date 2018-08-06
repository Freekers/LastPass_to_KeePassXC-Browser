# LastPass_to_KeePassXC-Browser.R
This R script will clean up your LastPass csv export to increase compatibility with KeePassXC-Browser's Autofil.

By default, KeePassXC-Browser uses a very strict matching pattern to determine which credential belongs to which URL, whereas LastPass uses a more fuzzy matching pattern.

For example, should you've created a credential saved with 'signup.website.com' as URL, LastPass knows that if you're trying to login to 'login.website.com', it should autofill the credential saved under the URL 'signup.website.com'. However, KeePassXC-Browser does not. So if you're going to switch from LastPass to KeePassXC-Browser you're going to have a bad time.... Hence I created this script to fix this. 

Basically, what it does, is stripping all URLs in your database to their bare top level domain. So 'signup.website.com' becomes 'website.com'. Therefore, should you visit 'login.website.com', KeePassXC-Browser will autofill	the credential stored under 'website.com'... Problem solved :)

After running convert.R, re-import the fixed .csv import as a LastPass export or Comma Separated file and you should be good to go. Just make sure to edit the file paths before running convert.R.

Note: I am new to R. This script can probably be optimized in many ways, feel free to submit a PR.

# DISCLAIMER
I made this script to meet my requirements. It did the job well for me but your milage might vary!

USE AT OWN RISK, ALWAYS MAKE BACKUPS OF YOUR DATABASE BEFORE USING THIS SCRIPT
