%invoke JSocketAdapter.ADMIN:getMenuInfo%

<html>
	<head>
		<title>Socket Adapter Administration Menu</title>
		<link rel="stylesheet" type="text/css" href="%value designPath%webMethods.css">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
		<script src="%value designPath%common-menu.js"></script>
		<script src="%value designPath%csrf-guard.js"></script>
		<script type="text/javascript">
			var selected = null;
			var menuInit = false;
    	
			function menuSelect(object, id) {
			  selected = menuext.select(object, id, selected);
			}
			
			function menuMouseOver(object, id) {
			  menuext.mouseOver(object, id, selected);
			}
			
			function menuMouseOut(object, id) {
			  menuext.mouseOut(object, id, selected);
			}
			
			function initMenu(firstImage) {
			    menuInit = true;
			    return true;
			}
		</script>
	</head>
	<body class="menu">
		<table class="menuTable" width="100%" cellspacing="0" cellpadding="0" border="0">
		
			<tr manualhide="false" onClick="toggle(this, '%value systemName%_subMenu', '%value systemName%_twistie');" OnMouseOver="this.className='cursor';">
				<td class="menusection menusection-expanded"
					id="elmt_%value systemName%_subMenu"/>
					<img id='%value systemName%_twistie' src="%value designPath%images/expanded.gif">&nbsp;%value systemName% Online Client
				</td>
			</tr>
			<tr name="%value systemName%_subMenu" style="display: table-row">
				<td id="i%value systemName%-connection.dsp" class="menuitem menuitem-selected"
					onmouseover="menuMouseOver(this, '%value systemName%-connection.dsp');"
          				onmouseout="menuMouseOut(this, '%value systemName%-connection.dsp');"
          				onclick="menuSelect(this, '%value systemName%-connection.dsp'); document.all['a%value systemName%-connection.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Connection";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value systemName%-connection.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value systemName%-connection.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value systemName%-connection.dsp" target="body" href="asynchon-connection.dsp?systemName=%value systemName%&todo=onlinelist"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="%value systemName%_subMenu" style="display: table-row">
				<td id="i%value systemName%-scheduler.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value systemName%-scheduler.dsp');"
          				onmouseout="menuMouseOut(this, '%value systemName%-scheduler.dsp');"
          				onclick="menuSelect(this, '%value systemName%-scheduler.dsp'); document.all['a%value systemName%-scheduler.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Check Schedule";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value systemName%-scheduler.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value systemName%-scheduler.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value systemName%-scheduler.dsp" target="body" href="asynchon-scheduler.dsp?systemName=%value systemName%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="%value systemName%_subMenu" style="display: table-row">
				<td id="i%value systemName%-trigger.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value systemName%-trigger.dsp');"
          				onmouseout="menuMouseOut(this, '%value systemName%-trigger.dsp');"
          				onclick="menuSelect(this, '%value systemName%-trigger.dsp'); document.all['a%value systemName%-trigger.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Trigger";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value systemName%-trigger.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value systemName%-trigger.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value systemName%-trigger.dsp" target="body" href="asynchon-trigger.dsp?systemName=%value systemName%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			<!-- AS/400 시스템이 존재하고 Data Q를 이용해서 Asynch Online 방식의 Socket 구현을 위해서 ESB와 연계하는 경우에만 Display -->
			%ifvar as400AsynchOnline equals('true')%
			<tr name="%value systemName%_subMenu" style="display: table-row">
				<td id="i%value systemName%-dqlistener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value systemName%-dqlistener.dsp');"
          				onmouseout="menuMouseOut(this, '%value systemName%-dqlistener.dsp');"
          				onclick="menuSelect(this, '%value systemName%-dqlistener.dsp'); document.all['a%value systemName%-dqlistener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Data Q Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value systemName%-dqlistener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value systemName%-dqlistener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value systemName%-dqlistener.dsp" target="body" href="asynchon-dqlistener.dsp?systemName=%value systemName%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%endifvar%
			
			<tr name="%value systemName%_subMenu" style="display: table-row">
				<td id="i%value systemName%-switchsocket.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value systemName%-switchsocket.dsp');"
          				onmouseout="menuMouseOut(this, '%value systemName%-switchsocket.dsp');"
          				onclick="menuSelect(this, '%value systemName%-switchsocket.dsp'); document.all['a%value systemName%-switchsocket.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Switch Socket Operation";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value systemName%-switchsocket.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value systemName%-switchsocket.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value systemName%-switchsocket.dsp" target="body" href="asynchon-switchsocket.dsp?switching=&systemName=%value systemName%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="%value systemName%_subMenu" style="display: table-row">
				<td id="i%value systemName%-switchingschedule.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value systemName%-switchingschedule.dsp');"
          				onmouseout="menuMouseOut(this, '%value systemName%-switchingschedule.dsp');"
          				onclick="menuSelect(this, '%value systemName%-switchingschedule.dsp'); document.all['a%value systemName%-switchingschedule.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Switching Schedule";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value systemName%-switchingschedule.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value systemName%-switchingschedule.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value systemName%-switchingschedule.dsp" target="body" href="asynchon-switchingschedule.dsp?systemName=%value systemName%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="%value systemName%_subMenu" style="display: table-row">
				<td id="i%value systemName%-errorhistory.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value systemName%-errorhistory.dsp');"
          				onmouseout="menuMouseOut(this, '%value systemName%-errorhistory.dsp');"
          				onclick="menuSelect(this, '%value systemName%-errorhistory.dsp'); document.all['a%value systemName%-errorhistory.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Error History";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value systemName%-errorhistory.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value systemName%-errorhistory.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value systemName%-errorhistory.dsp" target="body" href="asynchon-errorhistory.dsp?todo=search&systemName=%value systemName%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>									
		</table>
	</body>
</html>

%endinvoke%