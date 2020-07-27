
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../web_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

		<!--- Menu Bookmark Variable --->
        <CFSET menupage = 'purchasequiz' />

	</head>


	<body class="hold-transition skin-blue sidebar-mini">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />

            <!--- Content Wrapper. Contains page content --->
            <div class="content-wrapper">

				<!--- Content Header (Page header) --->
                <section class="content-header">
                  	<h1>
                    	PURCHASE Quizzes
                  	</h1>
                  	<ol class="breadcrumb">
                    	<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active"><i class="fa fa-money"></i> Purchase Quizzes</li>
                	</ol>
                </section><!--- /.content-header --->

                <section class="content">

                    <div class="row">

                        <div class="col-md-9">

                            <!--- general form elements --->
                            <div class="box box-success">

                                <div class="box-body">

									<br />

                                	<p>Space all set up and ready to take a payment gateway.</p>
									<p>Jamie get a move on, we need a new bank account</p>

									<br />

                                </div><!--- /.box-body --->

                            </div><!--- /.box --->

                        </div><!--- /.col --->

                        <div class="col-md-3">

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

                </section><!--- /.content --->

            </div><!--- /.content-wrapper --->

            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

    	</div><!--- ./wrapper --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

	</body>

</html>
