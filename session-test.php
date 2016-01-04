<?php 
if( '' !== session_id() ) {
	session_start();
	$_SESSION['testing_sessions'] = 1;
} else {
	if( isset( $_SESSION['testing_sessions'] ) ) {
		$_SESSION['testing_sessions']++;
	}
}

echo "You've visited this page " . $_SESSION['testing_sessions'] . " times.";