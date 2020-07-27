
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
				background-color: #00C0EF;
				border-color: #00C0EF;
			}
        </style>

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

		<!--- Menu Bookmark Variable --->
        <CFSET menupage = 'manageusers' />

	</head>


    <!--- Quizmaster Details --->
    <CFSET quizmastersObj = CreateObject("component","quizzicallyincludes.quizmasters") />
	<CFSCRIPT>
        quizmastersObj.dsn = dsn;
        quizmastersObj.logged_user = cookie.myadmin_username;
        quizmasterdetails = quizmastersObj.getQuizmasterDetails();
    </CFSCRIPT>


    <body class="hold-transition sidebar-mini skin-blue">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />

            <!--- Content Wrapper. Contains page content --->
      		<div class="content-wrapper">

            	<section class="content-header">
                  	<h1>
                    	MANAGE Quizmasters
                        &nbsp;&nbsp;
                        <span class="label label-info"><CFOUTPUT>#menunumbers.userscount#</CFOUTPUT></span>
                  		&nbsp;&nbsp;&nbsp;&nbsp;
						<a class="btn btn-success" href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>quizmasters/quizmasters.cfm?action=add"><strong>Add User</strong></a>
                    </h1>
                	<ol class="breadcrumb">
                    	<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active"><i class="fa fa-users"></i> Manage Quizmasters</li>
                	</ol>
                </section><!--- /.content-header --->

                <section class="content">

                    <div class="row">

                        <div class="col-md-12">

                            <div class="box box-info">

                                <div class="box-body">

                                	<table id="myTable" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Quizmaster</th>
                                                <th>Email (username)</th>
                                                <th>Last Login</th>
                                                <th>Last Modified</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <CFOUTPUT QUERY="quizmasterdetails">
	                                            <tr <CFIF logindetails.user_UUID EQ user_UUID>style="background-color: ##ccc;"</CFIF>>
	                                                <td><CFIF #IsDefined('user_firstname')#>#user_firstname# #user_lastname#<CFELSE>#email_name#</CFIF></td>
	                                                <td>#user_email#</td>
	                                                <td>#DateFormat(last_login, 'dd/mm/yyyy')#</td>
	                                                <td>#DateFormat(last_modified, 'dd/mm/yyyy')#</td>
	                                                <td>
														<CFIF logindetails.user_UUID NEQ user_UUID>
															<a class="btn btn-xs btn-primary" href="#request.baseurl#quizmasters/quizmasters.cfm?user_details_UUID=#user_details_UUID#&action=edit">Edit</a>
															&nbsp;
															<a class="btn btn-xs btn-danger" href="#request.baseurl#quizmasters/quizmasters.cfm?user_details_UUID=#user_details_UUID#&action=delete">Delete</a>
	                                                    </CFIF>
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
					"bLengthChange": false,
					"info": false
				});
			});
		</script>

        <CFINCLUDE TEMPLATE="../_includes/_toast.cfm" />

    </body>

</html>
