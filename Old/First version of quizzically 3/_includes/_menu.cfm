
<!--- Quiz Numbers --->
<CFSET quizzesObj = CreateObject("component","quizzicallyincludes.quizzes") />	
<CFIF #logindetails.user_role_UUID# NEQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>
	<CFSCRIPT>
        quizzesObj.username_hash = logindetails.username_hash;
    </CFSCRIPT>
</CFIF>
<CFSCRIPT>
	quizzesObj.dsn = dsn;
	getquiznumbers = quizzesObj.getQuizNumbers();
</CFSCRIPT>

<!--- User Numbers --->   
<CFSET usersObj = CreateObject("component","quizzicallyincludes.users") />
<CFIF #logindetails.user_role_UUID# NEQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>
	<CFSCRIPT>
        usersObj.username_hash = logindetails.username_hash;
    </CFSCRIPT>
</CFIF>	
<CFSCRIPT>
	usersObj.dsn = dsn;
	usersnumber = usersObj.getUsersNumber();
	deletedusersnumber = usersObj.getDeletedUsersNumber();
</CFSCRIPT>

<!--- Player Numbers --->   
<CFSET playersObj = CreateObject("component","quizzicallyincludes.players") />
<CFSCRIPT>
	playersObj.dsn = dsn;
	playersnumber = playersObj.getPlayersNumber();
	deletedplayersnumber = playersObj.getDeletedPlayersNumber();
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
      			<p><CFOUTPUT QUERY="logindetails"><CFIF #IsDefined('logindetails.user_firstname')#>#user_firstname# #user_lastname#<CFELSE>#email_name#</CFIF></CFOUTPUT></p>
      			<CFOUTPUT QUERY="logindetails">#user_role#</CFOUTPUT>
    		</div>
  
  		</div>
  
  		<!--- sidebar menu: : style can be found in sidebar.less --->
  		<ul class="sidebar-menu">
    
    		<li class="header">MAIN NAVIGATION</li>
            
            <li <CFIF #menupage# EQ 'dashboard'><CFOUTPUT>class="active"</CFOUTPUT></CFIF>><a href="../dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a></li>
            
            <li <CFIF #menupage# EQ 'purchasequiz'><CFOUTPUT>class="active"</CFOUTPUT></CFIF>><a href="../purchase/purchase_quizzes.cfm"><i class="fa fa-money"></i> <span>Purchase Quizzes</span> <span class="label label-success pull-right"><CFOUTPUT>#logindetails.credits#</CFOUTPUT></span></a></li>
			
            <CFIF (#logindetails.credits# GT 0) OR (#logindetails.user_role_UUID# NEQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e')>
            	<li <CFIF #menupage# EQ 'createquiz'><CFOUTPUT>class="active"</CFOUTPUT></CFIF>><a href="../quizzes/quizzes_create.cfm"><i class="fa fa-pencil"></i> <span>Create a Quiz</span></a></li>
            <CFELSE>
            	<li class="header" style="font-size: 14px;"><i class="fa fa-pencil" style="margin-left: 5px; width: 20px;"></i>Create a Quiz</li>
            </CFIF>

            <li <CFIF #menupage# EQ 'ongoingquiz'><CFOUTPUT>class="active"</CFOUTPUT></CFIF>><a href="../quizzes/quizzes_ongoing.cfm"><i class="fa fa-clock-o"></i> <span>Ongoing Quizzes</span> <span class="label label-warning pull-right"><CFOUTPUT>#getquiznumbers.ongoing_number#</CFOUTPUT></span></a></li>
            
            <li <CFIF #menupage# EQ 'historicquiz'><CFOUTPUT>class="active"</CFOUTPUT></CFIF>><a href="../quizzes/quizzes_historic.cfm"><i class="fa fa-search"></i> <span>Historic Quizzes</span> <span class="label label-danger pull-right"><CFOUTPUT>#getquiznumbers.historic_number#</CFOUTPUT></span></a></li>

            <CFIF #logindetails.user_role_UUID# NEQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>
            	
                <li <CFIF #menupage# EQ 'manageusers'><CFOUTPUT>class="active"</CFOUTPUT></CFIF>><a href="../users/manage_users.cfm"><i class="fa fa-users"></i> <span>Manage Users</span> <span class="label label-info pull-right"><CFOUTPUT>#usersnumber.userscount#</CFOUTPUT></span></a></li>
 				
            </CFIF>
            
            <CFIF #logindetails.user_role_UUID# EQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>
            
            	<li <CFIF #menupage# EQ 'managedeletedusers'><CFOUTPUT>class="active"</CFOUTPUT></CFIF>><a href="../users/manage_deleted_users.cfm"><i class="fa fa-users text-danger"></i> <span>Deleted Users</span> <span class="label label-danger pull-right"><CFOUTPUT>#deletedusersnumber.deleteduserscount#</CFOUTPUT></span></a></li>
            
            </CFIF>
            
            <CFIF #logindetails.user_role_UUID# NEQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>   
                
                <li <CFIF #menupage# EQ 'manageplayers'><CFOUTPUT>class="active"</CFOUTPUT></CFIF>><a href="../players/manage_players.cfm"><i class="fa fa-gamepad"></i> <span>Manage Players</span> <span class="label bg-purple pull-right"><CFOUTPUT>#playersnumber.playerscount#</CFOUTPUT></span></a></li>
 
            </CFIF>
            
            <CFIF #logindetails.user_role_UUID# EQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>
            
            	<li <CFIF #menupage# EQ 'managedeletedplayers'><CFOUTPUT>class="active"</CFOUTPUT></CFIF>><a href="../players/manage_deleted_players.cfm"><i class="fa fa-gamepad text-danger"></i> <span>Deleted Players</span> <span class="label label-danger pull-right"><CFOUTPUT>#deletedplayersnumber.deletedplayerscount#</CFOUTPUT></span></a></li>
            
            </CFIF>
            
  		</ul>

	</section><!--- /.sidebar --->
    
</aside>
