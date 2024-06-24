<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<title>webMethods Socket Adapter Administration Menu</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<base target="_self">
		<style>.listbox { width: 100%; } body { border-top: 1px solid #97A6CB; }</style>

		<script type="text/javascript">
			var previousMenuImage;

			function menuMouseOver(object, id) {
				object.style.background='#FFFFFF';
				window.status= id;
			}

			function menuMouseOut(object) {
				object.style.background='#F0ECDA';
				window.status='';

			}

			function moveArrow(item) {
  				if(previousMenuImage != null) 
					previousMenuImage.src="/WmRoot/images/blank.gif";

  				var temp = previousMenuImage;
  				previousMenuImage=document.images[item];

  				if(previousMenuImage == null) 
					previousMenuImage = temp;

  				previousMenuImage.src="/WmRoot/images/selectedarrow.gif";
			}
			
			function toggle(parent, id, imgId) {
				var set = 'none';
				var image = document.getElementById(imgId);
				if(parent.getAttribute('manualhide') == 'true') {
					set = 'table-row';
					parent.setAttribute('manualhide', 'false');
					image.src = '/WmRoot/images/expanded.gif';
				} else {
					parent.setAttribute('manualhide', 'true');
					image.src = '/WmRoot/images/collapsed.gif';
				}
				var elements = getElements("TR", id);

				for ( var i = 0; i < elements.length; i++) {
					var element = elements[i];
					//alert(element.getAttribute("name"));
					element.style.cssText = "display:"+set;
				}
			}
			
			function getElements(tag, name) {
				var elem = document.getElementsByTagName(tag);
				var arr = new Array();
				
				for(i=0, idx=0; i<elem.length; i++) {
					att = elem[i].getAttribute("name");
					if(att == name) {
						arr[idx++] = elem[i];
					}
				}
				
				return arr;
			}
		</script>
	</head>
	<body class="menu">
	
		%invoke JSocketAdapter.ADMIN:getMenuInfo%
		
		<table width="100%" cellspacing=0 cellpadding=1 border=0>
			<!-- Basic Info -->
			<tr manualhide="true" onClick="toggle(this, 'BasicInfo_subMenu', 'BasicInfo_twistie');" OnMouseOver="this.className='cursor';">
  			<td CLASS="menusection-Settings">
					<img id='BasicInfo_twistie' src="/WmRoot/images/collapsed.gif">&nbsp;Basic Info
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'basic-variablevalue.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-variablevalue.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-variablevalue.dsp" name="basic-variablevalue.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="abasic-variablevalue.dsp" target='body' href="basic-variablevalue.dsp" onclick="moveArrow('basic-variablevalue.dsp', 'body'); return true;"><span class="menuitemspan">Custom Variable Value</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'basic-variable.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-variable.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-variable.dsp" name="basic-variable.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="abasic-variable.dsp" target='body' href="basic-variable.dsp" onclick="moveArrow('basic-variable.dsp', 'body'); return true;"><span class="menuitemspan">Custom Variable</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'basic-system.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-system.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-system.dsp" name="basic-system.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="abasic-system.dsp" target='body' href="basic-system.dsp" onclick="moveArrow('basic-system.dsp', 'body'); return true;"><span class="menuitemspan">System Name</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'basic-business.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-business.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-business.dsp" name="basic-business.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="abasic-business.dsp" target='body' href="basic-business.dsp" onclick="moveArrow('basic-business.dsp', 'body'); return true;"><span class="menuitemspan">Business Name</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'basic-localfile.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-localfile.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-localfile.dsp" name="basic-localfile.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="abasic-localfile.dsp" target='body' href="basic-localfile.dsp" onclick="moveArrow('basic-localfile.dsp', 'body'); return true;"><span class="menuitemspan">Delete Local File</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'basic-localfileschedule.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-localfileschedule.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-localfileschedule.dsp" name="basic-localfileschedule.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="abasic-localfileschedule.dsp" target='body' href="basic-localfileschedule.dsp?enable=search" onclick="moveArrow('basic-localfileschedule.dsp', 'body'); return true;"><span class="menuitemspan">Local File Delete Schedule</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr>
				<td class="menuseparator"><img src="/WmRoot/images/blank.gif" width="3" height="3" border="0"></td>
			</tr>
			
			<!-- Deploy Config -->
			<!-- 개발/UAT 서버에서만 Display -->
			%ifvar serverType matches('PROD*')%
			
			%else%
			
			<tr manualhide="true" onClick="toggle(this, 'DeployConfig_subMenu', 'DeployConfig_twistie');" OnMouseOver="this.className='cursor';">
  			<td CLASS="menusection-Settings">
					<img id='DeployConfig_twistie' src="/WmRoot/images/collapsed.gif">&nbsp;Deploy Config
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'deploy-customvariable.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-customvariable.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-customvariable.dsp" name="deploy-customvariable.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="adeploy-customvariable.dsp" target='body' href="deploy-customvariable.dsp?deployClass=customVariable" onclick="moveArrow('deploy-customvariable.dsp', 'body'); return true;"><span class="menuitemspan">Custom Variable</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'deploy-systemname.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-systemname.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-systemname.dsp" name="deploy-systemname.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="adeploy-systemname.dsp" target='body' href="deploy-systemname.dsp?deployClass=systemName" onclick="moveArrow('deploy-systemname.dsp', 'body'); return true;"><span class="menuitemspan">System Name</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'deploy-businessname.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-businessname.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-businessname.dsp" name="deploy-businessname.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="adeploy-businessname.dsp" target='body' href="deploy-businessname.dsp?deployClass=businessName" onclick="moveArrow('deploy-businessname.dsp', 'body'); return true;"><span class="menuitemspan">Business Name</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'deploy-businessif.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-businessif.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-businessif.dsp" name="deploy-businessif.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="adeploy-businessif.dsp" target='body' href="deploy-businessif.dsp?deployClass=businessInterface" onclick="moveArrow('deploy-businessif.dsp', 'body'); return true;"><span class="menuitemspan">Business Interface</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'deploy-localfile.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-localfile.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-localfile.dsp" name="deploy-localfile.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="adeploy-localfile.dsp" target='body' href="deploy-localfile.dsp?deployClass=deleteLocalFile" onclick="moveArrow('deploy-localfile.dsp', 'body'); return true;"><span class="menuitemspan">Delete Local File</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'deploy-localserver.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-localserver.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-localserver.dsp" name="deploy-localserver.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="adeploy-localserver.dsp" target='body' href="deploy-localserver.dsp?deployClass=localServer" onclick="moveArrow('deploy-localserver.dsp', 'body'); return true;"><span class="menuitemspan">Local Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'deploy-remoteserver.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-remoteserver.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-remoteserver.dsp" name="deploy-remoteserver.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="adeploy-remoteserver.dsp" target='body' href="deploy-remoteserver.dsp?deployClass=remoteServer" onclick="moveArrow('deploy-remoteserver.dsp', 'body'); return true;"><span class="menuitemspan">Remote Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			%ifvar onlineSystemNameList -notempty%
			
			<tr name="DeployConfig_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'deploy-scheduler.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-scheduler.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-scheduler.dsp" name="deploy-scheduler.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="adeploy-scheduler.dsp" target='body' href="deploy-scheduler.dsp?deployClass=onlineCheckSchedule" onclick="moveArrow('deploy-scheduler.dsp', 'body'); return true;"><span class="menuitemspan">Online Check Schedule</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'deploy-trigger.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-trigger.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-trigger.dsp" name="deploy-trigger.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="adeploy-trigger.dsp" target='body' href="deploy-trigger.dsp?deployClass=onlineTrigger" onclick="moveArrow('deploy-trigger.dsp', 'body'); return true;"><span class="menuitemspan">Online Trigger</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			%endifvar%
			
			<tr>
				<td class="menuseparator"><img src="/WmRoot/images/blank.gif" width="3" height="3" border="0"></td>
			</tr>
			
			%endifvar%
			
			<!-- AS/400 -->
			<!-- AS/400 시스템이 존재하고 Data Q를 이용해서 ESB와 연계하는 경우에만 Display -->
			%ifvar as400DataQUse equals('true')%
			<tr manualhide="true" onClick="toggle(this, 'AS400_subMenu', 'AS400_twistie');" OnMouseOver="this.className='cursor';">
  			<td CLASS="menusection-Settings">
					<img id='AS400_twistie' src="/WmRoot/images/collapsed.gif">&nbsp;AS/400
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'as400-dataqlistener.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-dataqlistener.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-dataqlistener.dsp" name="as400-dataqlistener.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="aas400-dataqlistener.dsp" target='body' href="as400-dataqlistener.dsp" onclick="moveArrow('as400-dataqlistener.dsp', 'body'); return true;"><span class="menuitemspan">Data Q Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'as400-togglelistener.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-togglelistener.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-togglelistener.dsp" name="as400-togglelistener.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="aas400-togglelistener.dsp" target='body' href="as400-togglelistener.dsp?systemName=ALL&enable=search" onclick="moveArrow('as400-togglelistener.dsp', 'body'); return true;"><span class="menuitemspan">Toggle Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'as400-healthchecklistener.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-healthchecklistener.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-healthchecklistener.dsp" name="as400-healthchecklistener.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="aas400-healthchecklistener.dsp" target='body' href="as400-healthchecklistener.dsp?enable=search" onclick="moveArrow('as400-healthchecklistener.dsp', 'body'); return true;"><span class="menuitemspan">Health Check Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			%ifvar serverType matches('PROD*')%
			
			<tr name="AS400_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'as400-switchlistener.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-switchlistener.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-switchlistener.dsp" name="as400-switchlistener.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="aas400-switchlistener.dsp" target='body' href="as400-switchlistener.dsp?systemName=ALL&switching=search" onclick="moveArrow('as400-switchlistener.dsp', 'body'); return true;"><span class="menuitemspan">Switch Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			%else%
			
			<tr name="AS400_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'as400-deploylistener.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-deploylistener.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-deploylistener.dsp" name="as400-deploylistener.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="aas400-deploylistener.dsp" target='body' href="as400-deploylistener.dsp?systemName=ALL&deploy=search" onclick="moveArrow('as400-deploylistener.dsp', 'body'); return true;"><span class="menuitemspan">Deploy Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			%endifvar%
						
			<tr>
				<td class="menuseparator"><img src="/WmRoot/images/blank.gif" width="3" height="3" border="0"></td>
			</tr>			
			%endifvar%
			
			<!-- Server Socket -->
			<tr manualhide="true" onClick="toggle(this, 'ServerSocket_subMenu', 'ServerSocket_twistie');" OnMouseOver="this.className='cursor';">
  			<td CLASS="menusection-Settings">
					<img id='ServerSocket_twistie' src="/WmRoot/images/collapsed.gif">&nbsp;Server Socket
				</td>
			</tr>
			<tr name="ServerSocket_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'socket-localserver.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socket-localserver.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socket-localserver.dsp" name="socket-localserver.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asocket-localserver.dsp" target='body' href="socket-localserver.dsp" onclick="moveArrow('socket-localserver.dsp', 'body'); return true;"><span class="menuitemspan">Local Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="ServerSocket_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'socket-remoteserver.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socket-remoteserver.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socket-remoteserver.dsp" name="socket-remoteserver.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asocket-remoteserver.dsp" target='body' href="socket-remoteserver.dsp" onclick="moveArrow('socket-remoteserver.dsp', 'body'); return true;"><span class="menuitemspan">Remote Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr>
				<td class="menuseparator"><img src="/WmRoot/images/blank.gif" width="3" height="3" border="0"></td>
			</tr>
			
			<!-- Asynch Online Socket이 존재하는 경우에만 Display -->
			<!-- Asynch Online Socket -->
			%loop onlineSystemNameList%
			<tr manualhide="true" onClick="toggle(this, '%value onlineSystemNameList%_subMenu', '%value onlineSystemNameList%_twistie');" OnMouseOver="this.className='cursor';">
  			<td CLASS="menusection-Settings">
					<img id='%value onlineSystemNameList%_twistie' src="/WmRoot/images/collapsed.gif">&nbsp;%value onlineSystemNameList% Online
				</td>
			</tr>
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-connection.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['%value onlineSystemNameList%-connection.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="%value onlineSystemNameList%-connection.dsp" name="%value onlineSystemNameList%-connection.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="a%value onlineSystemNameList%-connection.dsp" target='body' href="asynchon-connection.dsp?systemName=%value onlineSystemNameList%&todo=onlinelist" onclick="moveArrow('%value onlineSystemNameList%-connection.dsp', 'body'); return true;"><span class="menuitemspan">Online Connection</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-scheduler.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['%value onlineSystemNameList%-scheduler.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="%value onlineSystemNameList%-scheduler.dsp" name="%value onlineSystemNameList%-scheduler.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="a%value onlineSystemNameList%-scheduler.dsp" target='body' href="asynchon-scheduler.dsp?systemName=%value onlineSystemNameList%" onclick="moveArrow('%value onlineSystemNameList%-scheduler.dsp', 'body'); return true;"><span class="menuitemspan">Online Check Schedule</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-trigger.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['%value onlineSystemNameList%-trigger.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="%value onlineSystemNameList%-trigger.dsp" name="%value onlineSystemNameList%-trigger.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="a%value onlineSystemNameList%-trigger.dsp" target='body' href="asynchon-trigger.dsp?systemName=%value onlineSystemNameList%" onclick="moveArrow('%value onlineSystemNameList%-trigger.dsp', 'body'); return true;"><span class="menuitemspan">Trigger</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			<!-- AS/400 시스템이 존재하고 Data Q를 이용해서 Asynch Online 방식의 Socket 구현을 위해서 ESB와 연계하는 경우에만 Display -->
			%ifvar as400AsynchOnline equals('true')%
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-dqlistener.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['%value onlineSystemNameList%-dqlistener.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="%value onlineSystemNameList%-dqlistener.dsp" name="%value onlineSystemNameList%-dqlistener.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="a%value onlineSystemNameList%-dqlistener.dsp" target='body' href="asynchon-dqlistener.dsp?systemName=%value onlineSystemNameList%" onclick="moveArrow('%value onlineSystemNameList%-dqlistener.dsp', 'body'); return true;"><span class="menuitemspan">Data Q Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			%endifvar%
			
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-switchsocket.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['%value onlineSystemNameList%-switchsocket.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="%value onlineSystemNameList%-switchsocket.dsp" name="%value onlineSystemNameList%-switchsocket.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="a%value onlineSystemNameList%-switchsocket.dsp" target='body' href="asynchon-switchsocket.dsp?switching=&systemName=%value onlineSystemNameList%" onclick="moveArrow('%value onlineSystemNameList%-switchsocket.dsp', 'body'); return true;"><span class="menuitemspan">Switch Socket Operation</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-switchingschedule.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['%value onlineSystemNameList%-switchingschedule.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="%value onlineSystemNameList%-switchingschedule.dsp" name="%value onlineSystemNameList%-switchingschedule.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="a%value onlineSystemNameList%-switchingschedule.dsp" target='body' href="asynchon-switchingschedule.dsp?systemName=%value onlineSystemNameList%" onclick="moveArrow('%value onlineSystemNameList%-switchingschedule.dsp', 'body'); return true;"><span class="menuitemspan">Switching Schedule</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="%value onlineSystemNameList%_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, '%value onlineSystemNameList%-errorhistory.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['%value onlineSystemNameList%-errorhistory.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="%value onlineSystemNameList%-errorhistory.dsp" name="%value onlineSystemNameList%-errorhistory.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="a%value onlineSystemNameList%-errorhistory.dsp" target='body' href="asynchon-errorhistory.dsp?todo=search&systemName=%value onlineSystemNameList%" onclick="moveArrow('%value onlineSystemNameList%-errorhistory.dsp', 'body'); return true;"><span class="menuitemspan">Online Error History</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr>
				<td class="menuseparator"><img src="/WmRoot/images/blank.gif" width="3" height="3" border="0"></td>
			</tr>
			%endloop%
			
			<!-- Socket Log -->
			<tr manualhide="true" onClick="toggle(this, 'SocketLog_subMenu', 'SocketLog_twistie');" OnMouseOver="this.className='cursor';">
  			<td CLASS="menusection-Settings">
					<img id='SocketLog_twistie' src="/WmRoot/images/collapsed.gif">&nbsp;Socket Log
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'socketlog-localserver.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-localserver.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-localserver.dsp" name="socketlog-localserver.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asocketlog-localserver.dsp" target='body' href="socketlog-localserver.dsp" onclick="moveArrow('socketlog-localserver.dsp', 'body'); return true;"><span class="menuitemspan">Local Server Socket Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'socketlog-remoteserver.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-remoteserver.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-remoteserver.dsp" name="socketlog-remoteserver.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asocketlog-remoteserver.dsp" target='body' href="socketlog-remoteserver.dsp" onclick="moveArrow('socketlog-remoteserver.dsp', 'body'); return true;"><span class="menuitemspan">Remote Server Socket Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			<!-- Asynch Online Socket 이 있는 경우 -->
			<tr name="SocketLog_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'socketlog-onlinetrace.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-onlinetrace.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-onlinetrace.dsp" name="socketlog-onlinetrace.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asocketlog-onlinetrace.dsp" target='body' href="socketlog-onlinetrace.dsp" onclick="moveArrow('socketlog-onlinetrace.dsp', 'body'); return true;"><span class="menuitemspan">Asynch Online Trace Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'socketlog-onlinetemphistory.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-onlinetemphistory.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-onlinetemphistory.dsp" name="socketlog-onlinetemphistory.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asocketlog-onlinetemphistory.dsp" target='body' href="socketlog-onlinetemphistory.dsp" onclick="moveArrow('socketlog-onlinetemphistory.dsp', 'body'); return true;"><span class="menuitemspan">Asynch Online Temp History Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<!-- Asynch Online Socket 이 있는 경우 -->
			
			<tr>
				<td class="menuseparator"><img src="/WmRoot/images/blank.gif" width="3" height="3" border="0"></td>
			</tr>						
			
			<!-- IS Memory Object -->
			<tr manualhide="true" onClick="toggle(this, 'SavedObjectMemory_subMenu', 'SavedObjectMemory_twistie');" OnMouseOver="this.className='cursor';">
  			<td CLASS="menusection-Settings">
					<img id='SavedObjectMemory_twistie' src="/WmRoot/images/collapsed.gif">&nbsp;IS Memory Object
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory1.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory1.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory1.dsp" name="savedobject-memory1.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory1.dsp" target='body' href="savedobject-memory.dsp?savedObject=customVariableList&objectName=Custom Variable" onclick="moveArrow('savedobject-memory1.dsp', 'body'); return true;"><span class="menuitemspan">Custom Variable</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory2.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory2.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory2.dsp" name="savedobject-memory2.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory2.dsp" target='body' href="savedobject-memory.dsp?savedObject=businessNameList&objectName=Business Name" onclick="moveArrow('savedobject-memory2.dsp', 'body'); return true;"><span class="menuitemspan">Business Name</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory3.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory3.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory3.dsp" name="savedobject-memory3.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory3.dsp" target='body' href="savedobject-memory.dsp?savedObject=socketRunningServerList&objectName=Running Local Server Socket" onclick="moveArrow('savedobject-memory3.dsp', 'body'); return true;"><span class="menuitemspan">Running Local Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory4.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory4.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory4.dsp" name="savedobject-memory4.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory4.dsp" target='body' href="savedobject-memory.dsp?savedObject=socketServerList&objectName=Local Server Socket" onclick="moveArrow('savedobject-memory4.dsp', 'body'); return true;"><span class="menuitemspan">Local Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>			
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory5.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory5.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory5.dsp" name="savedobject-memory5.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory5.dsp" target='body' href="savedobject-memory.dsp?savedObject=socketClientList&objectName=Remote Server Socket" onclick="moveArrow('savedobject-memory5.dsp', 'body'); return true;"><span class="menuitemspan">Remote Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			<!-- Asynch Online Socket 이 존재하는 경우에만 Display -->
			%ifvar onlineSystemNameList -notempty%
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory6.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory6.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory6.dsp" name="savedobject-memory6.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory6.dsp" target='body' href="savedobject-memory.dsp?savedObject=onlineSocketClientList&objectName=Online Client Socket" onclick="moveArrow('savedobject-memory6.dsp', 'body'); return true;"><span class="menuitemspan">Online Client Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory7.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory7.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory7.dsp" name="savedobject-memory7.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory7.dsp" target='body' href="savedobject-memory.dsp?savedObject=onlineRequestHeaderList&objectName=Online Request Header" onclick="moveArrow('savedobject-memory7.dsp', 'body'); return true;"><span class="menuitemspan">Online Request Header</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory8.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory8.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory8.dsp" name="savedobject-memory8.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory8.dsp" target='body' href="savedobject-memory.dsp?savedObject=onlineSendStatusList&objectName=Online Send Status" onclick="moveArrow('savedobject-memory8.dsp', 'body'); return true;"><span class="menuitemspan">Online Send Status</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory9.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory9.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory9.dsp" name="savedobject-memory9.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory9.dsp" target='body' href="savedobject-memory.dsp?savedObject=onlineResponseDataList&objectName=Online Response Data&todo=search" onclick="moveArrow('savedobject-memory9.dsp', 'body'); return true;"><span class="menuitemspan">Online Response Data</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory10.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory10.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory10.dsp" name="savedobject-memory10.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory10.dsp" target='body' href="savedobject-memory.dsp?savedObject=onlineRunningServerList&objectName=Online Running Server" onclick="moveArrow('savedobject-memory10.dsp', 'body'); return true;"><span class="menuitemspan">Online Running Server</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory11.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory11.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory11.dsp" name="savedobject-memory11.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory11.dsp" target='body' href="savedobject-memory.dsp?savedObject=onlineReconnectingServerList&objectName=Online Reconnecting Socket" onclick="moveArrow('savedobject-memory11.dsp', 'body'); return true;"><span class="menuitemspan">Online Reconnecting Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory12.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory12.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory12.dsp" name="savedobject-memory12.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory12.dsp" target='body' href="savedobject-memory.dsp?savedObject=onlineReceiveSequenceList&objectName=Online Receive Sequence" onclick="moveArrow('savedobject-memory12.dsp', 'body'); return true;"><span class="menuitemspan">Online Receive Sequence</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'savedobject-memory13.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-memory13.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-memory13.dsp" name="savedobject-memory13.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="asavedobject-memory13.dsp" target='body' href="savedobject-memory.dsp?savedObject=onlineQueuingList&objectName=Online Queuing Socket" onclick="moveArrow('savedobject-memory13.dsp', 'body'); return true;"><span class="menuitemspan">Online Queuing Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr>
				<td class="menuseparator"><img src="/WmRoot/images/blank.gif" width="3" height="3" border="0"></td>
			</tr>
			%else%
			<tr>
				<td class="menuseparator"><img src="/WmRoot/images/blank.gif" width="3" height="3" border="0"></td>
			</tr>
			%endifvar%
			
			<!-- Utility -->
			<tr manualhide="true" onClick="toggle(this, 'Utility_subMenu', 'Utility_twistie');" OnMouseOver="this.className='cursor';">
  			<td CLASS="menusection-Settings">
					<img id='Utility_twistie' src="/WmRoot/images/collapsed.gif">&nbsp;Utility
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'utility-suspendemail.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-suspendemail.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-suspendemail.dsp" name="utility-suspendemail.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="autility-suspendemail.dsp" target='body' href="utility-suspendemail.dsp" onclick="moveArrow('utility-suspendemail.dsp', 'body'); return true;"><span class="menuitemspan">Suspend E-Mail Notification</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'utility-checkconnection.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-checkconnection.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-checkconnection.dsp" name="utility-checkconnection.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="autility-checkconnection.dsp" target='body' href="utility-checkconnection.dsp" onclick="moveArrow('utility-checkconnection.dsp', 'body'); return true;"><span class="menuitemspan">Check Target Connection</span>
						</a>
					</nobr>
				</td>
			</tr>			
			<tr name="Utility_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'utility-deployfile.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-deployfile.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-deployfile.dsp" name="utility-deployfile.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="autility-deployfile.dsp" target='body' href="utility-deployfile.dsp" onclick="moveArrow('utility-deployfile.dsp', 'body'); return true;"><span class="menuitemspan">Deploy File</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td class="menuitem"
					onmouseover="menuMouseOver(this, 'utility-serverlog.dsp');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-serverlog.dsp'].click();"

				>
					<nobr>
						<img valign="middle" src="/WmRoot/images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-serverlog.dsp" name="utility-serverlog.dsp" src="/WmRoot/images/blank.gif" height="8" width="8" border="0">
						<a id="autility-serverlog.dsp" target='body' href="utility-serverlog.dsp" onclick="moveArrow('utility-serverlog.dsp', 'body'); return true;"><span class="menuitemspan">Server Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr>
				<td class="menuseparator"><img src="/WmRoot/images/blank.gif" width="3" height="3" border="0"></td>
			</tr>
		</table>
		
		%endinvoke%
		
	</body>
</html>