<?php 
$status = "";
$status_msg = "";

if( isset( $_POST['action'] ) && $_POST['action'] === 'perform_write_test' ) {

	$my_text = filter_input( INPUT_POST, 'my_text', FILTER_SANITIZE_STRING );

	if( !empty( $my_text ) ) {

		$filename = "saved-text-" . time() . ".txt";
		$fh = fopen( $filename, 'w' );

		if( FALSE !== fwrite( $fh, $my_text ) ) {

			$status = "success";
			$status_msg = "Successfully saved your snippet to disk";

		} else {

			$status = "error";
			$status_msg = "Failed to save your snipped to disk";

		}

	}

}

?>
<html>
	<head>
		<title>Enter some text for a write test</title>
		<style>
			.success {
				color: green;
			}

			.error {
				color: red;
			}
		</style>
	</head>
	<body>
		<form action="" method="POST">
			<div class="status <?php echo $status; ?>"><?php echo ( !empty( $status_msg ) ) ? $status_msg : "Please submit some text to save to disk."; ?></div>
			<input type="hidden" name="action" value="perform_write_test">
			<textarea name="my_text" id="" cols="30" rows="10" placeholder="enter some text to save to disk"></textarea>
			<p><input type="submit" value="Save this Text to Disk"></p>
		</form>
	</body>
</html>