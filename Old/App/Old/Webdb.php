<?php

/************************************CONFIG****************************************/
//DATABSE DETAILS//
$DB_ADDRESS="localhost";
$DB_USER="taysidek_testacc";
$DB_PASS="Dsf%!1707";
$DB_NAME="taysidek_testdb";

//SETTINGS//
//This code is something you set in the APP so random people cant use it.
$SQLKEY="randomkey";
/************************************CONFIG****************************************/

//these are just in case setting headers forcing it to always expire and the content type to JSON
header('Cache-Control: no-cache, must-revalidate');
header('Content-type: application/json');
header('Content-Disposition: attachment; filename="JSON"');


if(isset($_POST['tag']) && ($_SERVER['CONTENT_TYPE'] == "application/x-www-form-urlencoded")){  //checks ifthe tag post is there and if its been a proper form post
        $tag=$_POST['tag'];
        $data=explode("||||||",$tag);   //split the SQL statement from the SQLKEY
        if($data[0]==$SQLKEY){          ///validate the SQL key
                $query=$data[1];
                if(get_magic_quotes_gpc()){     //check if the worthless pile of crap magic quotes is enabled and if it is strip the slashes from the query
                        $query=stripslashes($query);
                }
                $link = mysql_connect($DB_ADDRESS,$DB_USER,$DB_PASS);   //connect to the MYSQL database
                mysql_select_db($DB_NAME,$link);                        //connect to the right DB
                if($link){
                        $result=mysql_query($query);                    //runs the posted query (NO PROTECTION FROM INJECTION HERE)
                        if($result){
                                if (strlen(stristr($query,"SELECT"))>0) {       //tests if its a select statemnet
                                        $outputdata=array();
                                        while ($row = mysql_fetch_assoc($result)){
                                                $outputdata[]=$row;             //formats the result set to a valid array
                                        }
                                        echo json_encode(array("VALUE",$tag,array_merge($outputdata))); //sends out a JSON result with merged output data
                                } else {
                                        echo json_encode(array("VALUE",$tag,array_merge(array(array("AFFECTED_ROWS ".mysql_affected_rows($link)))))); //if the query is anything but a SELECT it will return the array eve$
                                }
                        } else echo json_encode(array("VALUE",$tag,array_merge(array(array(mysql_errno($link).": ".mysql_error($link)))))); //errors if the query is bad and spits the error back to the client
                        mysql_close($link);     //close the DB
                } else echo json_encode(array("VALUE",$tag,array_merge(array(array("ERROR Database Connection Failed"))))); //reports a DB connection failure

        } else {
                echo json_encode(array("VALUE",$tag,array_merge(array(array("ERROR BAD CODE SUPPLIED")))));     //reports if the code is bad
        }
}
?>

