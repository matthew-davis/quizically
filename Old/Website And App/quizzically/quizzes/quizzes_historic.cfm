
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../web_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

		<style>
        	.pagination > .active > a, .pagination > .active > a:focus, .pagination > .active > a:hover, .pagination > .active > span, .pagination > .active > span:focus, .pagination > .active > span:hover {
				z-index: 2;
				color: #FFF;
				cursor: default;
				background-color: #DD4B39;
				border-color: #DD4B39;
			}
        </style>

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

		<!--- Menu Bookmark Variable --->
        <CFSET menupage = 'historicquiz' />

	</head>


	<!--- Get quiz details --->
	<CFSET quizzesObj = CreateObject("component","quizzicallyincludes.quizzes") />
	<CFSCRIPT>
        quizzesObj.dsn = dsn;
        if (logindetails.user_role_UUID != 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e') {
        	quizzesObj.username_hash = logindetails.username_hash;
        }
        quizzesObj.quiz_type = 'historic';
        quizdetails = quizzesObj.getQuizDetails();
    </CFSCRIPT>


	<body class="hold-transition sidebar-mini skin-blue">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />

      		<div class="content-wrapper">

            	<section class="content-header">
                  	<h1>
                    	HISTORIC Quizzes
                        &nbsp;&nbsp;
                        <span class="label label-danger"><CFOUTPUT>#menunumbers.historic_number#</CFOUTPUT></span>
                    </h1>
                	<ol class="breadcrumb">
                    	<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active"><i class="fa fa-search"></i> Complete Quizzes</li>
                	</ol>
                </section><!--- /.content-header --->

                <section class="content">

                    <div class="row">

                        <div class="col-md-12">

                            <div class="box box-danger">

                                <div class="box-body">

                                    <table id="myTable" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Started</th>
                                                <th>Finished</th>
                                                <th>Winner</th>
                                                <th>Rounds</th>
                                                <th>Questions</th>
                                                <th>Location</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <CFOUTPUT QUERY="quizdetails">
                                            <tr>
                                                <td><span style="display: none;">#quiz_created#</span>#DateFormat(quiz_created, 'dd/mm/yyyy')#</td>
                                                <td>#DateFormat(quiz_completed, 'dd/mm/yyyy')#</td>
                                                <td>#quiz_winner#</td>
                                                <td>#quiz_rounds#</td>
                                                <td>#quiz_questions#</td>
                                                <td>#location#</td>
                                                <td>
													<a class="btn btn-xs btn-danger" href="#request.baseurl#quizzes/quizzes_quiz_finish.cfm?origin=historic&myadmin_quiz_UUID=#quiz_UUID#">Quiz Details</a>
                                                </td>
                                            </tr>
                                            </CFOUTPUT>
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
    			$('#myTable').DataTable({
					"order": [[ 0, "desc" ]],
					"bLengthChange": false,
					"info": false
				});
			});
		</script>

    </body>

</html>
