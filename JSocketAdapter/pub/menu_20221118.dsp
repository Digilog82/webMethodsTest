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
			
			function launchHelp() {
      	window.open('/JSocketAdapter/doc/Help/help.html', 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
      }
		</script>
	</head>
	<body class="menu">
		<table class="menuTable" width="100%" cellspacing="0" cellpadding="0" border="0">
		
			<!-- Basic Info -->
			<tr manualhide="true" onClick="toggle(this, 'BasicInfo_subMenu', 'BasicInfo_twistie');" OnMouseOver="this.className='cursor';">
  			<td class="menusection menusection-collapsed"
					id="elmt_BasicInfo_subMenu"/>
					<img id='BasicInfo_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;Basic Info
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-about.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-about.dsp');"
          				onmouseout="menuMouseOut(this, 'basic-about.dsp');"
          				onclick="menuSelect(this, 'basic-about.dsp'); document.all['abasic-about.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "About";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-about.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="abasic-about.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="abasic-about.dsp" target="body" href="basic-about.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ihelp.html" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'help.html');"
          				onmouseout="menuMouseOut(this, 'help.html');"
          				onclick="menuSelect(this, 'help.html'); document.all['ahelp.html'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Help";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "help.html", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="ahelp.html" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="ahelp.html" target="body" onclick="launchHelp();return false;" href="#"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-customvariablevalue.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-customvariablevalue.dsp');"
          				onmouseout="menuMouseOut(this, 'basic-customvariablevalue.dsp');"
          				onclick="menuSelect(this, 'basic-customvariablevalue.dsp'); document.all['abasic-customvariablevalue.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Custom Variable Value";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-customvariablevalue.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="abasic-customvariablevalue.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="abasic-customvariablevalue.dsp" target="body" href="basic-customvariablevalue.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-customvariable.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-customvariable.dsp');"
          				onmouseout="menuMouseOut(this, 'basic-customvariable.dsp');"
          				onclick="menuSelect(this, 'basic-customvariable.dsp'); document.all['abasic-customvariable.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Custom Variable";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-customvariable.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="abasic-customvariable.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="abasic-customvariable.dsp" target="body" href="basic-customvariable.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-systemname.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-systemname.dsp');"
          				onmouseout="menuMouseOut(this, 'basic-systemname.dsp');"
          				onclick="menuSelect(this, 'basic-systemname.dsp'); document.all['abasic-systemname.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "System Name";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-systemname.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="abasic-systemname.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="abasic-systemname.dsp" target="body" href="basic-systemname.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-businessname.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-businessname.dsp');"
          				onmouseout="menuMouseOut(this, 'basic-businessname.dsp');"
          				onclick="menuSelect(this, 'basic-businessname.dsp'); document.all['abasic-businessname.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Business Name";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-businessname.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="abasic-businessname.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="abasic-businessname.dsp" target="body" href="basic-businessname.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-restapiprotocol.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-restapiprotocol.dsp');"
          				onmouseout="menuMouseOut(this, 'basic-restapiprotocol.dsp');"
          				onclick="menuSelect(this, 'basic-restapiprotocol.dsp'); document.all['abasic-restapiprotocol.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "REST API Protocol";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-restapiprotocol.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="abasic-restapiprotocol.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="abasic-restapiprotocol.dsp" target="body" href="basic-restapiprotocol.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-docinterfaceid.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-docinterfaceid.dsp');"
          				onmouseout="menuMouseOut(this, 'basic-docinterfaceid.dsp');"
          				onclick="menuSelect(this, 'basic-docinterfaceid.dsp'); document.all['abasic-docinterfaceid.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Interface Doc";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-docinterfaceid.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="abasic-docinterfaceid.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="abasic-docinterfaceid.dsp" target="body" href="basic-docinterfaceid.dsp?todo=docSearch"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			<!-- Doc Class Search(현대제철 전용) -->
			%ifvar customerCode equals('HSC')%
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-docclasssearch-hsc.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-docclasssearch-hsc.dsp');"
          			onmouseout="menuMouseOut(this, 'basic-docclasssearch-hsc.dsp');"
          			onclick="menuSelect(this, 'basic-docclasssearch-hsc.dsp'); document.all['abasic-docclasssearch-hsc.dsp'].click();">
					<span style="white-space: nowrap">
						<script>
						var label = "";
						if (!label) {
							label = "Doc Class Search";
						}
						label = label.replace(/NBSP/g, ' ');
						if (is_csrf_guard_enabled && needToInsertToken) {
							createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-docclasssearch-hsc.dsp", "POST", "BODY", "body");
							setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
							document.write('<a id="abasic-docclasssearch-hsc.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
						} else {
							document.write('<a id="abasic-docclasssearch-hsc.dsp" target="body" href="basic-docclasssearch-hsc.dsp?todo="> ' + label + '  </a>');
						}
						</script>
					</span>
				</td>
			</tr>
			%endifvar%
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-localfile.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-localfile.dsp');"
          				onmouseout="menuMouseOut(this, 'basic-localfile.dsp');"
          				onclick="menuSelect(this, 'basic-localfile.dsp'); document.all['abasic-localfile.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Delete Local File";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-localfile.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="abasic-localfile.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="abasic-localfile.dsp" target="body" href="basic-localfile.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-localfileschedule.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-localfileschedule.dsp');"
          				onmouseout="menuMouseOut(this, 'basic-localfileschedule.dsp');"
          				onclick="menuSelect(this, 'basic-localfileschedule.dsp'); document.all['abasic-localfileschedule.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local File Delete Schedule";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-localfileschedule.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="abasic-localfileschedule.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="abasic-localfileschedule.dsp" target="body" href="basic-localfileschedule.dsp?enable=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>			
			<tr name="BasicInfo_subMenu" style="display: none">
				<td id="ibasic-stemail.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'basic-stemail.dsp');"
          				onmouseout="menuMouseOut(this, 'basic-stemail.dsp');"
          				onclick="menuSelect(this, 'basic-stemail.dsp'); document.all['abasic-stemail.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Source Target Email";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "basic-stemail.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="abasic-stemail.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="abasic-stemail.dsp" target="body" href="basic-stemail.dsp?todo=emailSearch"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>						
			
			<!-- AS/400 -->
			<!-- AS/400 시스템이 존재하고 Data Q를 이용해서 ESB와 연계하는 경우에만 Display -->
			%ifvar as400DataQUse equals('true')%
			<tr manualhide="true" onClick="toggle(this, 'AS400_subMenu', 'AS400_twistie');" OnMouseOver="this.className='cursor';">
  			<td class="menusection menusection-collapsed"
					id="elmt_AS400_subMenu"/>
					<img id='AS400_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;AS/400
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td id="ias400-dataqlistener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'as400-dataqlistener.dsp');"
          				onmouseout="menuMouseOut(this, 'as400-dataqlistener.dsp');"
          				onclick="menuSelect(this, 'as400-dataqlistener.dsp'); document.all['aas400-dataqlistener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Data Q Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "as400-dataqlistener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aas400-dataqlistener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aas400-dataqlistener.dsp" target="body" href="as400-dataqlistener.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td id="ias400-togglelistener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'as400-togglelistener.dsp');"
          				onmouseout="menuMouseOut(this, 'as400-togglelistener.dsp');"
          				onclick="menuSelect(this, 'as400-togglelistener.dsp'); document.all['aas400-togglelistener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Toggle Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "as400-togglelistener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aas400-togglelistener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aas400-togglelistener.dsp" target="body" href="as400-togglelistener.dsp?systemName=ALL&enable=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td id="ias400-healthchecklistener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'as400-healthchecklistener.dsp');"
          				onmouseout="menuMouseOut(this, 'as400-healthchecklistener.dsp');"
          				onclick="menuSelect(this, 'as400-healthchecklistener.dsp'); document.all['aas400-healthchecklistener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Health Check Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "as400-healthchecklistener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aas400-healthchecklistener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aas400-healthchecklistener.dsp" target="body" href="as400-healthchecklistener.dsp?enable=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td id="ias400-reconnectlistener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'as400-reconnectlistener.dsp');"
          				onmouseout="menuMouseOut(this, 'as400-reconnectlistener.dsp');"
          				onclick="menuSelect(this, 'as400-reconnectlistener.dsp'); document.all['aas400-reconnectlistener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Reconnect Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "as400-reconnectlistener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aas400-reconnectlistener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aas400-reconnectlistener.dsp" target="body" href="as400-reconnectlistener.dsp?enable=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td id="ias400-changedq.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'as400-changedq.dsp');"
          				onmouseout="menuMouseOut(this, 'as400-changedq.dsp');"
          				onclick="menuSelect(this, 'as400-changedq.dsp'); document.all['aas400-changedq.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Change Data Queue";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "as400-changedq.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aas400-changedq.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aas400-changedq.dsp" target="body" href="as400-changedq.dsp?dqchange=search&systemName=ALL"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td id="ias400-changedqschedule.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'as400-changedqschedule.dsp');"
          				onmouseout="menuMouseOut(this, 'as400-changedqschedule.dsp');"
          				onclick="menuSelect(this, 'as400-changedqschedule.dsp'); document.all['aas400-changedqschedule.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Queue Change Reservation";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "as400-changedqschedule.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aas400-changedqschedule.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aas400-changedqschedule.dsp" target="body" href="as400-changedqschedule.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			%ifvar serverDuplexing matches('true')%
			
			<tr name="AS400_subMenu" style="display: none">
				<td id="ias400-switchlistener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'as400-switchlistener.dsp');"
          				onmouseout="menuMouseOut(this, 'as400-switchlistener.dsp');"
          				onclick="menuSelect(this, 'as400-switchlistener.dsp'); document.all['aas400-switchlistener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Switch Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "as400-switchlistener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aas400-switchlistener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aas400-switchlistener.dsp" target="body" href="as400-switchlistener.dsp?systemName=ALL&switching=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			%endifvar%
			
			%ifvar serverType matches('PROD*')%
			%else%
			
			<tr name="AS400_subMenu" style="display: none">
				<td id="ias400-deploylistener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'as400-deploylistener.dsp');"
          				onmouseout="menuMouseOut(this, 'as400-deploylistener.dsp');"
          				onclick="menuSelect(this, 'as400-deploylistener.dsp'); document.all['aas400-deploylistener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Deploy Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "as400-deploylistener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aas400-deploylistener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aas400-deploylistener.dsp" target="body" href="as400-deploylistener.dsp?systemName=ALL&deploy=search&searchType=noDeploy"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td id="ias400-reservationschedule.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'as400-reservationschedule.dsp');"
          				onmouseout="menuMouseOut(this, 'as400-reservationschedule.dsp');"
          				onclick="menuSelect(this, 'as400-reservationschedule.dsp'); document.all['aas400-reservationschedule.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Deployment Reservation";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "as400-reservationschedule.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aas400-reservationschedule.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aas400-reservationschedule.dsp" target="body" href="as400-reservationschedule.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			%endifvar%
			
			%endifvar%
			
			<!-- Server Socket -->
			<tr manualhide="true" onClick="toggle(this, 'ServerSocket_subMenu', 'ServerSocket_twistie');" OnMouseOver="this.className='cursor';">
  			<td class="menusection menusection-collapsed"
					id="elmt_ServerSocket_subMenu"/>
					<img id='ServerSocket_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;Server Socket
				</td>
			</tr>
			<tr name="ServerSocket_subMenu" style="display: none">
				<td id="isocket-localserver.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socket-localserver.dsp');"
          				onmouseout="menuMouseOut(this, 'socket-localserver.dsp');"
          				onclick="menuSelect(this, 'socket-localserver.dsp'); document.all['asocket-localserver.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Server Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socket-localserver.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocket-localserver.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocket-localserver.dsp" target="body" href="socket-localserver.dsp?todo=localSearch&portStatusCheck=true"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="ServerSocket_subMenu" style="display: none">
				<td id="isocket-remoteserver.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socket-remoteserver.dsp');"
          				onmouseout="menuMouseOut(this, 'socket-remoteserver.dsp');"
          				onclick="menuSelect(this, 'socket-remoteserver.dsp'); document.all['asocket-remoteserver.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Remote Server Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socket-remoteserver.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocket-remoteserver.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocket-remoteserver.dsp" target="body" href="socket-remoteserver.dsp?todo=remoteSearch"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			<!-- Asynch Online Socket Server가 존재하는 경우에만 Display -->
			<!-- Asynch Online Socket Server -->
			%ifvar onlinePortNumberList -notempty%
			<tr manualhide="true" onClick="toggle(this, 'OnlineServer_subMenu', 'OnlineServer_twistie');" OnMouseOver="this.className='cursor';">
  			<td class="menusection menusection-collapsed"
					id="elmt_OnlineServer_subMenu"/>
					<img id='OnlineServer_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;Online Server
				</td>
			</tr>
			%ifvar onlineDisplay equals('inlist')%
			<tr name="OnlineServer_subMenu" style="display: none">
				<td id="iasynchonserver-list.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'asynchonserver-list.dsp');"
          				onmouseout="menuMouseOut(this, 'asynchonserver-list.dsp');"
          				onclick="menuSelect(this, 'asynchonserver-list.dsp'); document.all['aasynchonserver-list.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Server List";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "asynchonserver-list.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aasynchonserver-list.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aasynchonserver-list.dsp" target="body" href="asynchonserver-list.dsp?todo=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="OnlineServer_subMenu" style="display: none">
				<td id="iasynchonserver-listener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'asynchonserver-listener.dsp');"
          				onmouseout="menuMouseOut(this, 'asynchonserver-listener.dsp');"
          				onclick="menuSelect(this, 'asynchonserver-listener.dsp'); document.all['aasynchonserver-listener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Server Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "asynchonserver-listener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aasynchonserver-listener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aasynchonserver-listener.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineServerListenerList&objectName=Online Server Listener"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%else%
			%loop onlinePortNumberList%
			<tr name="OnlineServer_subMenu" style="display: none">
				<td id="ion%value onlinePortNumberList%-connection.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'on%value onlinePortNumberList%-connection.dsp');"
          				onmouseout="menuMouseOut(this, 'on%value onlinePortNumberList%-connection.dsp');"
          				onclick="menuSelect(this, 'on%value onlinePortNumberList%-connection.dsp'); document.all['aon%value onlinePortNumberList%-connection.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Port %value onlinePortNumberList%";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "on%value onlinePortNumberList%-connection.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aon%value onlinePortNumberList%-connection.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aon%value onlinePortNumberList%-connection.dsp" target="body" href="asynchonserver-connection.dsp?portNumber=%value onlinePortNumberList%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>			
			%endloop%
			<tr name="OnlineServer_subMenu" style="display: none">
				<td id="iasynchonserver-listener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'asynchonserver-listener.dsp');"
          				onmouseout="menuMouseOut(this, 'asynchonserver-listener.dsp');"
          				onclick="menuSelect(this, 'asynchonserver-listener.dsp'); document.all['aasynchonserver-listener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Server Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "asynchonserver-listener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aasynchonserver-listener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aasynchonserver-listener.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineServerListenerList&objectName=Online Server Listener"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%endifvar%
			%endifvar%
			
			<!-- Asynch Online Socket Client가 존재하는 경우에만 Display -->
			<!-- Asynch Online Socket Client -->
			%ifvar onlineSystemNameList -notempty%
			%ifvar onlineDisplay equals('inlist')%
			<tr manualhide="true" onClick="toggle(this, 'OnlineClient_subMenu', 'OnlineClient_twistie');" OnMouseOver="this.className='cursor';">
			<td class="menusection menusection-collapsed"
					id="elmt_OnlineClient_subMenu"/>
					<img id='OnlineClient_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;Online Client
				</td>
			</tr>
			<tr name="OnlineClient_subMenu" style="display: none">
				<td id="iasynchonclient-list.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'asynchonclient-list.dsp');"
          				onmouseout="menuMouseOut(this, 'asynchonclient-list.dsp');"
          				onclick="menuSelect(this, 'asynchonclient-list.dsp'); document.all['aasynchonclient-list.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Client List";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "asynchonclient-list.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aasynchonclient-list.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aasynchonclient-list.dsp" target="body" href="asynchonclient-list.dsp?todo=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="OnlineClient_subMenu" style="display: none">
				<td id="iasynchonclient-listener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'asynchonclient-listener.dsp');"
          				onmouseout="menuMouseOut(this, 'asynchonclient-listener.dsp');"
          				onclick="menuSelect(this, 'asynchonclient-listener.dsp'); document.all['aasynchonclient-listener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Client Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "asynchonclient-listener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aasynchonclient-listener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aasynchonclient-listener.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineClientListenerList&objectName=Online Client Listener"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="OnlineClient_subMenu" style="display: none">
				<td id="iasynchonclient-healthcheck.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'asynchonclient-healthcheck.dsp');"
          				onmouseout="menuMouseOut(this, 'asynchonclient-healthcheck.dsp');"
          				onclick="menuSelect(this, 'asynchonclient-healthcheck.dsp'); document.all['aasynchonclient-healthcheck.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Health Check";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "asynchonclient-healthcheck.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aasynchonclient-healthcheck.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aasynchonclient-healthcheck.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineHealthCheckList&objectName=Online Health Check"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%else%
			%loop onlineSystemNameList%
			<tr manualhide="true" onClick="toggle(this, '%value onlineSystemNameList%_subMenu', '%value onlineSystemNameList%_twistie');" OnMouseOver="this.className='cursor';">
  			<td class="menusection menusection-collapsed"
					id="elmt_%value onlineSystemNameList%_subMenu"/>
					<img id='%value onlineSystemNameList%_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;%value onlineSystemNameList% Online Client
				</td>
			</tr>
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td id="i%value onlineSystemNameList%-connection.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-connection.dsp');"
          				onmouseout="menuMouseOut(this, '%value onlineSystemNameList%-connection.dsp');"
          				onclick="menuSelect(this, '%value onlineSystemNameList%-connection.dsp'); document.all['a%value onlineSystemNameList%-connection.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Connection";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value onlineSystemNameList%-connection.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value onlineSystemNameList%-connection.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value onlineSystemNameList%-connection.dsp" target="body" href="asynchon-connection.dsp?systemName=%value onlineSystemNameList%&todo=onlinelist"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td id="i%value onlineSystemNameList%-scheduler.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-scheduler.dsp');"
          				onmouseout="menuMouseOut(this, '%value onlineSystemNameList%-scheduler.dsp');"
          				onclick="menuSelect(this, '%value onlineSystemNameList%-scheduler.dsp'); document.all['a%value onlineSystemNameList%-scheduler.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Check Schedule";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value onlineSystemNameList%-scheduler.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value onlineSystemNameList%-scheduler.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value onlineSystemNameList%-scheduler.dsp" target="body" href="asynchon-scheduler.dsp?systemName=%value onlineSystemNameList%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td id="i%value onlineSystemNameList%-trigger.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-trigger.dsp');"
          				onmouseout="menuMouseOut(this, '%value onlineSystemNameList%-trigger.dsp');"
          				onclick="menuSelect(this, '%value onlineSystemNameList%-trigger.dsp'); document.all['a%value onlineSystemNameList%-trigger.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Trigger";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value onlineSystemNameList%-trigger.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value onlineSystemNameList%-trigger.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value onlineSystemNameList%-trigger.dsp" target="body" href="asynchon-trigger.dsp?systemName=%value onlineSystemNameList%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			<!-- AS/400 시스템이 존재하고 Data Q를 이용해서 Asynch Online 방식의 Socket 구현을 위해서 ESB와 연계하는 경우에만 Display -->
			%ifvar as400AsynchOnline equals('true')%
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td id="i%value onlineSystemNameList%-dqlistener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-dqlistener.dsp');"
          				onmouseout="menuMouseOut(this, '%value onlineSystemNameList%-dqlistener.dsp');"
          				onclick="menuSelect(this, '%value onlineSystemNameList%-dqlistener.dsp'); document.all['a%value onlineSystemNameList%-dqlistener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Data Q Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value onlineSystemNameList%-dqlistener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value onlineSystemNameList%-dqlistener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value onlineSystemNameList%-dqlistener.dsp" target="body" href="asynchon-dqlistener.dsp?systemName=%value onlineSystemNameList%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%endifvar%
			
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td id="i%value onlineSystemNameList%-switchsocket.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-switchsocket.dsp');"
          				onmouseout="menuMouseOut(this, '%value onlineSystemNameList%-switchsocket.dsp');"
          				onclick="menuSelect(this, '%value onlineSystemNameList%-switchsocket.dsp'); document.all['a%value onlineSystemNameList%-switchsocket.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Switch Socket Operation";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value onlineSystemNameList%-switchsocket.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value onlineSystemNameList%-switchsocket.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value onlineSystemNameList%-switchsocket.dsp" target="body" href="asynchon-switchsocket.dsp?switching=&systemName=%value onlineSystemNameList%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td id="i%value onlineSystemNameList%-switchingschedule.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-switchingschedule.dsp');"
          				onmouseout="menuMouseOut(this, '%value onlineSystemNameList%-switchingschedule.dsp');"
          				onclick="menuSelect(this, '%value onlineSystemNameList%-switchingschedule.dsp'); document.all['a%value onlineSystemNameList%-switchingschedule.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Switching Schedule";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value onlineSystemNameList%-switchingschedule.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value onlineSystemNameList%-switchingschedule.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value onlineSystemNameList%-switchingschedule.dsp" target="body" href="asynchon-switchingschedule.dsp?systemName=%value onlineSystemNameList%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td id="i%value onlineSystemNameList%-errorhistory.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-errorhistory.dsp');"
          				onmouseout="menuMouseOut(this, '%value onlineSystemNameList%-errorhistory.dsp');"
          				onclick="menuSelect(this, '%value onlineSystemNameList%-errorhistory.dsp'); document.all['a%value onlineSystemNameList%-errorhistory.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Error History";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "%value onlineSystemNameList%-errorhistory.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="a%value onlineSystemNameList%-errorhistory.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="a%value onlineSystemNameList%-errorhistory.dsp" target="body" href="asynchon-errorhistory.dsp?todo=search&systemName=%value onlineSystemNameList%"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%endloop%
			<tr manualhide="true" onClick="toggle(this, 'OnlineClient_subMenu', 'OnlineClient_twistie');" OnMouseOver="this.className='cursor';">
			<td class="menusection menusection-collapsed"
					id="elmt_OnlineClient_subMenu"/>
					<img id='OnlineClient_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;Online Client
				</td>
			</tr>
			<tr name="OnlineClient_subMenu" style="display: none">
				<td id="iasynchonclient-listener.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'asynchonclient-listener.dsp');"
          				onmouseout="menuMouseOut(this, 'asynchonclient-listener.dsp');"
          				onclick="menuSelect(this, 'asynchonclient-listener.dsp'); document.all['aasynchonclient-listener.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Client Listener";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "asynchonclient-listener.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aasynchonclient-listener.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aasynchonclient-listener.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineClientListenerList&objectName=Online Client Listener"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="OnlineClient_subMenu" style="display: none">
				<td id="iasynchonclient-healthcheck.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'asynchonclient-healthcheck.dsp');"
          				onmouseout="menuMouseOut(this, 'asynchonclient-healthcheck.dsp');"
          				onclick="menuSelect(this, 'asynchonclient-healthcheck.dsp'); document.all['aasynchonclient-healthcheck.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Health Check";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "asynchonclient-healthcheck.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aasynchonclient-healthcheck.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aasynchonclient-healthcheck.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineHealthCheckList&objectName=Online Health Check"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%endifvar%
			%endifvar%						
			
			<!-- Socket Log -->
			<tr manualhide="true" onClick="toggle(this, 'SocketLog_subMenu', 'SocketLog_twistie');" OnMouseOver="this.className='cursor';">
  			<td class="menusection menusection-collapsed"
					id="elmt_SocketLog_subMenu"/>
					<img id='SocketLog_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;Socket Log
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-localqueuelist.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-localqueuelist.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-localqueuelist.dsp');"
          				onclick="menuSelect(this, 'socketlog-localqueuelist.dsp'); document.all['asocketlog-localqueuelist.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Server Queue Info";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-localqueuelist.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-localqueuelist.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-localqueuelist.dsp" target="body" href="socketlog-localqueuelist.dsp?todo=search&sorting=queueTopic"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			%ifvar sAuditLogDisplay equals('true')%
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-localauditlist.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-localauditlist.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-localauditlist.dsp');"
          				onclick="menuSelect(this, 'socketlog-localauditlist.dsp'); document.all['asocketlog-localauditlist.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Server Audit Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-localauditlist.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-localauditlist.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-localauditlist.dsp" target="body" href="socketlog-localauditlist.dsp?todo=search&execType=S"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%endifvar%
			
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-localserver.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-localserver.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-localserver.dsp');"
          				onclick="menuSelect(this, 'socketlog-localserver.dsp'); document.all['asocketlog-localserver.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Server Socket Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-localserver.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-localserver.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-localserver.dsp" target="body" href="socketlog-localserver.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-localreauditlist.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-localreauditlist.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-localreauditlist.dsp');"
          				onclick="menuSelect(this, 'socketlog-localreauditlist.dsp'); document.all['asocketlog-localreauditlist.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Server Resubmit Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-localreauditlist.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-localreauditlist.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-localreauditlist.dsp" target="body" href="socketlog-localreauditlist.dsp?todo=search&execType=R"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-localskiplist.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-localskiplist.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-localskiplist.dsp');"
          				onclick="menuSelect(this, 'socketlog-localskiplist.dsp'); document.all['asocketlog-localskiplist.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Server Skip Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-localskiplist.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-localskiplist.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-localskiplist.dsp" target="body" href="socketlog-localskiplist.dsp?todo=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-localerrorlist.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-localerrorlist.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-localerrorlist.dsp');"
          				onclick="menuSelect(this, 'socketlog-localerrorlist.dsp'); document.all['asocketlog-localerrorlist.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Server Error Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-localerrorlist.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-localerrorlist.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-localerrorlist.dsp" target="body" href="socketlog-localerrorlist.dsp?todo=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-localconnectionlist.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-localconnectionlist.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-localconnectionlist.dsp');"
          				onclick="menuSelect(this, 'socketlog-localconnectionlist.dsp'); document.all['asocketlog-localconnectionlist.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Server Connection Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-localconnectionlist.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-localconnectionlist.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-localconnectionlist.dsp" target="body" href="socketlog-localconnectionlist.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-localonlinetrace.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-localonlinetrace.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-localonlinetrace.dsp');"
          				onclick="menuSelect(this, 'socketlog-localonlinetrace.dsp'); document.all['asocketlog-localonlinetrace.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Online Trace Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-localonlinetrace.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-localonlinetrace.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-localonlinetrace.dsp" target="body" href="socketlog-localonlinetrace.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			%ifvar cAuditLogDisplay equals('true')%
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-remoteauditlist.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-remoteauditlist.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-remoteauditlist.dsp');"
          				onclick="menuSelect(this, 'socketlog-remoteauditlist.dsp'); document.all['asocketlog-remoteauditlist.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Remote Server Audit Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-remoteauditlist.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-remoteauditlist.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-remoteauditlist.dsp" target="body" href="socketlog-remoteauditlist.dsp?todo=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%endifvar%
			
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-remoteserver.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-remoteserver.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-remoteserver.dsp');"
          				onclick="menuSelect(this, 'socketlog-remoteserver.dsp'); document.all['asocketlog-remoteserver.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Remote Server Socket Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-remoteserver.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-remoteserver.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-remoteserver.dsp" target="body" href="socketlog-remoteserver.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-remoteconnectionlist.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-remoteconnectionlist.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-remoteconnectionlist.dsp');"
          				onclick="menuSelect(this, 'socketlog-remoteconnectionlist.dsp'); document.all['asocketlog-remoteconnectionlist.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Remote Server Connection Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-remoteconnectionlist.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-remoteconnectionlist.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-remoteconnectionlist.dsp" target="body" href="socketlog-remoteconnectionlist.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>			
			
			<!-- Asynch Online Client Socket 이 있는 경우 -->			
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-remoteonlinetrace.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-remoteonlinetrace.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-remoteonlinetrace.dsp');"
          				onclick="menuSelect(this, 'socketlog-remoteonlinetrace.dsp'); document.all['asocketlog-remoteonlinetrace.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Remote Online Trace Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-remoteonlinetrace.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-remoteonlinetrace.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-remoteonlinetrace.dsp" target="body" href="socketlog-remoteonlinetrace.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-onlinetemphistory.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-onlinetemphistory.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-onlinetemphistory.dsp');"
          				onclick="menuSelect(this, 'socketlog-onlinetemphistory.dsp'); document.all['asocketlog-onlinetemphistory.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Remote Online Temp History Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-onlinetemphistory.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-onlinetemphistory.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-onlinetemphistory.dsp" target="body" href="socketlog-onlinetemphistory.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<!-- Asynch Online Client Socket 이 있는 경우 -->
			
			<tr name="SocketLog_subMenu" style="display: none">
				<td id="isocketlog-mailnoti.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'socketlog-mailnoti.dsp');"
          				onmouseout="menuMouseOut(this, 'socketlog-mailnoti.dsp');"
          				onclick="menuSelect(this, 'socketlog-mailnoti.dsp'); document.all['asocketlog-mailnoti.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Mail Notification Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "socketlog-mailnoti.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asocketlog-mailnoti.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asocketlog-mailnoti.dsp" target="body" href="socketlog-mailnoti.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			<!-- Utility -->
			<tr manualhide="true" onClick="toggle(this, 'Utility_subMenu', 'Utility_twistie');" OnMouseOver="this.className='cursor';">
  			<td class="menusection menusection-collapsed"
					id="elmt_Utility_subMenu"/>
					<img id='Utility_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;Utility
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-suspendemail.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-suspendemail.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-suspendemail.dsp');"
          				onclick="menuSelect(this, 'utility-suspendemail.dsp'); document.all['autility-suspendemail.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Suspend E-Mail Notification";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-suspendemail.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-suspendemail.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-suspendemail.dsp" target="body" href="utility-suspendemail.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-checkconnection.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-checkconnection.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-checkconnection.dsp');"
          				onclick="menuSelect(this, 'utility-checkconnection.dsp'); document.all['autility-checkconnection.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Check Target Connection";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-checkconnection.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-checkconnection.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-checkconnection.dsp" target="body" href="utility-checkconnection.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-fileupload.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-fileupload.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-fileupload.dsp');"
          				onclick="menuSelect(this, 'utility-fileupload.dsp'); document.all['autility-fileupload.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Upload File";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-fileupload.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-fileupload.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-fileupload.dsp" target="body" href="utility-fileupload.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-filedownload.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-filedownload.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-filedownload.dsp');"
          				onclick="menuSelect(this, 'utility-filedownload.dsp'); document.all['autility-filedownload.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Download File";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-filedownload.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-filedownload.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-filedownload.dsp" target="body" href="utility-filedownload.dsp?todo=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-deployfile.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-deployfile.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-deployfile.dsp');"
          				onclick="menuSelect(this, 'utility-deployfile.dsp'); document.all['autility-deployfile.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Deploy File";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-deployfile.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-deployfile.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-deployfile.dsp" target="body" href="utility-deployfile.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-serverlog.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-serverlog.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-serverlog.dsp');"
          				onclick="menuSelect(this, 'utility-serverlog.dsp'); document.all['autility-serverlog.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Server Log";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-serverlog.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-serverlog.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-serverlog.dsp" target="body" href="utility-serverlog.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-serverresource.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-serverresource.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-serverresource.dsp');"
          				onclick="menuSelect(this, 'utility-serverresource.dsp'); document.all['autility-serverresource.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Server Resources";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-serverresource.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-serverresource.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-serverresource.dsp" target="body" href="utility-serverresource.dsp?target=local&remoteInvoke=false&refreshType=manual&refreshInterval=10"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-serverresourcewarning.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-serverresourcewarning.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-serverresourcewarning.dsp');"
          				onclick="menuSelect(this, 'utility-serverresourcewarning.dsp'); document.all['autility-serverresourcewarning.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Server Resources Warning";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-serverresourcewarning.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-serverresourcewarning.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-serverresourcewarning.dsp" target="body" href="utility-serverresourcewarning.dsp?refreshType=auto&refreshInterval=30"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-statslog.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-statslog.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-statslog.dsp');"
          				onclick="menuSelect(this, 'utility-statslog.dsp'); document.all['autility-statslog.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Stats Log Analysis";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-statslog.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-statslog.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-statslog.dsp" target="body" href="utility-statslog.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-reserveprojectdeployment.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-reserveprojectdeployment.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-reserveprojectdeployment.dsp');"
          				onclick="menuSelect(this, 'utility-reserveprojectdeployment.dsp'); document.all['autility-reserveprojectdeployment.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Reserve Project Deployment";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-reserveprojectdeployment.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-reserveprojectdeployment.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-reserveprojectdeployment.dsp" target="body" href="utility-reserveprojectdeployment.dsp?todo=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-projectdeploymentschedule.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-projectdeploymentschedule.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-projectdeploymentschedule.dsp');"
          				onclick="menuSelect(this, 'utility-projectdeploymentschedule.dsp'); document.all['autility-projectdeploymentschedule.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Deployment Reservation";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-projectdeploymentschedule.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-projectdeploymentschedule.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-projectdeploymentschedule.dsp" target="body" href="utility-projectdeploymentschedule.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			%ifvar serverDuplexing matches('true')%
			<!-- Clustering을 구성하는 서버가 두 대 이상일 경우 안전하게 Restart 하기 -->
			<!-- AIA생명 전용 -->
			%ifvar customerCode matches('AIA')%
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-serverrestart.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-serverrestart.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-serverrestart.dsp');"
          				onclick="menuSelect(this, 'utility-serverrestart.dsp'); document.all['autility-serverrestart.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Server Restart";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-serverrestart.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-serverrestart.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-serverrestart.dsp" target="body" href="utility-serverrestart.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%endifvar%
			%endifvar%
			
			<!-- 현대제철 단위 테스트용 -->
			%ifvar customerCode equals('HSC')%
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-unittest-hsc.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-unittest-hsc.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-unittest-hsc.dsp');"
          				onclick="menuSelect(this, 'utility-unittest-hsc.dsp'); document.all['autility-unittest-hsc.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Unit Test";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-unittest-hsc.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-unittest-hsc.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-unittest-hsc.dsp" target="body" href="utility-unittest-hsc.dsp?todo=search&sourceSystem=L2&commonHeaderLength=60&online=Yes"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%endifvar%
			
			<!-- 메트라이프 단위 테스트용 -->
			%ifvar customerCode equals('MLK')%
			<tr name="Utility_subMenu" style="display: none">
				<td id="iutility-unittest-mlk.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'utility-unittest-mlk.dsp');"
          				onmouseout="menuMouseOut(this, 'utility-unittest-mlk.dsp');"
          				onclick="menuSelect(this, 'utility-unittest-mlk.dsp'); document.all['autility-unittest-mlk.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Unit Test";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "utility-unittest-mlk.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="autility-unittest-mlk.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="autility-unittest-mlk.dsp" target="body" href="utility-unittest-mlk.dsp?todo=&testCase=case1&testData=&testFile="> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			%endifvar%
			
			<!-- Deploy Config -->
			<!-- 개발/UAT 서버에서만 Display -->
			%ifvar serverType matches('PROD*')%
			
			%else%
			
			<tr manualhide="true" onClick="toggle(this, 'DeployConfig_subMenu', 'DeployConfig_twistie');" OnMouseOver="this.className='cursor';">
  			<td class="menusection menusection-collapsed"
					id="elmt_DeployConfig_subMenu"/>
					<img id='DeployConfig_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;Deploy Config
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-customvariablevalue.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-customvariablevalue.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-customvariablevalue.dsp');"
          				onclick="menuSelect(this, 'deploy-customvariablevalue.dsp'); document.all['adeploy-customvariablevalue.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Custom Variable Value";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-customvariablevalue.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-customvariablevalue.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-customvariablevalue.dsp" target="body" href="deploy-customvariablevalue.dsp?deployClass=customVariableValue&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-customvariable.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-customvariable.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-customvariable.dsp');"
          				onclick="menuSelect(this, 'deploy-customvariable.dsp'); document.all['adeploy-customvariable.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Custom Variable";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-customvariable.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-customvariable.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-customvariable.dsp" target="body" href="deploy-customvariable.dsp?deployClass=customVariable&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-systemname.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-systemname.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-systemname.dsp');"
          				onclick="menuSelect(this, 'deploy-systemname.dsp'); document.all['adeploy-systemname.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "System Name";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-systemname.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-systemname.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-systemname.dsp" target="body" href="deploy-systemname.dsp?deployClass=systemName&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-businessname.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-businessname.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-businessname.dsp');"
          				onclick="menuSelect(this, 'deploy-businessname.dsp'); document.all['adeploy-businessname.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Business Name";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-businessname.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-businessname.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-businessname.dsp" target="body" href="deploy-businessname.dsp?deployClass=businessName&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<!--
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-businessif.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-businessif.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-businessif.dsp');"
          				onclick="menuSelect(this, 'deploy-businessif.dsp'); document.all['adeploy-businessif.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Business Doc";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-businessif.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-businessif.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-businessif.dsp" target="body" href="deploy-businessif.dsp?deployClass=businessInterface&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			-->
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-restapiprotocol.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-restapiprotocol.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-restapiprotocol.dsp');"
          				onclick="menuSelect(this, 'deploy-restapiprotocol.dsp'); document.all['adeploy-restapiprotocol.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "REST API Protocol";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-restapiprotocol.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-restapiprotocol.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-restapiprotocol.dsp" target="body" href="deploy-restapiprotocol.dsp?deployClass=restApiProtocol&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-docinterfaceid.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-docinterfaceid.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-docinterfaceid.dsp');"
          				onclick="menuSelect(this, 'deploy-docinterfaceid.dsp'); document.all['adeploy-docinterfaceid.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Interface Doc";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-docinterfaceid.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-docinterfaceid.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-docinterfaceid.dsp" target="body" href="deploy-docinterfaceid.dsp?deployClass=docInterfaceID&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-httpdocinterfaceid.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-httpdocinterfaceid.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-httpdocinterfaceid.dsp');"
          				onclick="menuSelect(this, 'deploy-httpdocinterfaceid.dsp'); document.all['adeploy-httpdocinterfaceid.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "HTTP/S Target Doc";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-httpdocinterfaceid.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-httpdocinterfaceid.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-httpdocinterfaceid.dsp" target="body" href="deploy-httpdocinterfaceid.dsp?deployClass=httpDocInterfaceID&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-docschemadef.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-docschemadef.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-docschemadef.dsp');"
          				onclick="menuSelect(this, 'deploy-docschemadef.dsp'); document.all['adeploy-docschemadef.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Doc Schema Define";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-docschemadef.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-docschemadef.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-docschemadef.dsp" target="body" href="deploy-docschemadef.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-schemadeployreservation.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-schemadeployreservation.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-schemadeployreservation.dsp');"
          				onclick="menuSelect(this, 'deploy-schemadeployreservation.dsp'); document.all['adeploy-schemadeployreservation.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Doc Schema Reservation";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-schemadeployreservation.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-schemadeployreservation.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-schemadeployreservation.dsp" target="body" href="deploy-schemadeployreservation.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-localfile.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-localfile.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-localfile.dsp');"
          				onclick="menuSelect(this, 'deploy-localfile.dsp'); document.all['adeploy-localfile.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Delete Local File";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-localfile.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-localfile.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-localfile.dsp" target="body" href="deploy-localfile.dsp?deployClass=deleteLocalFile&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-localserver.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-localserver.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-localserver.dsp');"
          				onclick="menuSelect(this, 'deploy-localserver.dsp'); document.all['adeploy-localserver.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Server Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-localserver.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-localserver.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-localserver.dsp" target="body" href="deploy-localserver.dsp?deployClass=localServer&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-remoteserver.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-remoteserver.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-remoteserver.dsp');"
          				onclick="menuSelect(this, 'deploy-remoteserver.dsp'); document.all['adeploy-remoteserver.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Remote Server Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-remoteserver.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-remoteserver.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-remoteserver.dsp" target="body" href="deploy-remoteserver.dsp?deployClass=remoteServer&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>						
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-queuetopic.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-queuetopic.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-queuetopic.dsp');"
          				onclick="menuSelect(this, 'deploy-queuetopic.dsp'); document.all['adeploy-queuetopic.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Queue/Topic";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-queuetopic.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-queuetopic.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-queuetopic.dsp" target="body" href="deploy-queuetopic.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-stemail.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-stemail.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-stemail.dsp');"
          				onclick="menuSelect(this, 'deploy-stemail.dsp'); document.all['adeploy-stemail.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Source Target Email";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-stemail.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-stemail.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-stemail.dsp" target="body" href="deploy-stemail.dsp?deployClass=sourceTargetEmail&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			%ifvar onlineSystemNameList -notempty%
			
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-scheduler.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-scheduler.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-scheduler.dsp');"
          				onclick="menuSelect(this, 'deploy-scheduler.dsp'); document.all['adeploy-scheduler.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Check Schedule";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-scheduler.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-scheduler.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-scheduler.dsp" target="body" href="deploy-scheduler.dsp?deployClass=onlineCheckSchedule&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-trigger.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-trigger.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-trigger.dsp');"
          				onclick="menuSelect(this, 'deploy-trigger.dsp'); document.all['adeploy-trigger.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Trigger";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-trigger.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-trigger.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-trigger.dsp" target="body" href="deploy-trigger.dsp?deployClass=onlineTrigger&searchType=noDeploy&dupProcessType=notAdd"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>			
			
			%endifvar%
			
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-schedule.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-schedule.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-schedule.dsp');"
          				onclick="menuSelect(this, 'deploy-schedule.dsp'); document.all['adeploy-schedule.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Schedule";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-schedule.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-schedule.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-schedule.dsp" target="body" href="deploy-schedule.dsp?deploy=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-scheduledeployreservation.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-scheduledeployreservation.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-scheduledeployreservation.dsp');"
          				onclick="menuSelect(this, 'deploy-scheduledeployreservation.dsp'); document.all['adeploy-scheduledeployreservation.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Schedule Reservation";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-scheduledeployreservation.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-scheduledeployreservation.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-scheduledeployreservation.dsp" target="body" href="deploy-scheduledeployreservation.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td id="ideploy-allconfig.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'deploy-allconfig.dsp');"
          				onmouseout="menuMouseOut(this, 'deploy-allconfig.dsp');"
          				onclick="menuSelect(this, 'deploy-allconfig.dsp'); document.all['adeploy-allconfig.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "All Config";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "deploy-allconfig.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="adeploy-allconfig.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="adeploy-allconfig.dsp" target="body" href="deploy-allconfig.dsp"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			%endifvar%
			
			<!-- IS Memory Object -->
			<tr manualhide="true" onClick="toggle(this, 'SavedObjectMemory_subMenu', 'SavedObjectMemory_twistie');" OnMouseOver="this.className='cursor';">
  			<td class="menusection menusection-collapsed"
					id="elmt_SavedObjectMemory_subMenu"/>
					<img id='SavedObjectMemory_twistie' src="%value designPath%images/collapsed_blue.png">&nbsp;IS Memory Object
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-customvariable.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-customvariable.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-customvariable.dsp');"
          				onclick="menuSelect(this, 'savedobject-customvariable.dsp'); document.all['asavedobject-customvariable.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Custom Variable";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-customvariable.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-customvariable.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-customvariable.dsp" target="body" href="savedobject-memory.dsp?savedObject=customVariableList&objectName=Custom Variable"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-businessname.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-businessname.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-businessname.dsp');"
          				onclick="menuSelect(this, 'savedobject-businessname.dsp'); document.all['asavedobject-businessname.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Business Name";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-businessname.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-businessname.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-businessname.dsp" target="body" href="savedobject-memory.dsp?savedObject=businessNameList&objectName=Business Name"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<!--
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-businessif.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-businessif.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-businessif.dsp');"
          				onclick="menuSelect(this, 'savedobject-businessif.dsp'); document.all['asavedobject-businessif.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Business Doc";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-businessif.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-businessif.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-businessif.dsp" target="body" href="savedobject-memory.dsp?savedObject=businessInterfaceList&objectName=Business Doc"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			-->
			<!--
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-businessdocschemadef.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-businessdocschemadef.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-businessdocschemadef.dsp');"
          				onclick="menuSelect(this, 'savedobject-businessdocschemadef.dsp'); document.all['asavedobject-businessdocschemadef.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Client Doc Schema Define";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-businessdocschemadef.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-businessdocschemadef.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-businessdocschemadef.dsp" target="body" href="savedobject-memory.dsp?savedObject=businessDocSchemaDefList&objectName=Client Doc Schema Define"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			-->
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-restapiprotocol.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-restapiprotocol.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-restapiprotocol.dsp');"
          				onclick="menuSelect(this, 'savedobject-restapiprotocol.dsp'); document.all['asavedobject-restapiprotocol.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "REST API Protocol";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-restapiprotocol.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-restapiprotocol.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-restapiprotocol.dsp" target="body" href="savedobject-memory.dsp?savedObject=restApiProtocol&objectName=REST API Protocol"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-docinterfaceid.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-docinterfaceid.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-docinterfaceid.dsp');"
          				onclick="menuSelect(this, 'savedobject-docinterfaceid.dsp'); document.all['asavedobject-docinterfaceid.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Interface Doc";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-docinterfaceid.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-docinterfaceid.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-docinterfaceid.dsp" target="body" href="savedobject-memory.dsp?savedObject=docInterfaceIDList&objectName=Interface Doc"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-docschemadef.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-docschemadef.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-docschemadef.dsp');"
          				onclick="menuSelect(this, 'savedobject-docschemadef.dsp'); document.all['asavedobject-docschemadef.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Server Doc Schema Define";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-docschemadef.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-docschemadef.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-docschemadef.dsp" target="body" href="savedobject-memory.dsp?savedObject=docSchemaDefList&objectName=Server Doc Schema Define"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-socketrunningserver.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-socketrunningserver.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-socketrunningserver.dsp');"
          				onclick="menuSelect(this, 'savedobject-socketrunningserver.dsp'); document.all['asavedobject-socketrunningserver.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Running Local Server Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-socketrunningserver.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-socketrunningserver.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-socketrunningserver.dsp" target="body" href="savedobject-memory.dsp?savedObject=socketRunningServerList&objectName=Running Local Server Socket"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-socketserver.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-socketserver.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-socketserver.dsp');"
          				onclick="menuSelect(this, 'savedobject-socketserver.dsp'); document.all['asavedobject-socketserver.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Server Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-socketserver.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-socketserver.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-socketserver.dsp" target="body" href="savedobject-memory.dsp?savedObject=socketServerList&objectName=Local Server Socket"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-socketclient.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-socketclient.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-socketclient.dsp');"
          				onclick="menuSelect(this, 'savedobject-socketclient.dsp'); document.all['asavedobject-socketclient.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Remote Server Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-socketclient.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-socketclient.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-socketclient.dsp" target="body" href="savedobject-memory.dsp?savedObject=socketClientList&objectName=Remote Server Socket"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>									
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-serialqueue.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-serialqueue.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-serialqueue.dsp');"
          				onclick="menuSelect(this, 'savedobject-serialqueue.dsp'); document.all['asavedobject-serialqueue.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Local Serial Queuing Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-serialqueue.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-serialqueue.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-serialqueue.dsp" target="body" href="savedobject-memory.dsp?savedObject=serialSocketQueueList&objectName=Local Serial Queuing Socket"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-socketlogqueue.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-socketlogqueue.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-socketlogqueue.dsp');"
          				onclick="menuSelect(this, 'savedobject-socketlogqueue.dsp'); document.all['asavedobject-socketlogqueue.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Socket Log Queue";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-socketlogqueue.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-socketlogqueue.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-socketlogqueue.dsp" target="body" href="savedobject-memory.dsp?savedObject=socketLogQueueList&objectName=Socket Log Queue"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-socketobject.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-socketobject.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-socketobject.dsp');"
          				onclick="menuSelect(this, 'savedobject-socketobject.dsp'); document.all['asavedobject-socketobject.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Request Socket Object";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-socketobject.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-socketobject.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-socketobject.dsp" target="body" href="savedobject-memory.dsp?savedObject=realtimeRequestHeaderList&objectName=Request Socket Object"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-threadid.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-threadid.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-threadid.dsp');"
          				onclick="menuSelect(this, 'savedobject-threadid.dsp'); document.all['asavedobject-threadid.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Service Thread ID";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-threadid.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-threadid.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-threadid.dsp" target="body" href="savedobject-memory.dsp?savedObject=threadIDInfoList&objectName=Service Thread ID"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			
			<!-- Asynch Online Socket Client가 존재하는 경우에만 Display -->
			%ifvar onlineSystemNameList -notempty%
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-onlinesocketclient.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-onlinesocketclient.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-onlinesocketclient.dsp');"
          				onclick="menuSelect(this, 'savedobject-onlinesocketclient.dsp'); document.all['asavedobject-onlinesocketclient.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Client Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlinesocketclient.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-onlinesocketclient.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-onlinesocketclient.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineSocketClientList&objectName=Online Client Socket"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-onlineconnectcount.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-onlineconnectcount.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-onlineconnectcount.dsp');"
          				onclick="menuSelect(this, 'savedobject-onlineconnectcount.dsp'); document.all['asavedobject-onlineconnectcount.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Connect Count";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlineconnectcount.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-onlineconnectcount.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-onlineconnectcount.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineConnectCountList&objectName=Online Connect Count"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-onlinerequestheader.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-onlinerequestheader.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-onlinerequestheader.dsp');"
          				onclick="menuSelect(this, 'savedobject-onlinerequestheader.dsp'); document.all['asavedobject-onlinerequestheader.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Request Header";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlinerequestheader.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-onlinerequestheader.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-onlinerequestheader.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineRequestHeaderList&objectName=Online Request Header"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-onlinesendstatus.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-onlinesendstatus.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-onlinesendstatus.dsp');"
          				onclick="menuSelect(this, 'savedobject-onlinesendstatus.dsp'); document.all['asavedobject-onlinesendstatus.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Send Status";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlinesendstatus.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-onlinesendstatus.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-onlinesendstatus.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineSendStatusList&objectName=Online Send Status"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-onlineresponsedata.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-onlineresponsedata.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-onlineresponsedata.dsp');"
          				onclick="menuSelect(this, 'savedobject-onlineresponsedata.dsp'); document.all['asavedobject-onlineresponsedata.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Response Data";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlineresponsedata.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-onlineresponsedata.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-onlineresponsedata.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineResponseDataList&objectName=Online Response Data&todo=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-onlinerunningserver.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-onlinerunningserver.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-onlinerunningserver.dsp');"
          				onclick="menuSelect(this, 'savedobject-onlinerunningserver.dsp'); document.all['asavedobject-onlinerunningserver.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Running Server";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlinerunningserver.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-onlinerunningserver.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-onlinerunningserver.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineRunningServerList&objectName=Online Running Server"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-onlinereconnectingserver.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-onlinereconnectingserver.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-onlinereconnectingserver.dsp');"
          				onclick="menuSelect(this, 'savedobject-onlinereconnectingserver.dsp'); document.all['asavedobject-onlinereconnectingserver.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Reconnecting Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlinereconnectingserver.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-onlinereconnectingserver.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-onlinereconnectingserver.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineReconnectingServerList&objectName=Online Reconnecting Socket"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-onlinereceivesequence.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-onlinereceivesequence.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-onlinereceivesequence.dsp');"
          				onclick="menuSelect(this, 'savedobject-onlinereceivesequence.dsp'); document.all['asavedobject-onlinereceivesequence.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Receive Sequence";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlinereceivesequence.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-onlinereceivesequence.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-onlinereceivesequence.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineReceiveSequenceList&objectName=Online Receive Sequence"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			<!-- Online Socket Queue 메뉴와 Online Queuing Socket 메뉴를 하나로 통합
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-onlinesocketqueue.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-onlinesocketqueue.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-onlinesocketqueue.dsp');"
          				onclick="menuSelect(this, 'savedobject-onlinesocketqueue.dsp'); document.all['asavedobject-onlinesocketqueue.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Socket Queue";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlinesocketqueue.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-onlinesocketqueue.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-onlinesocketqueue.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineSocketQueueList&objectName=Online Socket Queue"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
			-->
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="isavedobject-onlinequeuing.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'savedobject-onlinequeuing.dsp');"
          				onmouseout="menuMouseOut(this, 'savedobject-onlinequeuing.dsp');"
          				onclick="menuSelect(this, 'savedobject-onlinequeuing.dsp'); document.all['asavedobject-onlinequeuing.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Online Queuing Socket";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlinequeuing.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="asavedobject-onlinequeuing.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="asavedobject-onlinequeuing.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineQueuingList&objectName=Online Queuing Socket"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>			
			%else%
				<!-- Asynch Online Socket Server가 존재하는 경우 -->
				%ifvar onlinePortNumberList -notempty%
					<tr name="SavedObjectMemory_subMenu" style="display: none">
						<td id="isavedobject-onlinesocketqueue.dsp" class="menuitem xyz"
							onmouseover="menuMouseOver(this, 'savedobject-onlinesocketqueue.dsp');"
        		  				onmouseout="menuMouseOut(this, 'savedobject-onlinesocketqueue.dsp');"
        		  				onclick="menuSelect(this, 'savedobject-onlinesocketqueue.dsp'); document.all['asavedobject-onlinesocketqueue.dsp'].click();"
        		
						>
							<span style="white-space: nowrap">
        		    <script>
        		      var label = "";
        		      if (!label) {
        		        label = "Online Socket Queue";
        		      }
        		      label = label.replace(/NBSP/g, ' ');
        		      if (is_csrf_guard_enabled && needToInsertToken) {
        		        createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "savedobject-onlinesocketqueue.dsp", "POST", "BODY", "body");
        		        setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
        		        document.write('<a id="asavedobject-onlinesocketqueue.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
        		      } else {
        		        document.write('<a id="asavedobject-onlinesocketqueue.dsp" target="body" href="savedobject-memory.dsp?savedObject=onlineSocketQueueList&objectName=Online Socket Queue"> ' + label + '  </a>');
        		      }
        		    </script>
        		  </span>
						</td>
					</tr>					
				%endifvar%
			%endifvar%
			
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td id="iasynchon-onlinedatadelete.dsp" class="menuitem xyz"
					onmouseover="menuMouseOver(this, 'asynchon-onlinedatadelete.dsp');"
          				onmouseout="menuMouseOut(this, 'asynchon-onlinedatadelete.dsp');"
          				onclick="menuSelect(this, 'asynchon-onlinedatadelete.dsp'); document.all['aasynchon-onlinedatadelete.dsp'].click();"

				>
					<span style="white-space: nowrap">
            <script>
              var label = "";
              if (!label) {
                label = "Temp Data Delete Schedule";
              }
              label = label.replace(/NBSP/g, ' ');
              if (is_csrf_guard_enabled && needToInsertToken) {
                createFormWithTargetAndSetProperties("htmlform_menu_subelement_Error", "asynchon-onlinedatadelete.dsp", "POST", "BODY", "body");
                setFormProperty("htmlform_menu_subelement_Error", _csrfTokenNm_, _csrfTokenVal_);
                document.write('<a id="aasynchon-onlinedatadelete.dsp" href="javascript:htmlform_menu_subelement_Error.submit()"> ' + label + '  </a>');
              } else {
                document.write('<a id="aasynchon-onlinedatadelete.dsp" target="body" href="asynchon-onlinedatadelete.dsp?enable=search"> ' + label + '  </a>');
              }
            </script>
          </span>
				</td>
			</tr>
		</table>
	</body>
</html>

%endinvoke%