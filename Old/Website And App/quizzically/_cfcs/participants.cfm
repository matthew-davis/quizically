
<CFQUERY NAME="getparticipants" DATASOURCE="#dsn#">

	SELECT CONCAT(a.participant_team, '<span class="label label-', (CASE WHEN a.participant_accepted = 'no' THEN 'danger' ELSE 'success' END), ' label-', a.participant_UUID, ' pull-right">', (CASE WHEN a.participant_accepted = 'no' THEN 'Confirm' ELSE 'OK' END), '</span>') AS participant,
				CONCAT('<input type="hidden" name="participant_UUID" class="participant_UUID" value="', a.participant_UUID, '" /><button class="btn btn-xs btn-primary pull-right participant_confirm"', (CASE WHEN a.participant_accepted = 'yes' THEN ' disabled' ELSE '' END),'>Confirm</button>') AS actions

    	FROM data_participants a
				LEFT JOIN sys_players b ON a.player_UUID = b.player_UUID
				LEFT JOIN sys_players_details c ON b.player_details_UUID = c.player_details_UUID

		WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#cookie.myadmin_quiz_UUID#" CFSQLTYPE="cf_sql_varchar">

</CFQUERY>


<CFSET data = [] />

<CFOUTPUT query="getparticipants">

	<CFSET obj = {
        "participant" = participant,
        "actions" = actions
     } />

	<CFSET arrayAppend(data, obj) />

</CFOUTPUT>


<CFPROCESSINGDIRECTIVE SUPPRESSWHITESPACE="Yes">

	<CFOUTPUT>
        {"aaData":
        	#serializeJSON(data)#
        }
    </CFOUTPUT>

</CFPROCESSINGDIRECTIVE>

<CFSETTING ENABLECFOUTPUTONLY="No" SHOWDEBUGOUTPUT="No">
