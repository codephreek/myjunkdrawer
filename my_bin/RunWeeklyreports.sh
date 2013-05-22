#! /bin/bash

STAR_VAR=`pwd`

cd $HOME/myfoo

curl -o - -u $1:$2 -X GET -H "Content-Type: application/json" "http://iphase3scm:8080/rest/api/2/search?jql=savedfilter%20%3D%20TheCurrentSprint%20AND%20status%20in%20(Resolved)%20ORDER%20BY%20issuetype%20ASC%2C%20key%20ASC&maxResults=100" | python -mjson.tool > resolved

curl -o - -u $1:$2 -X GET -H "Content-Type: application/json" "http://iphase3scm:8080/rest/api/2/search?jql=savedfilter%20%3D%20TheCurrentSprint%20AND%20status%20in%20(Ready%2C%20Merge)%20ORDER%20BY%20issuetype%20ASC%2C%20key%20ASC&maxResults=100" | python -mjson.tool > ready

curl -o - -u $1:$2 -X GET -H "Content-Type: application/json" "http://iphase3scm:8080/rest/api/2/search?jql=savedfilter%20%3D%20%22Backlog%20-%20Current%20Sprint%20(Testing)%20%22%20OR%20savedfilter%20%3D%20TheCurrentSprint%20AND%20status%20in%20(Review%2C%20%22To%20QA%22)%20ORDER%20BY%20issuetype%20ASC%2C%20key%20ASC&maxResults=100" | python -mjson.tool > codereview

curl -o - -u $1:$2 -X GET -H "Content-Type: application/json" "http://iphase3scm:8080/rest/api/2/search?jql=savedfilter%20%3D%20TheCurrentSprint%20AND%20status%20%3D%20%22In%20Progress%22%20ORDER%20BY%20issuetype%20ASC%2C%20key%20ASC&maxResults=100" | python -mjson.tool > inprogress

curl -o - -u $1:$2 -X GET -H "Content-Type: application/json" "http://iphase3scm:8080/rest/api/2/search?jql=savedfilter%20%3D%20TheCurrentSprint%20AND%20status%20in%20(Open%2C%20Reopened)%20ORDER%20BY%20issuetype%20ASC%2C%20key%20ASC&maxResults=100" | python -mjson.tool > openUpcoming

curl -o - -u $1:$2 -X GET -H "Content-Type: application/json" "http://iphase3scm:8080/rest/api/2/search?jql=savedfilter%20%3D%20TheCurrentSprint%20AND%20status%20in%20(Closed)%20ORDER%20BY%20issuetype%20ASC%2C%20key%20ASC&maxResults=100" | python -mjson.tool > closed

curl -o - -u $1:$2 -X GET -H "Content-Type: application/json" "http://iphase3scm:8080/rest/api/2/search?jql=savedfilter%20%3D%20TheCurrentSprint%20%20AND%20status%20not%20in%20(Pending%2C%20Ready%2C%20%22In%20Progress%22%2C%20Open%2C%20Review%2C%20Closed%2C%20Resolved%2C%20Pass%2C%20Merge%2C%20Reopened%2C%20%22To%20QA%22)%20ORDER%20BY%20issuetype%20ASC%2C%20key%20ASC&maxResults=100" | python -mjson.tool > abnormal

curl -o - -u $1:$2 -X GET -H "Content-Type: application/json" "http://iphase3scm:8080/rest/api/2/search?jql=fixVersion%20%3D%20latestReleasedVersion(Server)%20OR%20fixVersion%20%3D%20latestReleasedVersion(CPPAPI)%20OR%20fixVersion%20%3D%20latestReleasedVersion(CPPMSG)%20OR%20fixVersion%20%3D%20latestReleasedVersion(CPPCOR)%20OR%20fixVersion%20%3D%20latestReleasedVersion(JAVMSG)%20OR%20fixVersion%20%3D%20latestReleasedVersion(JAVAPI)%20OR%20fixVersion%20%3D%20latestReleasedVersion(JAVCOR)%20OR%20fixVersion%20%3D%20latestReleasedVersion(ANDAPI)%20OR%20fixVersion%20%3D%20latestReleasedVersion(ANDMSG)%20OR%20fixVersion%20%3D%20latestReleasedVersion(ABSIOENG)%20OR%20fixVersion%20%3D%20latestReleasedVersion(FILEEXPLORER)%20OR%20fixVersion%20%3D%20latestReleasedVersion(CAMERAAPP)%20ORDER%20BY%20project%20ASC%2C%20type%20ASC&maxResults=100" | python -mjson.tool > lastsprint


RestDataOutput.sh codereview > codereview.final

RestDataOutput.sh inprogress > inprogress.final

RestDataOutput.sh openUpcoming  > openUpcoming.final

RestDataOutput.sh ready  > ready.final

RestDataOutput.sh resolved  > resolved.final

RestDataOutput.sh closed > closed.final

RestDataOutput.sh abnormal > abnormal.final

RestDataOutput.sh lastsprint > lastsprint.final

cd $STAR_VAR





