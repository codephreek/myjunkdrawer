import json
import pprint
import sys, string

#################################################################################
def printUsageAndExit():
    print "usage:   file"
    sys.exit()


try:
    file1 = sys.argv[1]
except IndexError:
    printUsageAndExit()

if file1 == "--help":
    printUsageAndExit()
    
if file1 == "?":
    printUsageAndExit()


print "FILE - " + file1


json_data = open(file1)
 
# the value returned from json.load is a Python dictionary. 
data = json.load(json_data)
 
# use pprint to make the output more readable
#pprint.pprint(data)
json_data.close()
 

print "|| *Type* || *Key* || *Summary* || *Resolution* || *Linked Issues* || *Fix Versions* || *Release Notes* || *Time In Status* || *Priority* ||"

big = [];
for x in data["issues"]:
    
    result = [];
    
    # Issue Type
    result.append(x["fields"]["issuetype"]["name"])
    # Key
    result.append(x["key"])
    # Summary
    result.append(x["fields"]["summary"])
    # Resolution
    result.append(x["fields"]["resolution"])
    # Linked Issues
    links = [];
    for ils in x["fields"]["issuelinks"]:
        if "inwardIssue" in ils:
            links.append(ils["inwardIssue"]["key"]) 
        else:
            links.append(ils["outwardIssue"]["key"]) 
    result.append(','.join(map(str, links)))
    # Fixed Versions  
    fixVersions = [];
    for fve in x["fields"]["fixVersions"]:
        fixVersions.append(fve["name"])
    result.append(','.join(map(str, fixVersions)))
    # Release Notes
    result.append(x["fields"]["customfield_10680"])
    # Time In Status
    result.append(x["fields"]["customfield_10586"])
    # Priority
    result.append(x["fields"]["priority"]["name"])
    big.append('|'.join(map(str, result)))


for ele in big:
    print "|" + ele + "|"
