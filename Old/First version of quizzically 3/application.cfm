
<CFAPPLICATION NAME="quizzically" SESSIONMANAGEMENT="Yes" SESSIONTIMEOUT="#CreateTimeSpan(0,1,30,0)#">

<CFHEADER NAME="Content-Type" VALUE="text/html; charset=utf-8">

<CFSET setEncoding("url","utf-8")>
<CFSET setEncoding("form","utf-8")>

<CFCONTENT TYPE="text/HTML; charset=utf-8">

<CFSET #dsn# = "quizzically" />

<CFSET currentPath = getCurrentTemplatePath() />
<CFSET request.rootdirectory = getDirectoryFromPath(currentPath) />

<!--- Salt --->
<CFSET #request.mysalt# = "wat3r" />
