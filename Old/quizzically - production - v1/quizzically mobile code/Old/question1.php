<table>
	<form NAME ="Question1" METHOD = "POST" ACTION = "quizzically_web_app_2.php">
	<tr>
		<td colspan="2"><?PHP echo "Question Number:  <b>" . $temp_question . "</b><br><br>"; ?></td>
	</tr>
	<tr>
		<td colspan="2">
		<?PHP 
		
			$query = sprintf("SELECT CASE WHEN c.USE_NAME IS NULL THEN LEFT(c.USE_EMAIL, (LOCATE('@', c.USE_EMAIL) - 1)) ELSE c.USE_NAME END AS PARTICIPANT,
								     a.PART_SCORE,
									 a.PART_LAST_SCORE
								FROM P_PARTICIPANTS a, P_QUIZ b, P_USERS c 
								WHERE a.QUIZ_ID = b.QUIZ_ID
								AND a.USE_ID = c.USE_ID
								AND b.QUIZ_CODE = '%s'
								ORDER BY a.PART_SCORE", $_SESSION['code']);
			
			$result = mysql_query($query);

			echo "<table border='1'>
			<tr>
			<th>Participant</th>
			<th>Score</th>
			<th>Last Question Score</th>
			</tr>";

			while($row = mysql_fetch_array($result)) {
  
				echo "<tr>";
				echo "<td>" . $row['PARTICIPANT'] . "</td>";
				echo "<td>" . $row['PART_SCORE'] . "</td>";
				echo "<td>" . $row['PART_LAST_SCORE'] . "</td>";
				echo "</tr>";
			
			}

			echo "</table>"; 
		?>
		</td>
	</tr>
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
		<td><br><br><INPUT TYPE = "submit" NAME = "Submit3" VALUE = "Release Question">
		<INPUT TYPE = "submit" NAME = "Submit5" VALUE = "Intermission"></td>
	</tr>
	</form>
</table>