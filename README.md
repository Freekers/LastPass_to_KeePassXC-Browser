# LastPass_to_KeePassXC-Browser.R
This R script will clean up your LastPass csv export to increase compatibility with KeePassXC-Browser's Autofil.

It will extract the top level domain from each and every site in your export.

After running convert.R, re-import the fixed .csv import as a LastPass export or Comma Separated file and you should be good to go. Just make sure to edit the file paths before running convert.R.

Note: I am new to R. This script can probably be optimized in many ways, feel free to submit a PR.

# DISCLAIMER
I made this script to meet my requirements. It did the job well for me but your milage might vary!

USE AT OWN RISK, ALWAYS MAKE BACKUPS OF YOUR DATABASE BEFORE USING THIS SCRIPT
