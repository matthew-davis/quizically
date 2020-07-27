
<!--- Runs if toast details are passed through the url --->
<!--- Required variables: toastcode, toasttitle, toastmessage --->
<CFIF #IsDefined('url.toastcode')#>
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

				<CFIF #url.toastcode# EQ -1>
					toastr["error"]("#url.toastmessage#", "#url.toasttitle#");						
				<CFELSEIF #url.toastcode# EQ 1>
					toastr["success"]("#url.toastmessage#", "#url.toasttitle#");
				<CFELSE>
					toastr["error"]("Error", "Error");
				</CFIF>
			});
		</script>
	</CFOUTPUT>
</CFIF>
