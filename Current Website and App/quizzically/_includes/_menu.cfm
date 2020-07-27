
<!--- Menu Numbers --->
<CFSET menuObj = CreateObject("component","quizzicallyincludes.menu") />
<CFSCRIPT>
	menuObj.dsn = dsn;
	menuObj.username_hash = cookie.myadmin_username;
	menunumbers = menuObj.getMenuNumbers();
</CFSCRIPT>


<!--- Left side column. contains the logo and sidebar --->
<aside class="main-sidebar">

	<!--- sidebar: style can be found in sidebar.less --->
	<section class="sidebar">

  		<!--- Sidebar user panel --->
  		<div class="user-panel">

    		<div class="pull-left image">
      			<!--- Insert logged in user avatar or default to generic avatar --->
				<CFIF #logindetails.uploadfile1# NEQ ''>
                    <CFOUTPUT QUERY = 'logindetails'>
                        <img src="../_img/avatars/#user_details_UUID#/#uploadfile1#" class="img-circle" alt="User Image" />
                    </CFOUTPUT>
                <CFELSE>
                    <img src="../_img/generic_avatar.png" class="img-circle" alt="User Image" />
                </CFIF>
    		</div>

    		<div class="pull-left info">
				<CFOUTPUT QUERY="logindetails">
      				<p><CFIF #IsDefined('user_firstname')#>#user_firstname# #user_lastname#<CFELSE>#email_name#</CFIF></p>
      				#user_role#
				</CFOUTPUT>
    		</div>

  		</div>

  		<!--- sidebar menu: : style can be found in sidebar.less --->
  		<ul class="sidebar-menu">

    		<li class="header">MAIN NAVIGATION</li>

			<CFOUTPUT>

	            <li <CFIF #menupage# EQ 'dashboard'>class="active"</CFIF>><a href="#request.baseurl#dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a></li>

	            <li <CFIF #menupage# EQ 'purchasequiz'>class="active"</CFIF>><a href="#request.baseurl#purchase/purchase_quizzes.cfm"><i class="fa fa-money"></i> <span>Purchase Quizzes</span> <span class="label label-success pull-right">#menunumbers.credits#</span></a></li>

	            <CFIF (#logindetails.credits# GT 0) OR (#logindetails.user_role_UUID# NEQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e')>
	            	<li <CFIF #menupage# EQ 'createquiz'>class="active"</CFIF>><a href="#request.baseurl#quizzes/quizzes_create.cfm"><i class="fa fa-pencil"></i> <span>Create a Quiz</span></a></li>
	            <CFELSE>
	            	<li class="header" style="font-size: 14px;"><i class="fa fa-pencil" style="margin-left: 5px; width: 20px;"></i>Create a Quiz</li>
	            </CFIF>

	            <li <CFIF #menupage# EQ 'ongoingquiz'>class="active"</CFIF>><a href="#request.baseurl#quizzes/quizzes_ongoing.cfm"><i class="fa fa-clock-o"></i> <span>Ongoing Quizzes</span> <span class="label label-warning pull-right">#menunumbers.ongoing_number#</span></a></li>

	            <li <CFIF #menupage# EQ 'historicquiz'>class="active"</CFIF>><a href="#request.baseurl#quizzes/quizzes_historic.cfm"><i class="fa fa-search"></i> <span>Historic Quizzes</span> <span class="label label-danger pull-right">#menunumbers.historic_number#</span></a></li>

				<!--- Manage Players - Only viewable if you are not a Quizmaster --->
	            <CFIF #logindetails.user_role_UUID# NEQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>
	            	<li class="treeview <CFIF (#menupage# EQ 'manageplayers') OR (#menupage# EQ 'managedeletedplayers')>active</CFIF>">
						<a href="##">
	                        <i class="fa fa-gamepad"></i> <span>Players</span> <i class="fa fa-angle-left pull-right"></i>
	                    </a>
	                    <ul class="treeview-menu">
	                        <li <CFIF #menupage# EQ 'manageplayers'>class="active"</CFIF>><a href="#request.baseurl#players/manage_players.cfm"><i class="fa fa-circle-o"></i> <span>Manage Players</span> <span class="label bg-purple pull-right">#menunumbers.playerscount#</span></a></li>
	                        <!--- Only viewable as Super User --->
	                        <CFIF #logindetails.user_role_UUID# EQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>
	                        	<li <CFIF #menupage# EQ 'managedeletedplayers'>class="active"</CFIF>><a href="#request.baseurl#players/manage_deleted_players.cfm"><i class="fa fa-circle-o text-danger"></i> <span>Deleted Players</span> <span class="label label-danger pull-right">#menunumbers.deletedplayerscount#</span></a></li>
	                    	</CFIF>
	                    </ul>
	            	</li>
	        	</CFIF>

	            <!--- Manage Quizmasters - Only viewable if you are not a Quizmaster --->
	            <CFIF #logindetails.user_role_UUID# NEQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>
	            	<li class="treeview <CFIF (#menupage# EQ 'managequizmasters') OR (#menupage# EQ 'managedeletedquizmasters')>active</CFIF>">
						<a href="##">
	                        <i class="fa fa-users"></i> <span>Quizmasters</span> <i class="fa fa-angle-left pull-right"></i>
	                    </a>
	                    <ul class="treeview-menu">
	                        <li <CFIF #menupage# EQ 'managequizmasters'>class="active"</CFIF>><a href="#request.baseurl#quizmasters/manage_quizmasters.cfm"><i class="fa fa-circle-o"></i> <span>Manage Quizmasters</span> <span class="label label-info pull-right">#menunumbers.userscount#</span></a></li>
	                        <!--- Only viewable as Super User --->
	                        <CFIF #logindetails.user_role_UUID# EQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>
	                        	<li <CFIF #menupage# EQ 'managedeletedquizmasters'>class="active"</CFIF>><a href="#request.baseurl#quizmasters/manage_deleted_quizmasters.cfm"><i class="fa fa-circle-o text-danger"></i> <span>Deleted Quizmasters</span> <span class="label label-danger pull-right">#menunumbers.deleteduserscount#</span></a></li>
	                    	</CFIF>
	                    </ul>
	            	</li>
	        	</CFIF>

			</CFOUTPUT>

  		</ul>

	</section><!--- /.sidebar --->

</aside>
