%invoke JSocketAdapter.COMMON.UTIL.FLOW:getDesignPath%

<html>
  <head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv='content-type' content='text/html; charset=utf-8'>
    <meta http-equiv="expires" content="-1">
    <script src="%value designPath%webMethods.js.txt"></script>
    <link rel="stylesheet" type="text/css" href="%value designPath%webMethods.css">
    <script language="javascript">
    	function launchHelp() {
      	window.open('/JSocketAdapter/doc/Help/help.html', 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
      }
    </script>
  </head>

  <body>
  	<table width="100%">
			<tr>
					<td class="menusection-Settings">
						JSocketAdapter Package Home &gt;
						Basic Info &gt;
						About
					</td>
			</tr>
	</table>

    <table width="100%">
      <tr>
        <td><IMG SRC="%value designPath%images/blank.gif" height=10 width=10></td>
        <td>
          <table class="tableView" width="100%">
            <tr>
              <td class="heading" colspan=2>Copyright</td>
            </tr>
            <tr>
              <td class="evenrow-l" colspan=2>
                <table class="tableInline" width="100%" cellspacing="0px" cellpadding="0px">
                  <tr>
                    <td width="100%">
                      <table class="tableInline" border="0" width="100%"  cellspacing="0px" cellpadding="0px">
                        <tr>
                          <td width="20%" valign="top" ><IMG SRC="%value designPath%images/blank.gif" height=0 width=5><img src="%value designPath%images/SAG_BlueFlag_100x36.png" border="0">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="80%">
      	                    <b>JSocketAdapter</b>
      	                    <br><br>
      	                    <font style="font-family: trebuchet ms;">Copyright 2017. KML Co. all rights reserved.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
		                  </td>
                        </tr>                      
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>	
	
	<table width="100%">
      <tr>
        <td><IMG SRC="%value designPath%images/blank.gif" height=10 width=10></td>
        <td>
          <table class="tableView" width="100%">
            <tr>
              <td class="heading" colspan=2>About JSocketAdapter Administrator</td>
            </tr>
            <tr>
              <td class="evenrow-l" colspan=2>
                <table class="tableInline" width="100%" cellspacing="0px" cellpadding="0px">
                  <tr>
                    <td width="100%">
                      <table class="tableInline" border="0" width="100%"  cellspacing="0px" cellpadding="0px">
                        <tr>
                          <td width="20%" valign="top" ><IMG SRC="%value designPath%images/blank.gif" height=0 width=5><img src="%value designPath%images/SAG_BlueFlag_100x36.png" border="0">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="80%">
      	                    <b>JSocketAdapter</b>
      	                    <br><br>
      	                    <font style="font-family: trebuchet ms;">TCP/IP 프로토콜을 이용하여 전문 송수신을 할 수 있는 환경을 구성 해주고<br>
      	                    Socket Server와 Socket Client에 대한 관리 및 Socket 통신로그를 모니터링 할 수 있고<br>
      	                    시스템 운영에 필요한 부가적인 편리 기능을 제공한다.<br><br>
      	                    JSocketAdapter Package를 최초에 Install 하면 Custom Variable Value, Custom Variable 기본값들이 자동으로 등록된다.<br>
      	                    JSocketAdapter Package를 최초에 Install 한 후에 Integration Server를 Restart 해야 한다.
      	                    <br>
      	                    <a target='body' onclick="launchHelp();return false;" href='#'>Help</a>
				                    </font>      	
		                      </td>
                        </tr>                      
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
	</body>
</html>

%endinvoke%

%invoke JSocketAdapter.ADMIN:checkSocketLibLoading%
%ifvar loading equals('false')%
	<script language="javascript">
		alert("JSocketAdapter에서 필요한 Java Library가 Loading 되지 않았습니다.\nIntegration Server를 Restart 해야 합니다.");
	</script>
%endifvar%
%endinvoke%