
<CFAPPLICATION NAME="quizzically" SESSIONMANAGEMENT="Yes" SESSIONTIMEOUT="#CreateTimeSpan(0,1,30,0)#">

<CFHEADER NAME="Content-Type" VALUE="text/html; charset=utf-8">

<CFSET setEncoding("url","utf-8")>
<CFSET setEncoding("form","utf-8")>

<CFCONTENT TYPE="text/HTML; charset=utf-8">

<CFSET #dsn# = "quizzically" />

<CFSET currentPath = getCurrentTemplatePath() />
<CFSET request.rootdirectory = getDirectoryFromPath(currentPath) />

<!--- Base URL --->
<CFSET request.baseurl = "http://localhost/quizzically/" />

<!--- Salt --->
<CFSET #request.mysalt# = "10nc354w4b34r" />

<!--- Admin Email --->
<CFSET #request.adminemail# = "matthew.davis.1978@gmail.com" />
