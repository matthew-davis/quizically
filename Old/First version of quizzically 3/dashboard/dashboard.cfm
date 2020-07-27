
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />
        
        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />
        
        <CFSET menupage = 'dashboard' />

	</head>
    
    
    <!--- Logged in user details --->
    <CFSET loginObj = CreateObject("component","quizzicallyincludes.login") />	
	<CFSCRIPT>
        loginObj.dsn = dsn;
		loginObj.username = cookie.myadmin_username;
		loginObj.password = cookie.myadmin_password;
        logindetails = loginObj.getLoginDetails();
    </CFSCRIPT>
    
    <!--- Total Credits --->
    <CFSET usersObj = CreateObject("component","quizzicallyincludes.users") />	
	<CFSCRIPT>
        usersObj.dsn = dsn;
        totalcredits = usersObj.getUserCredits();
    </CFSCRIPT>
    
    <!--- Latest Quizzes --->
    <CFSET quizzesObj = CreateObject("component","quizzicallyincludes.quizzes") />	
	<CFSCRIPT>
        quizzesObj.dsn = dsn;
		quizzesObj.username_hash = logindetails.username_hash;
        latestquizzes = quizzesObj.getLatestQuizzes();
    </CFSCRIPT>
    
    <!--- Chart Data --->
    <CFSET chartsObj = CreateObject("component","quizzicallyincludes.charts") />	
	<CFSCRIPT>
        chartsObj.dsn = dsn;
        dailyquizzes = chartsObj.getDailyQuizzes();
		dailycredits = chartsObj.getDailyCredits();
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
                    	<small>Version 3.2.0 - Chaffinch</small>
                  	</h1>                  
                  	<ol class="breadcrumb">
                    	<li class="active"><i class="fa fa-dashboard"></i> Dashboard</li>
                  	</ol>                  
                </section>

				<!--- Main content --->
        		<section class="content">
          
          			<div class="row">

						<div class="col-md-3">
                        
                        	<div class="row">
                            
                            	<div class="col-md-12">
                                
                                	<div class="small-box bg-green">
                                    
                                        <div class="inner">
                                        	<CFIF #logindetails.user_role_UUID# EQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>
                                            	<h3><CFOUTPUT>#logindetails.credits#</CFOUTPUT></h3>
                                            	<p><strong>Quiz Credits</strong></p>
                                            <CFELSE>
                                                <h3><CFOUTPUT>#totalcredits.total_credits#</CFOUTPUT></h3>
                                            	<p><strong>Total Credits Sold</strong></p>                                            
                                            </CFIF>
                                        </div>
                                    
                                        <div class="icon">
                                            <i class="fa fa-money"></i>
                                        </div>
                                
                                    </div>
                                
                                </div> 
                                
                            </div>
                            
                            <CFIF #logindetails.user_role_UUID# EQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>
                            
                                <div class="row">
                                
                                    <div class="col-md-12">
                                    
                                        <form style="display: inline;"  method="post" action="../purchase/purchase_quizzes.cfm">
                                            <input type="submit" class="btn btn-lg btn-block btn-success" style="font-weight: bold;" value="Buy Quizzes" />
                                        </form> 
                                        
                                        <br />
                                    
                                    </div> 
                                    
                                </div>
                                
                            </CFIF>
                            
                            <div class="row">
                                
                                <div class="col-md-12">
                                
                                	<div class="small-box bg-yellow">
                                    
                                        <div class="inner">
                                            <h3><CFOUTPUT>#getquiznumbers.ongoing_number#</CFOUTPUT></h3>
                                            <p><strong>Live Quizzes</strong></p>
                                        </div>
                                    
                                        <div class="icon">
                                            <i class="fa fa-clock-o"></i>
                                        </div>
                                
                                    </div>
                                
                                </div> 
                                
                            </div>
                            
                            <div class="row">
                                
                                <div class="col-md-12">
                                
                                	<div class="small-box bg-red">
                                    
                                        <div class="inner">
                                            <h3><CFOUTPUT>#getquiznumbers.historic_number#</CFOUTPUT></h3>
                                            <p><strong>Historic Quizzes</strong></p>
                                        </div>
                                    
                                        <div class="icon">
                                            <i class="fa fa-search"></i>
                                        </div>
                                
                                    </div> 
                                
                                </div>
                                
                            </div>                           
                            
                            <CFIF #logindetails.user_role_UUID# NEQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>

                                <div class="row"> 
                                    
                                    <div class="col-md-12">
                                    
                                        <div class="small-box bg-aqua">
                                        
                                            <div class="inner">
                                                <h3><CFOUTPUT>#usersnumber.userscount#</CFOUTPUT></h3>
                                                <p><strong>Users</strong></p>
                                            </div>
                                        
                                            <div class="icon">
                                                <i class="fa fa-users"></i>
                                            </div>
                                    
                                        </div> 
                                    
                                    </div> 
                                
                                </div>
                                
                                <div class="row"> 
                                    
                                    <div class="col-md-12">
                                    
                                        <div class="small-box bg-purple">
                                        
                                            <div class="inner">
                                                <h3><CFOUTPUT>#playersnumber.playerscount#</CFOUTPUT></h3>
                                                <p><strong>Players</strong></p>
                                            </div>
                                        
                                            <div class="icon">
                                                <i class="fa fa-gamepad"></i>
                                            </div>
                                    
                                        </div> 
                                    
                                    </div> 
                                
                                </div>
                            
                            </CFIF>
                        
                        </div>
                        
                        <div class="col-md-9">
                        
                        	<div class="row">
                            
                            	<div class="col-md-12">
                        
									<!--- TABLE: LATEST ORDERS --->
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
                                                                <td>
                                                                    <CFIF #user_firstname# NEQ ''>
                                                                        #user_firstname# #user_lastname#
                                                                     <CFELSE>   
                                                                        #email_name#
                                                                    </CFIF>        
                                                                </td>
                                                                <td>0</td>
                                                            </tr>
                                                        </CFOUTPUT>
                                                    </tbody>
                                                </table>
                                      
                                            </div><!--- /.dataTable --->
                                    
                                        </div><!--- /.box-body --->
        
                                    </div><!--- /.box --->
                                    
                                </div><!--- /.col --->
                                
                            </div><!--- /row --->
                            
                            <CFIF #logindetails.user_role_UUID# NEQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>
                                
                                <div class="row">
                                
                                    <div class="col-md-12">
                            
                                        <div class="box box-primary">
                                        
                                            <div class="box-header with-border">
                                          
                                                <h3 class="box-title">Daily % of <span class="text-success" style="font-weight: bold;">Credits Bought</span> and <span class="text-primary" style="font-weight: bold;">Quizzes Played</span> (month to date)</h3>
                                          
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
            
            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />           
    
    	</div><!--- ./wrapper --->
        
        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" />
        
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
        
        <!--- Runs if the details of an action are passed through displaying a toast --->
        <CFIF #IsDefined('url.statuscode')#>
			<CFOUTPUT>	
				<script type="text/javascript" language="javascript">	
                    $(document).ready(function() {
					
						 toastr.options = {
						  "closeButton": true,
						  "debug": false,
						  "newestOnTop": true,
						  "progressBar": false,
						  "positionClass": "toast-top-right",
						  "preventDuplicates": false,
						  "onclick": null,
						  "showDuration": "300",
						  "hideDuration": "1000",
						  "timeOut": "5000",
						  "extendedTimeOut": "1000",
						  "showEasing": "swing",
						  "hideEasing": "linear",
						  "showMethod": "fadeIn",
						  "hideMethod": "fadeOut"
						};

						<CFIF #url.statuscode# EQ -1>
							toastr["error"]("#statusmessage#", "#statusclass#");						
						<CFELSEIF #url.statuscode# EQ 1>
							toastr["success"]("#statusmessage#", "#statusclass#");
						<CFELSE>
							toastr["error"]("Error", "Error");
						</CFIF>
                    });
                </script>
			</CFOUTPUT>
        </CFIF>      
    
    </body>

</html>
