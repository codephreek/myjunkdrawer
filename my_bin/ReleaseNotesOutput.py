import json
import pprint
import sys, string


KEYS_TIME_IN = {1: "*Open*",
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

KEYURL = "http://iphase3scm:8080/browse/"

################################################################################
def printUsageAndExit():
    print "usage:   file"
    sys.exit()

################################################################################
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

################################################################################
def getKeyDescription(key):
    if key not in KEYS_TIME_IN:
        return('unkown key %d'%(key))
    else:
        return(KEYS_TIME_IN[key])

################################################################################
def iequal(a, b):
    try:
        return a.upper() == b.upper()
    except AttributeError:
        return a == b

################################################################################
def formatForLink(key):
    kurl = KEYURL + key
    return "[" + key + "|" + kurl + "]"


################################################################################
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
    return(ztime)

################################################################################
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

big = [];
for x in data["issues"]:
    result = [];
    
    # Issue Type
    reslt = str(x["fields"]["issuetype"]["name"])
    if iequal(reslt, "story"):
        reslt = "!story.png!"
    elif iequal(reslt, "bug"):
        reslt = "!bug.png!"
    elif iequal(reslt, "improvement"):
        reslt = "!imp.png!"
    elif iequal(reslt, "new feature"):
        reslt = "!new.png!"
    elif iequal(reslt, "task"):
        reslt = "!task.png!"
    elif iequal(reslt, "sub-task"):
        reslt = "!task-sub.png!"
    else:
        reslt = reslt    
    result.append(reslt)

    # Key
    result.append(formatForLink(x["key"]))
    
    # Summary
    #result.append(summ.encode('iso-8859-1'))
    #result.append(summ.encode('cp1252'))
    #result.append(summ.encode('utf-8',error='replace'))
    result.append(x["fields"]["summary"].encode('utf-8',errors='replace'))

    # Resolution
    try:
        result.append(x["fields"]["resolutiondate"])
    except TypeError:
        result.append(" ")

    # Fixed Versions  
    fixVersions = [];
    for fve in x["fields"]["fixVersions"]:
        fixVersions.append(fve["name"])
    result.append(" \\\\ ".join(map(str, fixVersions)))

    # Status
    result.append(x["fields"]["status"]["name"])


    # Release Notes
    rnotes = str(x["fields"]["customfield_10680"])
    
    if iequal(rnotes, "none"):
        rnotes = " "
    result.append(rnotes)
    
    big.append(" | ".join(map(str, result)))    


print "|| *Type* || *Key* || *Summary* || *Resolved* || *Fix Versions* || *Status* || *Release Notes* ||"

for ele in big:
    print '| %s |' % (ele)
