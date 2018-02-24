# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
<script type="text/javascript">
$(document).ready(function() {
  $('a#cancel-link').click(function() {
  	if ($('input[name=content]').val() == '') {
	      	$('#new_post').remove();
			$('#new_link').show();
    } else {
		if (confirm('Are you sure?')) {
	      	$('#new_post').remove();
			$('#new_link').show();
		}
    }

  });
});
</script>

.backgroundimg {
	background-image: url(w-349443.jpg);
	background-size: cover;
	background-position: center center;
	background-repeat: no-repeat;
	
	height: 100%;
	width: 101%;
}