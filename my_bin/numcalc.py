import sys, string



LANGUAGE_KEY = "Language"
DISPLAY = "disp"
SHOW = 0;
ALL = "all"

code1 = 0;
comment1 = 0;
blank1 = 0;
files1 = 0;


code2 = 0;
comment2 = 0;
blank2 = 0;
files2 = 0;

codeIdx = 1;
commentIdx = 2;
blankIdx = 3;
filesIdx = 4;
jpg = 0;

def printUsageAndExit():
    print "usage:   file1 file2 [disp] [Java C++  C/C++ C Python...{all}]"
    sys.exit()


try:
    file1 = sys.argv[1]
except IndexError:
    printUsageAndExit()

if file1 == "--help":
    printUsageAndExit()
    
if file1 == "?":
    printUsageAndExit()


try:
    file2 = sys.argv[2]
except IndexError:
    printUsageAndExit()


try:    
    the_list = sys.argv[3:]
except IndexError:
    printUsageAndExit()
    
if len(the_list) <= 0:
    printUsageAndExit()

try:
    i = the_list.index(DISPLAY)
except ValueError:
    i = -1
if i >= 0:
    the_list.remove(DISPLAY)
    SHOW = 1;
    

file = open(file1)

print " "
print " "
if SHOW:
    print "FILE - " + file1

#READ FILE ONE
while 1:
    #    lines = file.readlines(2000)
    #read line
    line = file.readline()
    #if line is empty (done)
    if not line:
        break        
    if line.find(LANGUAGE_KEY) >= 0:
        if SHOW:
            print line
        break

#    for line in lines:
if ALL in the_list:
    while 1:
        line = file.readline()
        if not line:
            break;
        if SHOW:
            print line,
        column = string.split(line)
        #print len(column)
#        if column[0] in the_list:
        if len(column) == 1:
            jpg == 1;
        else:
            if column[0] == "SUM:":
                jpg == 2;
            else:
                code1 = code1 + int(column[len(column)-codeIdx])
                comment1 = comment1 + int(column[len(column)-commentIdx])
                blank1 = blank1 + int(column[len(column)-blankIdx])
                files1 = files1 + int(column[len(column)-filesIdx])
else:
    while 1:
        line = file.readline()
        if not line:
            break;
        if SHOW:
            print line,
        column = string.split(line)
        #print len(column)
        if column[0] in the_list:
            code1 = code1 + int(column[len(column)-codeIdx])
            comment1 = comment1 + int(column[len(column)-commentIdx])
            blank1 = blank1 + int(column[len(column)-blankIdx])
            files1 = files1 + int(column[len(column)-filesIdx])
file.close()



file = open(file2)

if SHOW:
    print " "
    print " "
    print "FILE - " + file2
#READ FILE TWO
while 1:
    #    lines = file.readlines(2000)
    line = file.readline()
    if not line:
        break
        #    for line in lines:
    if line.find(LANGUAGE_KEY) >= 0:
        if SHOW:
            print line
        break

if ALL in the_list:
    while 1:
        line = file.readline()
        if not line:
            break;
        if SHOW:
            print line,
        column = string.split(line)
        #print len(column)
#        if column[0] in the_list:
        if len(column) == 1:
            jpg == 1;
        else:
            if column[0] == "SUM:":
                jpg == 2;
            else:
                code2 = code2 + int(column[len(column)-codeIdx])
                comment2 = comment2 + int(column[len(column)-commentIdx])
                blank2 = blank2 + int(column[len(column)-blankIdx])
                files2 = files2 + int(column[len(column)-filesIdx])
else:
    while 1:
        line = file.readline()
        if not line:
            break;
        if SHOW:
            print line,
        column = string.split(line)
        #print len(column)
        if column[0] in the_list:
            code2 = code2 + int(column[len(column)-codeIdx])
            comment2 = comment2 + int(column[len(column)-commentIdx])
            blank2 = blank2 + int(column[len(column)-blankIdx])
            files2 = files2 + int(column[len(column)-filesIdx])
file.close()

try:
    i = the_list.index(DISPLAY)
except ValueError:
    i = -1
if i >= 0:
    the_list.remove(DISPLAY)
codeD = 0;
commentD = 0;
blankD = 0;
filesD = 0;

codeD = code2 - code1
commentD = comment2 - comment1
blankD = blank2 - blank1
filesD = files2 - files1

print ", ".join(the_list)
print '%10s %10s %10s %10s' % ('Files', 'Blank', 'Comments', 'Code')
print '%10d %10d %10d %10d' % (files1, blank1, comment1, code1)
print " "
print '%10s %10s %10s %10s' % ('Files', 'Blank', 'Comments', 'Code')
print '%10d %10d %10d %10d' % (files2, blank2, comment2, code2)
print " "
print "Deltas:"
print '%10s %10s %10s %10s' % ('Files', 'Blank', 'Comments', 'Code')
print '%10d %10d %10d %10d' % (filesD, blankD, commentD, codeD)

