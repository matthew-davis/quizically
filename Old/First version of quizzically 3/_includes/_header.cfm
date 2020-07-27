
<header class="main-header">

    <!--- Logo --->
    <a href="index2.html" class="logo">
          <!--- mini logo for sidebar mini 50x50 pixels --->
          <span class="logo-mini"><img src="../_img/logo_sm.png" /></span>
          <!--- logo for regular state and mobile devices --->
          <span class="logo-lg"><img src="../_img/logo_lg.png" /></span>
    </a>

	<!--- Header Navbar: style can be found in header.less --->
	<nav class="navbar navbar-static-top" role="navigation">
  
  		<!--- Sidebar toggle button--->
  		<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
    		<span class="sr-only">Toggle navigation</span>
  		</a>
  
  		<!--- Navbar Right Menu --->
  		<div class="navbar-custom-menu">
    		
            <ul class="nav navbar-nav">

                <!--- User Account: style can be found in dropdown.less --->
                <li class="dropdown user user-menu">
            
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    
                    	<!--- Insert logged in user avatar or default to generic avatar --->
						<CFIF #logindetails.uploadfile1# NEQ ''>
                        	<CFOUTPUT QUERY = 'logindetails'>
                        		<img src="../_img/avatars/#user_details_UUID#/#uploadfile1#" class="user-image" alt="User Image" />
                        	</CFOUTPUT>
                        <CFELSE>
                        	<img src="../_img/generic_avatar.png" class="user-image" alt="User Image" />
                        </CFIF>
                        
                        <!--- Insert logged in user name --->
                        <span class="hidden-xs"><CFOUTPUT QUERY="logindetails"><CFIF #IsDefined('logindetails.user_firstname')#>#user_firstname# #user_lastname#<CFELSE>#email_name#</CFIF></CFOUTPUT></span>
                    </a>
            
                    <ul class="dropdown-menu">
              
                        <!--- User image --->
                        <li class="user-header">
                            <!--- Insert logged in user avatar or default to generic avatar --->
							<CFIF #logindetails.uploadfile1# NEQ ''>
                                <CFOUTPUT QUERY = 'logindetails'>
                                    <img src="../_img/avatars/#user_details_UUID#/#uploadfile1#" class="img-circle" alt="User Image" />
                                </CFOUTPUT>
                            <CFELSE>
                                <img src="../_img/generic_avatar.png" class="img-circle" alt="User Image" />
                            </CFIF>
                            <p>
                                <CFOUTPUT QUERY="logindetails">
                                    #user_role#
                                    <small>Member since #DateFormat(member_since, 'mmm. yyyy')#</small>
                                </CFOUTPUT>
                            </p>
                        </li>
                        
                        <!--- Menu Footer--->
                        <li class="user-footer">
                            <div class="pull-left">
                                <a href="../profile/users_profile.cfm" class="btn btn-warning btn-flat">Profile</a>
                            </div>
                
                            <div class="pull-right">
                                <a href="../logout.cfm" class="btn btn-danger btn-flat">Sign out</a>
                            </div>
                        </li>
            
                    </ul>
          
                </li>
          
                <!--- Control Sidebar Toggle Button --->
                <li>
                    <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
                </li>
        
            </ul>
      
        </div>

	</nav>
    
</header>
     