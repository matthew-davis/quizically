<table>
	<form NAME ="Question Release" METHOD = "POST" ACTION = "quizzically_web_app_2.php">
	<tr>
		<td colspan="2"><?PHP print $category; ?></td>
	</tr>
	<tr>
		<td colspan="2"><br></td>
	</tr>
	<tr>
		<td colspan="2"><?PHP print $question; ?></td>
	</tr>
	<tr>
		<td colspan="2"><br></td>
	</tr>
	<tr>
		<td><?PHP print $ans_a; ?></td>
		<td><?PHP if($ans_correct == 'A') { print "<b>Correct</b>"; } ?></td>
	</tr>
	<tr>
		<td><?PHP print $ans_b; ?></td>
		<td><?PHP if($ans_correct == 'B') { print "<b>Correct</b>"; } ?></td>
	</tr>
	<tr>
		<td><?PHP print $ans_c; ?></td>
		<td><?PHP if($ans_correct == 'C') { print "<b>Correct</b>"; } ?></td>
	</tr>
	<tr>
		<td><?PHP print $ans_d; ?></td>
		<td><?PHP if($ans_correct == 'D') { print "<b>Correct</b>"; } ?></td>
	</tr>
	<tr>
		<td><br><br><INPUT TYPE = "Submit" NAME = "Submit2" VALUE = "Release Question"></td>
	</tr>
	</form>
</table>