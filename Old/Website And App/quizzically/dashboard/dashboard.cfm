
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../web_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

		<!--- Menu Bookmark Variable --->
        <CFSET menupage = 'dashboard' />

	</head>


    <!--- Dashboard Details --->
    <CFSET dashboardObj = CreateObject("component","quizzicallyincludes.dashboard") />
	<CFSCRIPT>
        dashboardObj.dsn = dsn;
		dashboardObj.username_hash = logindetails.username_hash;
        latestquizzes = dashboardObj.getLatestQuizzes();
        dailyquizzes = dashboardObj.getDailyQuizzes();
		dailycredits = dashboardObj.getDailyCredits();
    </CFSCRIPT>


    <body class="hold-transition skin-blue sidebar-mini">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />

            <!--- Content Wrapper. Contains page content --->
            <div class="content-wrapper">

				<!--- Content Header (Page header) --->
                <section class="content-header">
                  	<h1>
                    	quizzically
                    	<small>Version 3.3.0 - Chaffinch</small>
                  	</h1>
                  	<ol class="breadcrumb">
                    	<li class="active"><i class="fa fa-dashboard"></i> Dashboard</li>
                  	</ol>
                </section><!--- /.content-header --->

				<!--- Main content --->
        		<section class="content">

          			<div class="row">

						<div class="col-md-3">

                        	<div class="row">

                            	<div class="col-md-12">

                                	<div class="small-box bg-green">

                                        <div class="inner">
                                        	<CFOUTPUT>
                                                <h3>#menunumbers.credits#</h3>
                                            	<p><strong>#menunumbers.credits_label#</strong></p>
                                            </CFOUTPUT>
                                        </div>

                                        <div class="icon">
                                            <i class="fa fa-money"></i>
                                        </div>

                                    </div><!--- /.small-box --->

                                </div><!--- /.col --->

                            </div><!--- /.row --->

                            <CFIF #logindetails.user_role_UUID# EQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>

                                <div class="row">

                                    <div class="col-md-12">

										<strong><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>purchase/pruchase_quizzes.cfm" class="btn btn-lg btn-block btn-success" >Buy Quizzes</a></strong>

                                        <br />

                                    </div><!--- /.col --->

                            	</div><!--- /.row --->

                            </CFIF>

                            <div class="row">

                                <div class="col-md-12">

                                	<div class="small-box bg-yellow">

                                        <div class="inner">
                                            <h3><CFOUTPUT>#menunumbers.ongoing_number#</CFOUTPUT></h3>
                                            <p><strong>Live Quizzes</strong></p>
                                        </div>

                                        <div class="icon">
                                            <i class="fa fa-clock-o"></i>
                                        </div>

                                    </div><!--- /.small-box --->

                                </div><!--- /.col --->

                            </div><!--- /.row --->

                            <div class="row">

                                <div class="col-md-12">

                                	<div class="small-box bg-red">

                                        <div class="inner">
                                            <h3><CFOUTPUT>#menunumbers.historic_number#</CFOUTPUT></h3>
                                            <p><strong>Historic Quizzes</strong></p>
                                        </div>

                                        <div class="icon">
                                            <i class="fa fa-search"></i>
                                        </div>

                                    </div><!--- /.small-box --->

                                </div><!--- /.col --->

                            </div><!--- /.row --->

                            <CFIF #logindetails.user_role_UUID# NEQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>

                                <div class="row">

                                    <div class="col-md-12">

                                        <div class="small-box bg-purple">

                                            <div class="inner">
                                                <h3><CFOUTPUT>#menunumbers.playerscount#</CFOUTPUT></h3>
                                                <p><strong>Players</strong></p>
                                            </div>

                                            <div class="icon">
                                                <i class="fa fa-gamepad"></i>
                                            </div>

                                        </div><!--- /.small-box --->

                                	</div><!--- /.col --->

                            	</div><!--- /.row --->

								<div class="row">

                                    <div class="col-md-12">

                                        <div class="small-box bg-aqua">

                                            <div class="inner">
                                                <h3><CFOUTPUT>#menunumbers.userscount#</CFOUTPUT></h3>
                                                <p><strong>Quizmasters</strong></p>
                                            </div>

                                            <div class="icon">
                                                <i class="fa fa-users"></i>
                                            </div>

                                        </div><!--- /.small-box --->

                                	</div><!--- /.col --->

                            	</div><!--- /.row --->

                            </CFIF>

                        </div>

                        <div class="col-md-9">

                        	<div class="row">

                            	<div class="col-md-12">

                                    <div class="box box-primary">

                                        <div class="box-header with-border">

                                            <h3 class="box-title">Latest Quizzes</h3>

                                        </div><!--- /.box-header --->

                                        <div class="box-body">

                                            <div class="table-responsive">

                                                <table class="table no-margin">
                                                    <thead>
                                                        <tr>
                                                            <th>Date</th>
                                                            <th>Location</th>
                                                            <th>Rounds</th>
                                                            <th>Questions</th>
                                                            <th>Winner</th>
                                                            <th>Top Score</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <CFOUTPUT QUERY="latestquizzes">
                                                            <tr>
                                                                <td>#DateFormat(quiz_created, 'dd/mm/yyyy')#</td>
                                                                <td>#location#</td>
                                                                <td>#quiz_rounds#</td>
                                                                <td>#quiz_questions#</td>
                                                                <td>#quiz_winner#</td>
                                                                <td>#quiz_score#</td>
                                                            </tr>
                                                        </CFOUTPUT>
                                                    </tbody>
                                                </table>

                                            </div><!--- /.table --->

                                        </div><!--- /.box-body --->

                                    </div><!--- /.box --->

                                </div><!--- /.col --->

                            </div><!--- /row --->

                            <CFIF #logindetails.user_role_UUID# NEQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>

                                <div class="row">

                                    <div class="col-md-12">

                                        <div class="box box-primary">

                                            <div class="box-header with-border">

                                                <h3 class="box-title">Daily <span class="text-primary" style="font-weight: bold;">% Quizzes Played</span> and <span class="text-success" style="font-weight: bold;">% of Credits Bought</span> (month to date)</h3>

                                            </div><!--- /.box-header --->

                                            <div class="box-body">

                                                <div class="chart">

                        							<canvas id="quizChart" style="height: 180px;"></canvas>

                      							</div><!--- /.chart-responsive --->

                                            </div><!--- /.box-body --->

                                        </div><!--- /.box --->

                                    </div><!--- /.col --->

                                </div><!--- /row --->

                            </CFIF>

                        </div><!--- /.col --->

                    </div><!--- /row --->

        		</section><!--- /.content --->

			</div><!--- /.content-wrapper --->

            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

    	</div><!--- ./wrapper --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

        <script>
			$(document).ready(function() {

  				'use strict';

  				var quizChartCanvas = $("#quizChart").get(0).getContext("2d");
        		var quizChart = new Chart(quizChartCanvas);

				var quizChartData = {
    				labels: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
					datasets: [
				  		{
							label: "Quiz Credits",
							fillColor: "#3c8dbc",
							strokeColor: "#3c8dbc",
							highlightFill: "#ccc",
							highlightStroke: "#3c8dbc",
							data: [
									<CFOUTPUT QUERY="dailyquizzes">
										#monday_quizzes#,
										#tuesday_quizzes#,
										#wednesday_quizzes#,
										#thursday_quizzes#,
										#friday_quizzes#,
										#saturday_quizzes#,
										#sunday_quizzes#
									</CFOUTPUT>
							]
				  		},
				  		{
							label: "Quizzes Played",
							fillColor: "#00a65a",
							strokeColor: "#00a65a",
							pointColor: "#00a65a",
							highlightFill: "#ccc",
							highlightStroke: "#00a65a",
							data: [
									<CFOUTPUT QUERY="dailycredits">
										#monday_credits#,
										#tuesday_credits#,
										#wednesday_credits#,
										#thursday_credits#,
										#friday_credits#,
										#saturday_credits#,
										#sunday_credits#
									</CFOUTPUT>
							]
				  		}
					]
			  	};

				var quizChartOptions = {
				    //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
				    scaleBeginAtZero: true,
				    //Boolean - Whether grid lines are shown across the chart
				    scaleShowGridLines: true,
				    //String - Colour of the grid lines
				    scaleGridLineColor: "rgba(0,0,0,.05)",
				    //Number - Width of the grid lines
				    scaleGridLineWidth: 1,
				    //Boolean - Whether to show horizontal lines (except X axis)
				    scaleShowHorizontalLines: true,
				    //Boolean - Whether to show vertical lines (except Y axis)
				    scaleShowVerticalLines: true,
				    //Boolean - If there is a stroke on each bar
				    barShowStroke: true,
				    //Number - Pixel width of the bar stroke
				    barStrokeWidth: 2,
				    //Number - Spacing between each of the X value sets
				    barValueSpacing: 5,
				    //Number - Spacing between data sets within X values
				    barDatasetSpacing: 1,
				    //String - A legend template
				    legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].fillColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>",
				    //Boolean - whether to make the chart responsive
				    responsive: true,
				    maintainAspectRatio: true
        		};

        		quizChartOptions.datasetFill = false;
        		quizChart.Bar(quizChartData, quizChartOptions);
			});
		</script>

        <CFINCLUDE TEMPLATE="../_includes/_toast.cfm" />

    </body>

</html>
