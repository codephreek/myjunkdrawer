import json
import pprint
import sys, string

#################################################################################
def printUsageAndExit():
    print "usage:   file"
    sys.exit()

#################################################################################
def bTime(amount):

    # time is in milliseconds
    amount = amount / 1000

    yrs = 0;
    hrs = 0;
    mins = 0;
    secs = 0;
    days = 0;
    if amount > 31536000:
        yrs = amount/31536000
        amount = amount - (31536000 * yrs);
    if amount > 86400:
        days = amount/86400;
        amount = amount - (86400 * days);   
    if amount > 3600:
        hrs = amount/3600;
        amount = amount - (3600 * hrs);
    if amount > 60:
        mins = amount/60
        amount = amount - (60 * mins);
    secs = amount    

    return( '%d/%d/%d:%d:%d' % (yrs, days, hrs, mins, secs))

#################################################################################
def getKeyDescription(key):
    kvs = {1: "*Open*",
           3: "*In Progress*",
           4: "*Reopened*",
           5: "*Resolved*",
           6: "*Closed*",
           10000: "*Waiting*",
           10001: "*Needs Approval*",
           10002: "*Ready*",
           10003: "*Spec Signoff*",
           10004: "*Cancelled*",
           10005: "*Postponed*",
           10006: "*Blocked*",
           10007: "*Merged*",
           10011: "*Pass*",
           10012: "*Fail*",
           10013: "*To QA*",
           10014: "*No Test Doc*",
           10015: "*Pending*",
           10016: "*Review*",
           10017: "*No Task Doc*",
           10018: "*Active Q*"}
    
    if key not in kvs:
        return('unkown key %d'%(key))
    else:
        return(kvs[key])

#################################################################################
def parseTime(line):
    ztime = [];
    column = line.split('|')
    state = "none"
    times = 0
    ttime = "none"
          
    for x in column:
        second = x.strip('_*')
        col2 = second.split('_*:*_')
       
        j = 0;
        for y in col2:
            if j == 0:
                state = getKeyDescription(int(y))
            elif j == 1:
                times = (int(y))
            else:
                ttime = bTime(int(y))
            j+=1
        ztime.append('%s %d time(s) %s'%(state, times, ttime))
        
    #print ztime
    return(ztime)

try:
    file1 = sys.argv[1]
except IndexError:
    printUsageAndExit()

if file1 == "--help":
    printUsageAndExit()
    
if file1 == "?":
    printUsageAndExit()


#print "FILE - " + file1


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
    #result.append(summ.encode('iso-8859-1'))
    #result.append(summ.encode('cp1252'))
    #result.append(summ.encode('utf-8',error='replace'))
    result.append(x["fields"]["summary"].encode('utf-8',errors='replace'))
    

    # Resolution
    try:
        result.append(x["fields"]["resolution"]["name"])
    except TypeError:
        result.append("None")

    # Linked Issues1
    links = [];
    for ils in x["fields"]["issuelinks"]:
        if "inwardIssue" in ils:
            links.append(ils["inwardIssue"]["key"]) 
        else:
            links.append(ils["outwardIssue"]["key"]) 
    result.append(" \\\\ ".join(map(str, links)))
    # Fixed Versions  
    fixVersions = [];
    for fve in x["fields"]["fixVersions"]:
        fixVersions.append(fve["name"])
    result.append(" \\\\ ".join(map(str, fixVersions)))
    # Release Notes
    result.append(x["fields"]["customfield_10680"])
    # Time In Status
    try:
        ztime = parseTime(x["fields"]["customfield_10586"])
        result.append(" \\\\ ".join(map(str, ztime)))
    except AttributeError:
        result.append("None")



    # Priority
    result.append(x["fields"]["priority"]["name"])
    
#    for ele in result:
#        print ele

    big.append(" | ".join(map(str, result)))


for ele in big:
    print "| " + ele + " |"
