# DISCLAIMER: I made this script to meet my requirements. It did the job well for me but your milage might vary!
# USE AT OWN RISK, ALWAYS MAKE BACKUPS OF YOUR DATABASE BEFORE USING THIS SCRIPT.

# Needed Libraries
#devtools::install_github("jayjacobs/tldextract")
library(tldextract)
library(stringr)

# Update .TLDs
tld <- getTLD()

# Read .CSV
lastpass <- fread("C:\\PATH\\TO\\YOUR\\LASTPASS\\EXTRACT.csv")

# Fix for credentials without URL:
# If URL is either just http:// or https://, use Title as URL
lastpass$URL <- ifelse(lastpass$URL %in% c("http://", "https://"), paste0(lastpass$URL, lastpass$Title), lastpass$URL)

# Extract Protocol from Domains
protocol <-  str_extract(lastpass$URL, "^https?://")

# Get Domains without Protocol and Jibber Jabber after the forwardslash
cleanurl <- sub("^https?://", "\\1", lastpass$URL)
cleanurl <- sub("/.*", "", cleanurl)
cleanurl <- sub(":.*", "", cleanurl)

# Extract Top Level Domains
hosts <- tldextract(c(cleanurl), tldnames=getTLD())

# Fix for IPs:
# IPs are not recognized by 'tldextract' as domains and will become NA
setDT(hosts)[is.na(domain), domain := host]

# Merge domains with their corresponding tld, using . as seperator
hosts <- paste(hosts$domain,hosts$tld,sep=".")

# Remove .NA that was appended to IPs due to merging above (dirty fix)
hosts <- sub(".NA.*", "", hosts)

# Overwrite "Title" with domain+tld, since KeePass seems to match on that as well
# Unless it's a Secure Note, else the title of the note gets lost.
# Unless it's Username, Password AND URL are empty, else the title of the note gets lost as well.
# Unless the credential has no URL (Very rare cases, I had 1 in my dataset (N=847))
# NOTE: Multiple approaches are possible here, pick one that suits you. I use the uncommented one, as it should match all cases.
lastpass = within(lastpass, {
  #Title = ifelse((lastpass$Group == "lastpass/Secure Notes"), lastpass$Title, hosts) #Full match, ugly
  #Title = ifelse(grepl("Secure Notes",lastpass$Group), lastpass$Title, hosts)
  #Title = ifelse((lastpass$Username == "" & lastpass$Password == "" & lastpass$URL == ""), lastpass$Title, hosts)
  Title = ifelse((lastpass$URL == ""), lastpass$Title, hosts) #If you have NAs (properly defined missings), change "" to "NA".
})

# Merge protocol to their corresponding top level domain, no seperator
hosts <- paste(protocol, hosts ,sep="")

# Overwrite URL column in original dataset
lastpass$URL <- paste(hosts)

# Save as CSV
fwrite(lastpass, "C:\\PATH\\TO\\YOUR\\LASTPASS\\EXTRACT_FIXED.csv")
