
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../web_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

		<!--- Menu Bookmark Variable --->
        <CFSET menupage = 'createquiz' />

	</head>


    <!--- Send form details to the database --->
	<CFSET quizzesObj = CreateObject("component","quizzicallyincludes.quizzes") />
    <CFSCRIPT>
        quizzesObj.dsn = dsn;
        quizzesObj.quiz_rounds = form.quiz_rounds;
        quizzesObj.quiz_questions = form.quiz_questions;
        quizzesObj.location_UUID = form.quiz_location;
        quizzesObj.quiz_round_1 = form.category1;
        quizzesObj.quiz_round_2 = form.category2;
        quizzesObj.quiz_round_3 = form.category3;
        quizzesObj.quiz_round_4 = form.category4;
        quizzesObj.quiz_round_5 = form.category5;
        quizzesObj.quiz_round_6 = form.category6;
		quizzesObj.user_UUID = logindetails.user_UUID;
		quizzesObj.user_role_UUID = logindetails.user_role_UUID;
        quizzesObj.logged_user = cookie.myadmin_username;
        myresult = quizzesObj.addQuiz();
    </CFSCRIPT>

    <CFCOOKIE NAME="myadmin_quizcode" VALUE="#myresult.quizCode#" EXPIRES="1">
    <CFCOOKIE NAME="myadmin_quiz_UUID" VALUE="#myresult.quiz_UUID#" EXPIRES="1">


	<body class="hold-transition sidebar-mini skin-blue">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />

      		<div class="content-wrapper">

                <section class="content-header">
                  	<h1>
                    	Waiting for Participants
                    </h1>
                	<ol class="breadcrumb">
                    	<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active"><i class="fa fa-pencil"></i> Waiting for Participants</li>
                	</ol>
                </section><!--- /.content-header --->

                <section class="content">

                    <div class="row">

                        <div class="col-md-6">

                        	<div class="row">

                                <div class="col-md-6">

                                	<div class="small-box bg-primary">

                                        <div class="inner">
                                            <CFIF #myresult.statuscode# EQ 1>
                                                <h3><CFOUTPUT>#myadmin_quizCode#</CFOUTPUT></h3>
                                            <CFELSE>
                                                <h3>Quiz Error</h3>
                                            </CFIF>
                                            <p><strong>Quiz Code</strong></p>
                                        </div>

                                        <div class="icon">
                                            <i class="fa fa-pencil"></i>
                                        </div>

                                    </div><!--- /.small-box --->

                            	</div><!---/.col --->

                                <div class="col-md-6">

                                    <div class="small-box bg-yellow">

                                        <div class="inner">
                                            <h3><span class="clocktime"></span></h3>
                                            <p><strong>Time's a wastin'</strong></p>
                                        </div>

                                        <div class="icon">
                                            <i class="fa fa-clock-o"></i>
                                        </div>

                                    </div><!--- /.smal-box --->

                                </div><!--- /.col --->

                            </div><!--- /.row --->

                        	<div class="row">

                                <div class="col-md-12">

                                    <div class="box box-primary">

                                        <div class="box-header with-border">

                                            <span class="clockdate" style="font-weight: bold; font-size: 16px;"></span>

                                        </div><!--- /.box-header --->

                                        <div class="box-body" style="text-align: center;">

                                            <CFIF #myresult.statuscode# EQ 1>

                                                <p>Waiting for participants to join the quiz. Clicking 'Start Quiz' below will load the first question. Late comers will not get a chance to answer previous questions.</p>

                                                <br />

												<a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>quizzes/quizzes_question.cfm" class="btn btn-lg btn-primary">Start Quiz</a>
                                            <CFELSE>
                                                <p style="color:#dd4b39; font-weight: bold; font-size: 14px;"><CFOUTPUT>#myresult.statusMessage#</CFOUTPUT></p>
                                            </CFIF>

                                            <br />

                                        </div><!--- /.box-body --->

                                    </div><!--- /.box --->

                                </div><!--- /.col --->

                            </div><!--- /.row --->

                        </div><!--- /.col --->

                        <div class="col-md-6">

                            <div class="box box-primary">

                            	<div class="box-header with-border">

                                    <h3 class="box-title">Participants</h3>

                                </div><!--- /.box-header --->

                            	<div class="box-body">

                            		<table id="myTable" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Participant</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>

                            	</div><!--- /.box-body --->

                            </div><!--- /.box --->

                        </div><!--- /.col --->

                    </div><!--- /.row --->

                </section><!--- /.content --->

            </div><!--- /.content-wrapper --->

            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

    	</div><!--- ./wrapper --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

        <script type="text/javascript" language="javascript">
			$(document).ready(function() {
				startTime();

				var table = $('#myTable').dataTable( {
														"bLengthChange": false,
														"bFilter": false,
													    "bJQueryUI": true,
													    "bProcessing": true,
													    "bServerSide": false,
													    "sAjaxSource": "../_cfcs/participants.cfm",
													    "aoColumns": [
													         { "mData": "participant" },
													         { "mData": "actions" }
													    ]
				});

				setInterval( function () {
    				table.api().ajax.reload();
				}, 10000 );
			});

			$(document).on('click', '.participant_confirm', function() {
				$(this).attr('disabled', true);
				var participant_UUID = $(this).parent().find('.participant_UUID').val();
				var participant_label = '.label-'.concat(participant_UUID);
				$.ajax({
					type: "post",
					url: "../_cfcs/participants.cfc?method=updateAccepted",
					data: {
						dsn: "<CFOUTPUT>#dsn#</CFOUTPUT>",
						participant_UUID: participant_UUID
					},
					dataType: 'text',
					success: function(result) {
						$(participant_label).removeClass('label-danger');
						$(participant_label).addClass('label-success');
						$(participant_label).html('OK');
					}
				});
			});
		</script>

    </body>

</html>
