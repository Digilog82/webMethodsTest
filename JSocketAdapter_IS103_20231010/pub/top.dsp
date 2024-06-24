%invoke JSocketAdapter.ADMIN:getTopAdminInfo%

<html>
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="%value designPath%top.css">
    <link rel="stylesheet" type="text/css" href="%value designPath%webMethods.css">
    <script src="%value designPath%csrf-guard.js"></script>
  </head>
  
  <body class="menu" leftMargin=0 topMargin=0 marginwidth="0" marginheight="0">
    <table border=0 cellspacing=0 cellpadding=0 height=100% width=100%>
      <tr>
	    	<td>
	  			<table width=100% cellspacing=0 border=0>
            <tr>
              <td nowrap class="toptitle" width="100%">
		  					<b>&nbsp;&nbsp;&nbsp;%value companyName% Socket Administration (%value serverDetailName%)</b>
              </td>
            </tr>
	  			</table>
				</td>
      </tr>
    </table>
  </body>
</html>

%endinvoke%