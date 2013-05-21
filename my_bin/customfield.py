import sys, string



CUSTOM_KEY = "customfield_10586"
KEY = "key"

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

    return( '|%10d|%10d|%10d|%10d|%10d|' % (yrs, days, hrs, mins, secs))

#################################################################################
def getKeyDescription(key):
    kvs = {1: "Open",
           3: "In Progress",
           4: "Reopened",
           5: "Resolved",
           6: "Closed",
           10000: "Waiting",
           10001: "Needs Approval",
           10002: "Ready",
           10003: "Spec Signoff",
           10004: "Cancelled",
           10005: "Postponed",
           10006: "Blocked",
           10007: "Merged",
           10011: "Pass",
           10012: "Fail",
           10013: "To QA" ,
           10014: "No Test Doc",
           10015: "Pending",
           10016: "Review",
           10017: "No Task Doc",
           10018: "Active Q"}
    
    if key not in kvs:
        return('unkown key %d'%(key))
    else:
        return(kvs[key])

#################################################################################
def parseKey(line):
    column = line.split(':')
    d = column[1]
    c = d.strip()
    c =  c.strip('\",')
    print c


#################################################################################
def parseCustomKey(line):
    for word in line.split():
        first =  word.strip('\":customfield')
        column = first.split('|')
        print ""
        
        state = "none"
        times = 0
        ttime = "none"

        if len(column) > 1:
            print '|%20s|%10s|%10s|%10s|%10s|%10s|%10s|'%("State", "Num Times", "Years", "Days", "Hours", "Mins", "Secs")
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
                print '|%20s|%10d%s'%(state, times, ttime)
                    
                    
#################################################################################
#
#
#################################################################################
try:
    file1 = sys.argv[1]
except IndexError:
    printUsageAndExit()

if file1 == "--help":
    printUsageAndExit()
    
if file1 == "?":
    printUsageAndExit()



file = open(file1)
print "FILE - " + file1

while 1:
    line = file.readline()

    if not line:
        break        
    if line.find(CUSTOM_KEY) >= 0:
        parseCustomKey(line)
    if line.find(KEY) >= 0:
        parseKey(line)
