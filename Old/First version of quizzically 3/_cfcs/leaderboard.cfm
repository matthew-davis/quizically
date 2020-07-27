
<CFQUERY NAME="getquestionuuid" DATASOURCE="#dsn#">

	SELECT a.question_UUID

		FROM games_questions a
				INNER JOIN (SELECT quiz_UUID,
								   MAX(round_number) AS round_number,
								   MAX(question_number) AS question_number
								FROM games_questions
								GROUP BY quiz_UUID) b ON a.quiz_UUID = b.quiz_UUID AND a.round_number = b.round_number AND a.question_number = b.question_number

		WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#cookie.myadmin_quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

</CFQUERY>

<CFQUERY NAME="getleaderboard" DATASOURCE="#dsn#">

    SELECT CASE WHEN b.interaction_correct = 1 THEN CONCAT('<span style="font-weight: bold;">', a.participant_team, '</span><span class="label label-success pull-right">', a.participant_score, '</span>')
				ELSE '&nbsp;' END AS correct,
		   CASE WHEN b.interaction_correct IS NULL THEN
		   		(CASE WHEN a.participant_accepted = 'no' THEN CONCAT('<span style="font-weight: bold;">', a.participant_team, '</span><input type="hidden" name="participant_UUID" class="participant_UUID" value="', a.participant_UUID, '" /><button class="btn btn-xs btn-primary pull-right participant_confirm">Play</button>')
		   			  ELSE CONCAT('<span style="font-weight: bold;">', a.participant_team, '</span><span class="label label-default pull-right">', a.participant_score, '</span>') END)
				ELSE '&nbsp;' END AS participant,
		   CASE WHEN b.interaction_correct = 0 THEN CONCAT('<span style="font-weight: bold;">', a.participant_team, '</span><span class="label label-danger pull-right">', a.participant_score, '</span>')
				ELSE '&nbsp;' END AS incorrect

		FROM participants a
				LEFT JOIN (SELECT * FROM interactions WHERE question_UUID = <CFQUERYPARAM VALUE="#getquestionuuid.question_UUID#" CFSQLTYPE="cf_sql_varchar" />) b ON a.participant_UUID = b.participant_UUID

        WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#cookie.myadmin_quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

		ORDER BY a.participant_score DESC, a.participant_time DESC

</CFQUERY>

<CFSET data = [] />

<CFOUTPUT query="getleaderboard">

	<CFSET obj = {
		"correct" = correct,
        "participant" = participant,
        "incorrect" = incorrect
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
