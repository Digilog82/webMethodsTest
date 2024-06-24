<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=11">
		<title>JSocket Administration Index</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/layout.css">
		<script>
    	var doc = document.documentElement;
    	var ua = navigator.userAgent;
    	var agent = ua.indexOf("Trident/7.0") >= 0 || ua.indexOf("MSIE") >= 0 ? "IE" : "NotIE";
    	doc.setAttribute('data-useragent', agent);
    	if (agent == "IE") {
    	  document.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"/WmRoot/layout-ie.css\")");
    	}
    	else {
    	  document.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"/WmRoot/layout-nonie.css\")");
    	}
  	</script>  
  	<link rel="icon" HREF="/WmRoot/favicon.ico" />
	</head>
	<frameset rows="50,*" border="0" framespacing="0" spacing="0" frameborder="0">
		<frame src="top.dsp?onlyType=Yes" marginwidth="0" marginheight="0" border="0" name="topmenu" scrolling="no" noresize>
		<frameset cols="200,*" border="0" framespacing="0" spacing="0" frameborder="0">
			<frame src="asynchonclient-menu.dsp?systemName=%value systemName%" marginwidth="5" marginheight="5" name="menu" scrolling="auto" seamless="seamless">
			<frame src="asynchon-connection.dsp?systemName=%value systemName%&todo=onlinelist" marginwidth="0" marginheight="0" name="body">
		</frameset>
	</frameset>
	<noframes>
		<body>
			<blockquote><h4>Your browser does not support frames.  Support for frames is required to use the JSocket Custom Administrator.</h4>
			</blockquote>
		</body>
	</noframes>
</html>