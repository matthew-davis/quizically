
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />

        <style>
			label.error {
				margin-top: 10px;
				color: #DD4B39;
			}
		</style>

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

        <!--- Menu Bookmark Variable --->
        <CFSET menupage = 'createquiz' />

	</head>


    <!--- Logged in user details --->
    <CFSET loginObj = CreateObject("component","quizzicallyincludes.login") />
	<CFSCRIPT>
        loginObj.dsn = dsn;
		loginObj.username = cookie.myadmin_username;
		loginObj.password = cookie.myadmin_password;
        logindetails = loginObj.getLoginDetails();
    </CFSCRIPT>

    <!--- Quiz details --->
    <CFSET quizzesObj = CreateObject("component","quizzicallyincludes.quizzes") />
    <CFSCRIPT>
		quizzesObj.dsn = dsn;
		getlocations = quizzesObj.getLocations();
		getcategories = quizzesObj.getCategories();
	</CFSCRIPT>


	<body class="hold-transition sidebar-mini skin-blue">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />


            <!--- Content Wrapper. Contains page content --->
      		<div class="content-wrapper">

            	<section class="content-header">
                  	<h1>
                    	CREATE A Quiz
                    </h1>
                	<ol class="breadcrumb">
                    	<li><a href="../dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active"><i class="fa fa-pencil"></i> Create a Quiz</li>
                	</ol>
                </section>

                <section class="content">

                    <div class="row">

                    	<!-- form start -->
                        <form role="form" method="post" action="./quizzes_process.cfm" name="myform" id="myform">

                            <!--- column width --->
                            <div class="col-md-12">

                                <!--- general form elements --->
                                <div class="box box-primary">

                                	<div class="box-header with-border">

                                    	<p>Fields marked with an <span class="text-red" style="font-size: 20px;">*</span> must be filled in
                                        &nbsp;&nbsp;&nbsp;&nbsp;
            							<strong><span id="quizdescription1">&nbsp;</span><span id="quizdescription2"></span></strong></p>

                                    </div>

                                    <div class="box-body">

                                        <div class="row">

                                            <div class="col-md-4">

                                                <div class="form-group">
                                                    <label>Rounds</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-quiz" name="quiz_rounds" id="quiz_rounds" style="width: 100%;">
                                                        <option value="">&nbsp;</option>
                                                        <option value="1">1 Round</option>
                                                        <option value="2">2 Rounds</option>
                                                        <option value="3">3 Rounds</option>
                                                        <option value="4">4 Rounds</option>
                                                        <option value="5">5 Rounds</option>
                                                        <option value="6">6 Rounds</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label>Questions</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-quiz" name="quiz_questions" id="quiz_questions" style="width: 100%;">
                                                        <option value="">&nbsp;</option>
                                                        <option value="5">5 Questions</option>
                                                        <option value="10">10 Questions</option>
                                                        <option value="15">15 Questions</option>
                                                        <option value="20">20 Questions</option>
                                                        <option value="25">25 Questions</option>
                                                        <option value="30">30 Questions</option>
                                                        <option value="35">35 Questions</option>
                                                        <option value="40">40 Questions</option>
                                                        <option value="45">45 Questions</option>
                                                        <option value="50">50 Questions</option>
                                                        <option value="55">55 Questions</option>
                                                        <option value="60">60 Questions</option>
                                                        <option value="65">65 Questions</option>
                                                        <option value="70">70 Questions</option>
                                                        <option value="75">75 Questions</option>
                                                        <option value="80">80 Questions</option>
                                                        <option value="85">85 Questions</option>
                                                        <option value="90">90 Questions</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label>Quiz Location</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-quiz" name="quiz_location" id="quiz_location" style="width: 100%;">
                                                        <option value="">&nbsp;</option>
                                                        <CFOUTPUT QUERY="getlocations">
                                                            <option value="#location_UUID#">#location#</option>
                                                        </CFOUTPUT>
                                                    </select>
                                                </div>

                                            </div>

                                            <div class="col-md-4">

                                            	<input type="hidden" class="hiddencategory" name="category1" id="category1" value"" style="display: inline;" />
                                                <input type="hidden" class="hiddencategory" name="category2" id="category2" value"" style="display: inline;" />
                                                <input type="hidden" class="hiddencategory" name="category3" id="category3" value"" style="display: inline;" />
                                                <input type="hidden" class="hiddencategory" name="category4" id="category4" value"" style="display: inline;" />
                                                <input type="hidden" class="hiddencategory" name="category5" id="category5" value"" style="display: inline;" />
                                                <input type="hidden" class="hiddencategory" name="category6" id="category6" value"" style="display: inline;" />

                                            	<div class="form-group roundcategory" style="display: none;">
                                                    <label>Round 1 - Category</label>  <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-category" name="category1" id="category1" style="width: 100%;">
                                                        <CFOUTPUT QUERY="getcategories">
                                                                <option value="#category_UUID#">#category#</option>
                                                            </CFOUTPUT>
                                                    </select>
                                                </div>

                                                <div class="form-group roundcategory" style="display: none;">
                                                    <label>Round 2 - Category</label>  <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-category" name="category2" id="category2" style="width: 100%;">
                                                        <CFOUTPUT QUERY="getcategories">
                                                                <option value="#category_UUID#">#category#</option>
                                                            </CFOUTPUT>
                                                    </select>
                                                </div>

                                                <div class="form-group roundcategory" style="display: none;">
                                                    <label>Round 3 - Category</label>  <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-category" name="category3" id="category3" style="width: 100%;">
                                                        <CFOUTPUT QUERY="getcategories">
                                                                <option value="#category_UUID#">#category#</option>
                                                            </CFOUTPUT>
                                                    </select>
                                                </div>

                                            </div>

                                            <div class="col-md-4">

                                            	<div class="form-group roundcategory" style="display: none;">
                                                    <label>Round 4 - Category</label>  <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-category" name="category4" id="category4" style="width: 100%;">
                                                        <CFOUTPUT QUERY="getcategories">
                                                                <option value="#category_UUID#">#category#</option>
                                                            </CFOUTPUT>
                                                    </select>
                                                </div>

                                                <div class="form-group roundcategory" style="display: none;">
                                                    <label>Round 5 - Category</label>  <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-category" name="category5" id="category5" style="width: 100%;">
                                                        <CFOUTPUT QUERY="getcategories">
                                                                <option value="#category_UUID#">#category#</option>
                                                            </CFOUTPUT>
                                                    </select>
                                                </div>

                                                <div class="form-group roundcategory" style="display: none;">
                                                    <label>Round 6 - Category</label>  <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-category" name="category6" id="category6" style="width: 100%;">
                                                        <CFOUTPUT QUERY="getcategories">
                                                                <option value="#category_UUID#">#category#</option>
                                                            </CFOUTPUT>
                                                    </select>
                                                </div>

                                            </div>

                                        </div>

                                    </div><!--- /.box-body --->

                                    <div class="box-footer">
                                        <button type="submit" class="btn btn-primary">Start Quiz</button>
                                    </div>

                             	</div><!--- /.box --->

                            </div>

                         </form>

                    </div>

                </section>

            </div>


            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />

    	</div><!--- ./wrapper --->

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" />

        <script type="text/javascript" language="javascript">
			$(document).ready(function() {
				$("#myform").validate({
					rules: {
						quiz_rounds: "required",
						quiz_questions: "required",
						quiz_location: "required"
					},
					messages: {
						quiz_rounds: "Please select number of rounds",
						quiz_questions: "Please select number of questions per round",
						quiz_location: "Please select a location"
					},
				  	errorPlacement: function(error, element) {
						var dropdown = element.parent().find('.dropdown-wrapper');
						error.insertAfter(dropdown);
				  	}
				});

				$(".select2-quiz").select2( {
					minimumResultsForSearch: Infinity
				});

				$(".select2-category").select2( {
					minimumResultsForSearch: Infinity
				});

				var round1 = '<option selected="selected" value=""></option><option value="5">5 Questions</option><option value="10">10 Questions</option><option value="15">15 Questions</option><option value="20">20 Questions</option><option value="25">25 Questions</option><option value="30">30 Questions</option><option value="35">35 Questions</option><option value="40">40 Questions</option><option value="45">45 Questions</option><option value="50">50 Questions</option><option value="55">55 Questions</option><option value="60">60 Questions</option><option value="65">65 Questions</option><option value="70">70 Questions</option><option value="75">75 Questions</option><option value="80">80 Questions</option><option value="85">85 Questions</option><option value="90">90 Questions</option>';
				var round2 = '<option selected="selected" value=""></option><option value="5">5 Questions</option><option value="10">10 Questions</option><option value="15">15 Questions</option><option value="20">20 Questions</option><option value="25">25 Questions</option><option value="30">30 Questions</option><option value="35">35 Questions</option><option value="40">40 Questions</option><option value="45">45 Questions</option>';
				var round3 = '<option selected="selected" value=""></option><option value="5">5 Questions</option><option value="10">10 Questions</option><option value="15">15 Questions</option><option value="20">20 Questions</option><option value="25">25 Questions</option><option value="30">30 Questions</option>';
				var round4 = '<option selected="selected" value=""></option><option value="5">5 Questions</option><option value="10">10 Questions</option><option value="15">15 Questions</option><option value="20">20 Questions</option>';
				var round5 = '<option selected="selected" value=""></option><option value="5">5 Questions</option><option value="10">10 Questions</option><option value="15">15 Questions</option>';
				var round6 = '<option selected="selected" value=""></option><option value="5">5 Questions</option><option value="10">10 Questions</option><option value="15">15 Questions</option>';

				$("#quiz_rounds").on('change', function() {
					$('.roundcategory').hide().slice( 0, $(this).val() ).show();
					$('.hiddencategory').show().slice( 0, $(this).val() ).hide();
					$("#quiz_questions").val('').trigger('change');
					$("#quizdescription2").html('');
					$("#quizdescription1").html('Quiz - '.concat($(this).val(), ' Round(s) '));
					if ($(this).val() == "1") {
						$("#quiz_questions").html(round1);
					} else if ($(this).val() == "2") {
						$("#quiz_questions").html(round2);
					} else if ($(this).val() == "3") {
						$("#quiz_questions").html(round3);
					} else if ($(this).val() == "4") {
						$("#quiz_questions").html(round4);
					} else if ($(this).val() == "5") {
						$("#quiz_questions").html(round5);
					} else if ($(this).val() == "6") {
						$("#quiz_questions").html(round6);
					}
				});

				$("#quiz_questions").on('change', function() {
					var totalquestions = parseInt($(this).val()) * parseInt($("#quiz_rounds").val())
					$("#quizdescription2").html('of '.concat($(this).val(), ' Questions - ', totalquestions.toString(), ' Total Questions'));
				});
			});
		</script>

	</body>

</html>
