
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

        <!--- Menu Bookmark Variable --->
        <CFSET menupage = 'x' />

	</head>


    <!--- Logged in user details --->
    <CFSET loginObj = CreateObject("component","quizzicallyincludes.login") />
	<CFSCRIPT>
        loginObj.dsn = dsn;
		loginObj.username = cookie.myadmin_username;
		loginObj.password = cookie.myadmin_password;
        logindetails = loginObj.getLoginDetails();
    </CFSCRIPT>

    <!--- Get question and round number --->
    <CFSET quizzesObj = CreateObject("component","quizzicallyincludes.quizzes") />
    <CFSCRIPT>
		quizzesObj.dsn = dsn;
		quizzesObj.quiz_UUID = cookie.myadmin_quiz_UUID;
		getquestionnumber = quizzesObj.getQuestionNumber();
	</CFSCRIPT>


	<body class="hold-transition sidebar-mini skin-blue">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />


            <!--- Content Wrapper. Contains page content --->
      		<div class="content-wrapper">

            	<section class="content-header">
                  	<h1>
                    	quizzically
                    </h1>
                	<ol class="breadcrumb">
                    	<li><a href="../dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active"><i class="fa fa-pencil"></i> Round Finish</li>
                	</ol>
                </section>

                <section class="content">

                    <div class="row">

                        <!--- column width --->
                        <div class="col-md-6">

                        	<div class="row">

								<!--- column width --->
                                <div class="col-md-6">

                                	<div class="small-box bg-primary">

                                        <div class="inner">
                                            <h3><CFOUTPUT>#myadmin_quizCode#</CFOUTPUT></h3>
                                            <p><strong>Quiz Code</strong></p>
                                        </div>

                                        <div class="icon">
                                            <i class="fa fa-pencil"></i>
                                        </div>

                                    </div>

                            	</div>

                                <!--- column width --->
                                <div class="col-md-6">

                                    <div class="small-box bg-yellow">

                                        <div class="inner">
                                            <h3><span class="clocktime"></span></h3>
                                            <p><strong>Time's a wastin'</strong></p>
                                        </div>

                                        <div class="icon">
                                            <i class="fa fa-clock-o"></i>
                                        </div>

                                    </div>

                                </div>

                            </div>

                        	<div class="row">

								<!--- column width --->
                                <div class="col-md-12">

									<!--- general form elements --->
                                    <div class="box box-primary">

                                        <div class="box-header with-border">

                                            <h3 class="box-title">
                                                <strong>
                                                    Next: Round <CFOUTPUT>#getquestionnumber.round_number#</CFOUTPUT>
                                                </strong>
                                            </h3>

                                            <h3 class="box-title pull-right">
                                            	<strong>
													<CFOUTPUT>#getquestionnumber.round_category#</CFOUTPUT>
                                                </strong>
                                            </h3>

                                        </div>

                                        <div class="box-body">

                                            <p align="center"><button type="button" class="btn btn-primary" id="continuequiz" style="text-align: center;" >Next Round</button></p>

                                        </div><!--- /.box-body --->

                                    </div><!--- /.box --->

                                </div>

                            </div>

                        </div>

                        <!--- column width --->
                        <div class="col-md-6">

                        	<!--- general form elements --->
                            <div class="box box-primary">

                            	<div class="box-header with-border">

                                    <h3 class="box-title">Leaderboard</h3>

                                </div>

                            	<div class="box-body">

                            		<table id="myTable" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Correct</th>
												<th>Participant</th>
                                                <th>Incorrect</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>

                            	</div>

                            </div>

                        </div>

                    </div>

                </section>

            </div>


            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />

    	</div><!--- ./wrapper --->

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" />

        <script type="text/javascript" language="javascript">
			$(document).on('click', '#continuequiz', function() {
				window.location = "./quizzes_question.cfm";
			});

			$(document).ready(function() {
				startTime();

				var table = $('#myTable').dataTable( {
										"bLengthChange": false,
										"bFilter": false,
									    "bJQueryUI": true,
									    "bProcessing": true,
									    "bServerSide": false,
									    "sAjaxSource": "../_cfcs/leaderboard.cfm",
									    "aoColumns": [
									    	 { "mData": "correct" },
									         { "mData": "participant" },
									         { "mData": "incorrect" }
									    ]
				});

				setInterval( function () {
    				table.api().ajax.reload();
				}, 3000 );
			});

			$(document).on('click', '.participant_confirm', function() {
				$(this).attr('disabled', true);
				var participant_UUID = $(this).parent().find('.participant_UUID').val();
				$.ajax({
					type: "post",
					url: "../_cfcs/participants.cfc?method=updateAccepted",
					data: {
						dsn: "<CFOUTPUT>#dsn#</CFOUTPUT>",
						participant_UUID: participant_UUID
					},
					dataType: 'text',
					success: function(result) {

					}
				});
			});
		</script>

	</body>

</html>
