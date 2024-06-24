%invoke JSocketAdapter.ADMIN:getMenuInfo%

<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<title>JSocketAdapter Administration Menu</title>
		<link rel="stylesheet" type="text/css" href="css/webMethods_97.css">
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
				//object.style.background='#F0ECDA';
				object.style.background='';
				window.status='';

			}

			function moveArrow(item) {
  				if(previousMenuImage != null) 
					previousMenuImage.src="images/blank.gif";

  				var temp = previousMenuImage;
  				previousMenuImage=document.images[item];

  				if(previousMenuImage == null) 
					previousMenuImage = temp;

  				previousMenuImage.src="images/doc.gif";
			}
			
			function toggle(parent, id, imgId) {
				var set = 'none';
				var image = document.getElementById(imgId);
				if(parent.getAttribute('manualhide') == 'true') {
					set = 'table-row';
					parent.setAttribute('manualhide', 'false');
					image.src = 'images/fo.gif';
				} else {
					parent.setAttribute('manualhide', 'true');
					image.src = 'images/fc.gif';
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
		<table width="100%" cellspacing=0 cellpadding=1 border=0>		  
			
			<!-- About -->
			<tr manualhide="true" onClick="toggle(this, 'About_subMenu', 'About_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='About_twistie' src="images/fc.gif">&nbsp;About JSocketAdapter Administrator
				</td>
			</tr>
			<tr name="About_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'about-about.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['about-about.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="about-about.html" name="about-about.html" src="images/blank.gif" border="0">
						<a id="aabout-about.html" target='body' href="about-about.html" onclick="moveArrow('about-about.html', 'body'); return true;"><span class="menuitemspan">About JSocketAdapter Administrator</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			<!-- Basic Info -->
			<tr manualhide="true" onClick="toggle(this, 'BasicInfo_subMenu', 'BasicInfo_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='BasicInfo_twistie' src="images/fc.gif">&nbsp;Basic Info
				</td>
			</tr>			
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-customvariablevalue.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-customvariablevalue.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-customvariablevalue.html" name="basic-customvariablevalue.html" src="images/blank.gif" border="0">
						<a id="abasic-customvariablevalue.html" target='body' href="basic-customvariablevalue.html" onclick="moveArrow('basic-customvariablevalue.html', 'body'); return true;"><span class="menuitemspan">Custom Variable Value</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-customvariable.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-customvariable.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-customvariable.html" name="basic-customvariable.html" src="images/blank.gif" border="0">
						<a id="abasic-customvariable.html" target='body' href="basic-customvariable.html" onclick="moveArrow('basic-customvariable.html', 'body'); return true;"><span class="menuitemspan">Custom Variable</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-systemname.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-systemname.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-systemname.html" name="basic-systemname.html" src="images/blank.gif" border="0">
						<a id="abasic-systemname.html" target='body' href="basic-systemname.html" onclick="moveArrow('basic-systemname.html', 'body'); return true;"><span class="menuitemspan">System Name</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-businessname.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-businessname.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-businessname.html" name="basic-businessname.html" src="images/blank.gif" border="0">
						<a id="abasic-businessname.html" target='body' href="basic-businessname.html" onclick="moveArrow('basic-businessname.html', 'body'); return true;"><span class="menuitemspan">Business Name</span>
						</a>
					</nobr>
				</td>
			</tr>
			<!--
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-businessif.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-businessif.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-businessif.html" name="basic-businessif.html" src="images/blank.gif" border="0">
						<a id="abasic-businessif.html" target='body' href="basic-businessif.html" onclick="moveArrow('basic-businessif.html', 'body'); return true;"><span class="menuitemspan">Business Doc</span>
						</a>
					</nobr>
				</td>
			</tr>
			-->
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-restapiprotocol.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-restapiprotocol.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-restapiprotocol.html" name="basic-restapiprotocol.html" src="images/blank.gif" border="0">
						<a id="abasic-restapiprotocol.html" target='body' href="basic-restapiprotocol.html" onclick="moveArrow('basic-restapiprotocol.html', 'body'); return true;"><span class="menuitemspan">REST API Protocol</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-docinterfaceid.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-docinterfaceid.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-docinterfaceid.html" name="basic-docinterfaceid.html" src="images/blank.gif" border="0">
						<a id="abasic-docinterfaceid.html" target='body' href="basic-docinterfaceid.html" onclick="moveArrow('basic-docinterfaceid.html', 'body'); return true;"><span class="menuitemspan">Interface Doc</span>
						</a>
					</nobr>
				</td>
			</tr>
			<!-- Doc Class Search(현대제철 전용) -->
			%ifvar customerCode equals('HSC')%
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-docclasssearch-hsc.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-docclasssearch-hsc.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-docclasssearch-hsc.html" name="basic-docclasssearch-hsc.html" src="images/blank.gif" border="0">
						<a id="abasic-docclasssearch-hsc.html" target='body' href="basic-docclasssearch-hsc.html" onclick="moveArrow('basic-docclasssearch-hsc.html', 'body'); return true;"><span class="menuitemspan">Doc Class Search</span>
						</a>
					</nobr>
				</td>
			</tr>
			%endifvar%
			
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-localfile.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-localfile.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-localfile.html" name="basic-localfile.html" src="images/blank.gif" border="0">
						<a id="abasic-localfile.html" target='body' href="basic-localfile.html" onclick="moveArrow('basic-localfile.html', 'body'); return true;"><span class="menuitemspan">Delete Local File</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-localfileschedule.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-localfileschedule.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-localfileschedule.html" name="basic-localfileschedule.html" src="images/blank.gif" border="0">
						<a id="abasic-localfileschedule.html" target='body' href="basic-localfileschedule.html" onclick="moveArrow('basic-localfileschedule.html', 'body'); return true;"><span class="menuitemspan">Local File Delete Schedule</span>
						</a>
					</nobr>
				</td>
			</tr>						
			<tr name="BasicInfo_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'basic-stemail.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['basic-stemail.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="basic-stemail.html" name="basic-stemail.html" src="images/blank.gif" border="0">
						<a id="abasic-stemail.html" target='body' href="basic-stemail.html" onclick="moveArrow('basic-stemail.html', 'body'); return true;"><span class="menuitemspan">Source Target Email</span>
						</a>
					</nobr>
				</td>
			</tr>			
			
			<!-- AS/400 -->
			<tr manualhide="true" onClick="toggle(this, 'AS400_subMenu', 'AS400_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='AS400_twistie' src="images/fc.gif">&nbsp;AS/400
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'as400-dataqlistener.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-dataqlistener.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-dataqlistener.html" name="as400-dataqlistener.html" src="images/blank.gif" border="0">
						<a id="aas400-dataqlistener.html" target='body' href="as400-dataqlistener.html" onclick="moveArrow('as400-dataqlistener.html', 'body'); return true;"><span class="menuitemspan">Data Q Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'as400-togglelistener.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-togglelistener.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-togglelistener.html" name="as400-togglelistener.html" src="images/blank.gif" border="0">
						<a id="aas400-togglelistener.html" target='body' href="as400-togglelistener.html" onclick="moveArrow('as400-togglelistener.html', 'body'); return true;"><span class="menuitemspan">Toggle Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'as400-healthchecklistener.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-healthchecklistener.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-healthchecklistener.html" name="as400-healthchecklistener.html" src="images/blank.gif" border="0">
						<a id="aas400-healthchecklistener.html" target='body' href="as400-healthchecklistener.html" onclick="moveArrow('as400-healthchecklistener.html', 'body'); return true;"><span class="menuitemspan">Health Check Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'as400-reconnectlistener.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-reconnectlistener.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-reconnectlistener.html" name="as400-reconnectlistener.html" src="images/blank.gif" border="0">
						<a id="aas400-reconnectlistener.html" target='body' href="as400-reconnectlistener.html" onclick="moveArrow('as400-reconnectlistener.html', 'body'); return true;"><span class="menuitemspan">Reconnect Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'as400-changedq.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-changedq.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-changedq.html" name="as400-changedq.html" src="images/blank.gif" border="0">
						<a id="aas400-changedq.html" target='body' href="as400-changedq.html" onclick="moveArrow('as400-changedq.html', 'body'); return true;"><span class="menuitemspan">Change Data Queue</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'as400-changedqschedule.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-changedqschedule.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-changedqschedule.html" name="as400-changedqschedule.html" src="images/blank.gif" border="0">
						<a id="aas400-changedqschedule.html" target='body' href="as400-changedqschedule.html" onclick="moveArrow('as400-changedqschedule.html', 'body'); return true;"><span class="menuitemspan">Queue Change Reservation</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'as400-switchlistener.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-switchlistener.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-switchlistener.html" name="as400-switchlistener.html" src="images/blank.gif" border="0">
						<a id="aas400-switchlistener.html" target='body' href="as400-switchlistener.html" onclick="moveArrow('as400-switchlistener.html', 'body'); return true;"><span class="menuitemspan">Switch Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'as400-deploylistener.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-deploylistener.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-deploylistener.html" name="as400-deploylistener.html" src="images/blank.gif" border="0">
						<a id="aas400-deploylistener.html" target='body' href="as400-deploylistener.html" onclick="moveArrow('as400-deploylistener.html', 'body'); return true;"><span class="menuitemspan">Deploy Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="AS400_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'as400-reservationschedule.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['as400-reservationschedule.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="as400-reservationschedule.html" name="as400-reservationschedule.html" src="images/blank.gif" border="0">
						<a id="aas400-reservationschedule.html" target='body' href="as400-reservationschedule.html" onclick="moveArrow('as400-reservationschedule.html', 'body'); return true;"><span class="menuitemspan">Deployment Reservation</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			<!-- Server Socket -->
			<tr manualhide="true" onClick="toggle(this, 'ServerSocket_subMenu', 'ServerSocket_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='ServerSocket_twistie' src="images/fc.gif">&nbsp;Server Socket
				</td>
			</tr>
			<tr name="ServerSocket_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socket-localserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socket-localserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socket-localserver.html" name="socket-localserver.html" src="images/blank.gif" border="0">
						<a id="asocket-localserver.html" target='body' href="socket-localserver.html" onclick="moveArrow('socket-localserver.html', 'body'); return true;"><span class="menuitemspan">Local Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="ServerSocket_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socket-remoteserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socket-remoteserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socket-remoteserver.html" name="socket-remoteserver.html" src="images/blank.gif" border="0">
						<a id="asocket-remoteserver.html" target='body' href="socket-remoteserver.html" onclick="moveArrow('socket-remoteserver.html', 'body'); return true;"><span class="menuitemspan">Remote Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			<!-- Online Server -->
			<!-- Custom Variable ESB.SOCKET.ONLINE.MENUDISPLAY가 inlist로 설정된 경우 -->
			<tr manualhide="true" onClick="toggle(this, 'OnlineServerList_subMenu', 'OnlineServerList_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='OnlineServerList_twistie' src="images/fc.gif">&nbsp;Online Server
				</td>
			</tr>
			<tr name="OnlineServerList_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchonserver-list.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchonserver-list.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchonserver-list.html" name="asynchonserver-list.html" src="images/blank.gif" border="0">
						<a id="aasynchonserver-list.html" target='body' href="asynchonserver-list.html" onclick="moveArrow('asynchonserver-list.html', 'body'); return true;"><span class="menuitemspan">Online Server List</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="OnlineServerList_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchonserver-listener.html');"
          				onmouseout="menuMouseOut(this);"
						onclick="document.all['asynchonserver-listener.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchonserver-listener.html" name="asynchonserver-listener.html" src="images/blank.gif" border="0">
						<a id="asynchonserver-listener.html" target='body' href="savedobject-onlineserverlistener.html" onclick="moveArrow('asynchonserver-listener.html', 'body'); return true;"><span class="menuitemspan">Online Server Listener</span>
						</a>
					</nobr>
				</td>
			</tr>						
			
			<!-- Asynch Online Socket Client -->
			<!-- Custom Variable ESB.SOCKET.ONLINE.MENUDISPLAY가 inlist로 설정된 경우 -->
			<tr manualhide="true" onClick="toggle(this, 'OnlineClientList_subMenu', 'OnlineClientList_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='OnlineClientList_twistie' src="images/fc.gif">&nbsp;Online Client
				</td>
			</tr>
			<tr name="OnlineClientList_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchonclient-list.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchonclient-list.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchonclient-list.html" name="asynchonclient-list.html" src="images/blank.gif" border="0">
						<a id="asynchonclient-list.html" target='body' href="asynchonclient-list.html" onclick="moveArrow('asynchonclient-list.html', 'body'); return true;"><span class="menuitemspan">Online Client List</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="OnlineClientList_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchonclient-listener.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchonclient-listener.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchonclient-listener.html" name="asynchonclient-listener.html" src="images/blank.gif" border="0">
						<a id="asynchonclient-listener.html" target='body' href="savedobject-onlineclientlistener.html" onclick="moveArrow('asynchonclient-listener.html', 'body'); return true;"><span class="menuitemspan">Online Client Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="OnlineClientList_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchonclient-healthcheck.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchonclient-healthcheck.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchonclient-healthcheck.html" name="asynchonclient-healthcheck.html" src="images/blank.gif" border="0">
						<a id="asynchonclient-healthcheck.html" target='body' href="savedobject-onlinehealthcheck.html" onclick="moveArrow('asynchonclient-healthcheck.html', 'body'); return true;"><span class="menuitemspan">Online Health Check</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			<!-- Online Server -->
			<!-- Custom Variable ESB.SOCKET.ONLINE.MENUDISPLAY가 inmenu로 설정된 경우 -->
			<tr manualhide="true" onClick="toggle(this, 'OnlineServer_subMenu', 'OnlineServer_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='OnlineServer_twistie' src="images/fc.gif">&nbsp;Online Server
				</td>
			</tr>
			<tr name="OnlineServer_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchonserver-connection.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchonserver-connection.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchonserver-connection.html" name="asynchonserver-connection.html" src="images/blank.gif" border="0">
						<a id="aasynchonserver-connection.html" target='body' href="asynchonserver-connection.html" onclick="moveArrow('asynchonserver-connection.html', 'body'); return true;"><span class="menuitemspan">Port 7777</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			<!-- Asynch Online Socket Client -->
			<!-- Custom Variable ESB.SOCKET.ONLINE.MENUDISPLAY가 inmenu로 설정된 경우 -->
			<tr manualhide="true" onClick="toggle(this, 'KFTC_subMenu', 'KFTC_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='KFTC_twistie' src="images/fc.gif">&nbsp;KFTC Online Client
				</td>
			</tr>
			<tr name="KFTC_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchon-connection.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchon-connection.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchon-connection.html" name="asynchon-connection.html" src="images/blank.gif" border="0">
						<a id="aasynchon-connection.html" target='body' href="asynchon-connection.html" onclick="moveArrow('asynchon-connection.html', 'body'); return true;"><span class="menuitemspan">Online Connection</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="KFTC_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchon-scheduler.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchon-scheduler.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchon-scheduler.html" name="asynchon-scheduler.html" src="images/blank.gif" border="0">
						<a id="aasynchon-scheduler.html" target='body' href="asynchon-scheduler.html" onclick="moveArrow('asynchon-scheduler.html', 'body'); return true;"><span class="menuitemspan">Online Check Schedule</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="KFTC_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchon-trigger.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchon-trigger.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchon-trigger.html" name="asynchon-trigger.html" src="images/blank.gif" border="0">
						<a id="aasynchon-trigger.html" target='body' href="asynchon-trigger.html" onclick="moveArrow('asynchon-trigger.html', 'body'); return true;"><span class="menuitemspan">Trigger</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="KFTC_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchon-dqlistener.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchon-dqlistener.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchon-dqlistener.html" name="asynchon-dqlistener.html" src="images/blank.gif" border="0">
						<a id="aasynchon-dqlistener.html" target='body' href="asynchon-dqlistener.html" onclick="moveArrow('asynchon-dqlistener.html', 'body'); return true;"><span class="menuitemspan">Data Q Listener</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="KFTC_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchon-switchsocket.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchon-switchsocket.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchon-switchsocket.html" name="asynchon-switchsocket.html" src="images/blank.gif" border="0">
						<a id="aasynchon-switchsocket.html" target='body' href="asynchon-switchsocket.html" onclick="moveArrow('asynchon-switchsocket.html', 'body'); return true;"><span class="menuitemspan">Switch Socket Operation</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="KFTC_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchon-switchingschedule.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchon-switchingschedule.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchon-switchingschedule.html" name="asynchon-switchingschedule.html" src="images/blank.gif" border="0">
						<a id="aasynchon-switchingschedule.html" target='body' href="asynchon-switchingschedule.html" onclick="moveArrow('asynchon-switchingschedule.html', 'body'); return true;"><span class="menuitemspan">Switching Schedule</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="KFTC_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'asynchon-errorhistory.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['asynchon-errorhistory.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="asynchon-errorhistory.html" name="asynchon-errorhistory.html" src="images/blank.gif" border="0">
						<a id="aasynchon-errorhistory.html" target='body' href="asynchon-errorhistory.html" onclick="moveArrow('asynchon-errorhistory.html', 'body'); return true;"><span class="menuitemspan">Online Error History</span>
						</a>
					</nobr>
				</td>
			</tr>						
			
			<!-- Socket Log -->
			<tr manualhide="true" onClick="toggle(this, 'SocketLog_subMenu', 'SocketLog_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='SocketLog_twistie' src="images/fc.gif">&nbsp;Socket Log
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-localqueuelist.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-localqueuelist.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-localqueuelist.html" name="socketlog-localqueuelist.html" src="images/blank.gif" border="0">
						<a id="asocketlog-localqueuelist.html" target='body' href="socketlog-localqueuelist.html" onclick="moveArrow('socketlog-localqueuelist.html', 'body'); return true;"><span class="menuitemspan">Local Server Queue Info</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-localauditlist.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-localauditlist.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-localauditlist.html" name="socketlog-localauditlist.html" src="images/blank.gif" border="0">
						<a id="asocketlog-localauditlist.html" target='body' href="socketlog-localauditlist.html" onclick="moveArrow('socketlog-localauditlist.html', 'body'); return true;"><span class="menuitemspan">Local Server Audit Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-localserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-localserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-localserver.html" name="socketlog-localserver.html" src="images/blank.gif" border="0">
						<a id="asocketlog-localserver.html" target='body' href="socketlog-localserver.html" onclick="moveArrow('socketlog-localserver.html', 'body'); return true;"><span class="menuitemspan">Local Server Socket Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-localreauditlist.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-localreauditlist.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-localreauditlist.html" name="socketlog-localreauditlist.html" src="images/blank.gif" border="0">
						<a id="asocketlog-localreauditlist.html" target='body' href="socketlog-localreauditlist.html" onclick="moveArrow('socketlog-localreauditlist.html', 'body'); return true;"><span class="menuitemspan">Local Server Resubmit Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-localskiplist.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-localskiplist.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-localskiplist.html" name="socketlog-localskiplist.html" src="images/blank.gif" border="0">
						<a id="asocketlog-localskiplist.html" target='body' href="socketlog-localskiplist.html" onclick="moveArrow('socketlog-localskiplist.html', 'body'); return true;"><span class="menuitemspan">Local Server Skip Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-localerrorlist.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-localerrorlist.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-localerrorlist.html" name="socketlog-localerrorlist.html" src="images/blank.gif" border="0">
						<a id="asocketlog-localerrorlist.html" target='body' href="socketlog-localerrorlist.html" onclick="moveArrow('socketlog-localerrorlist.html', 'body'); return true;"><span class="menuitemspan">Local Server Error Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-localconnectionlist.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-localconnectionlist.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-localconnectionlist.html" name="socketlog-localconnectionlist.html" src="images/blank.gif" border="0">
						<a id="asocketlog-localconnectionlist.html" target='body' href="socketlog-localconnectionlist.html" onclick="moveArrow('socketlog-localconnectionlist.html', 'body'); return true;"><span class="menuitemspan">Local Server Connection Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-localonlinetrace.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-localonlinetrace.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-localonlinetrace.html" name="socketlog-localonlinetrace.html" src="images/blank.gif" border="0">
						<a id="asocketlog-localonlinetrace.html" target='body' href="socketlog-localonlinetrace.html" onclick="moveArrow('socketlog-localonlinetrace.html', 'body'); return true;"><span class="menuitemspan">Local Online Trace Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-remoteauditlist.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-remoteauditlist.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-remoteauditlist.html" name="socketlog-remoteauditlist.html" src="images/blank.gif" border="0">
						<a id="asocketlog-remoteauditlist.html" target='body' href="socketlog-remoteauditlist.html" onclick="moveArrow('socketlog-remoteauditlist.html', 'body'); return true;"><span class="menuitemspan">Remote Server Audit Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-remoteserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-remoteserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-remoteserver.html" name="socketlog-remoteserver.html" src="images/blank.gif" border="0">
						<a id="asocketlog-remoteserver.html" target='body' href="socketlog-remoteserver.html" onclick="moveArrow('socketlog-remoteserver.html', 'body'); return true;"><span class="menuitemspan">Remote Server Socket Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-remoteconnectionlist.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-remoteconnectionlist.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-remoteconnectionlist.html" name="socketlog-remoteconnectionlist.html" src="images/blank.gif" border="0">
						<a id="asocketlog-remoteconnectionlist.html" target='body' href="socketlog-remoteconnectionlist.html" onclick="moveArrow('socketlog-remoteconnectionlist.html', 'body'); return true;"><span class="menuitemspan">Remote Server Connection Log</span>
						</a>
					</nobr>
				</td>
			</tr>						
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-remoteonlinetrace.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-remoteonlinetrace.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-remoteonlinetrace.html" name="socketlog-remoteonlinetrace.html" src="images/blank.gif" border="0">
						<a id="asocketlog-remoteonlinetrace.html" target='body' href="socketlog-remoteonlinetrace.html" onclick="moveArrow('socketlog-remoteonlinetrace.html', 'body'); return true;"><span class="menuitemspan">Remote Online Trace Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-onlinetemphistory.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-onlinetemphistory.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-onlinetemphistory.html" name="socketlog-onlinetemphistory.html" src="images/blank.gif" border="0">
						<a id="asocketlog-onlinetemphistory.html" target='body' href="socketlog-onlinetemphistory.html" onclick="moveArrow('socketlog-onlinetemphistory.html', 'body'); return true;"><span class="menuitemspan">Remote Online Temp History Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SocketLog_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'socketlog-mailnoti.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['socketlog-mailnoti.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="socketlog-mailnoti.html" name="socketlog-mailnoti.html" src="images/blank.gif" border="0">
						<a id="asocketlog-mailnoti.html" target='body' href="socketlog-mailnoti.html" onclick="moveArrow('socketlog-mailnoti.html', 'body'); return true;"><span class="menuitemspan">Mail Notification Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			<!-- Utility -->
			<tr manualhide="true" onClick="toggle(this, 'Utility_subMenu', 'Utility_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='Utility_twistie' src="images/fc.gif">&nbsp;Utility
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-suspendemail.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-suspendemail.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-suspendemail.html" name="utility-suspendemail.html" src="images/blank.gif" border="0">
						<a id="autility-suspendemail.html" target='body' href="utility-suspendemail.html" onclick="moveArrow('utility-suspendemail.html', 'body'); return true;"><span class="menuitemspan">Suspend E-Mail Notification</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-checkconnection.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-checkconnection.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-checkconnection.html" name="utility-checkconnection.html" src="images/blank.gif" border="0">
						<a id="autility-checkconnection.html" target='body' href="utility-checkconnection.html" onclick="moveArrow('utility-checkconnection.html', 'body'); return true;"><span class="menuitemspan">Check Target Connection</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-fileupload.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-fileupload.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-fileupload.html" name="utility-fileupload.html" src="images/blank.gif" border="0">
						<a id="autility-fileupload.html" target='body' href="utility-fileupload.html" onclick="moveArrow('utility-fileupload.html', 'body'); return true;"><span class="menuitemspan">Upload File</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-filedownload.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-filedownload.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-filedownload.html" name="utility-filedownload.html" src="images/blank.gif" border="0">
						<a id="autility-filedownload.html" target='body' href="utility-filedownload.html" onclick="moveArrow('utility-filedownload.html', 'body'); return true;"><span class="menuitemspan">Download File</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-deployfile.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-deployfile.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-deployfile.html" name="utility-deployfile.html" src="images/blank.gif" border="0">
						<a id="autility-deployfile.html" target='body' href="utility-deployfile.html" onclick="moveArrow('utility-deployfile.html', 'body'); return true;"><span class="menuitemspan">Deploy File</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-serverlog.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-serverlog.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-serverlog.html" name="utility-serverlog.html" src="images/blank.gif" border="0">
						<a id="autility-serverlog.html" target='body' href="utility-serverlog.html" onclick="moveArrow('utility-serverlog.html', 'body'); return true;"><span class="menuitemspan">Server Log</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-serverresource.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-serverresource.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-serverresource.html" name="utility-serverresource.html" src="images/blank.gif" border="0">
						<a id="autility-serverresource.html" target='body' href="utility-serverresource.html" onclick="moveArrow('utility-serverresource.html', 'body'); return true;"><span class="menuitemspan">Server Resources</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-serverresourcewarning.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-serverresourcewarning.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-serverresourcewarning.html" name="utility-serverresourcewarning.html" src="images/blank.gif" border="0">
						<a id="autility-serverresourcewarning.html" target='body' href="utility-serverresourcewarning.html" onclick="moveArrow('utility-serverresourcewarning.html', 'body'); return true;"><span class="menuitemspan">Server Resources Warning</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-statslog.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-statslog.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-statslog.html" name="utility-statslog.html" src="images/blank.gif" border="0">
						<a id="autility-statslog.html" target='body' href="utility-statslog.html" onclick="moveArrow('utility-statslog.html', 'body'); return true;"><span class="menuitemspan">Stats Log Analysis</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-reserveprojectdeployment.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-reserveprojectdeployment.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-reserveprojectdeployment.html" name="utility-reserveprojectdeployment.html" src="images/blank.gif" border="0">
						<a id="autility-reserveprojectdeployment.html" target='body' href="utility-reserveprojectdeployment.html" onclick="moveArrow('utility-reserveprojectdeployment.html', 'body'); return true;"><span class="menuitemspan">Reserve Project Deployment</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-projectdeploymentschedule.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-projectdeploymentschedule.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-projectdeploymentschedule.html" name="utility-projectdeploymentschedule.html" src="images/blank.gif" border="0">
						<a id="autility-projectdeploymentschedule.html" target='body' href="utility-projectdeploymentschedule.html" onclick="moveArrow('utility-projectdeploymentschedule.html', 'body'); return true;"><span class="menuitemspan">Deployment Reservation</span>
						</a>
					</nobr>
				</td>
			</tr>
			<!-- AIA생명 전용 -->
			%ifvar customerCode equals('AIA')%
			<tr name="Utility_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'utility-serverrestart.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['utility-serverrestart.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="utility-serverrestart.html" name="utility-serverrestart.html" src="images/blank.gif" border="0">
						<a id="autility-serverrestart.html" target='body' href="utility-serverrestart.html" onclick="moveArrow('utility-serverrestart.html', 'body'); return true;"><span class="menuitemspan">Server Restart</span>
						</a>
					</nobr>
				</td>
			</tr>
			%endifvar%
			
			<!-- Deploy Config -->
			<tr manualhide="true" onClick="toggle(this, 'DeployConfig_subMenu', 'DeployConfig_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='DeployConfig_twistie' src="images/fc.gif">&nbsp;Deploy Config
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-customvariablevalue.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-customvariablevalue.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-customvariablevalue.html" name="deploy-customvariablevalue.html" src="images/blank.gif" border="0">
						<a id="adeploy-customvariablevalue.html" target='body' href="deploy-customvariablevalue.html" onclick="moveArrow('deploy-customvariablevalue.html', 'body'); return true;"><span class="menuitemspan">Custom Variable Value</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-customvariable.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-customvariable.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-customvariable.html" name="deploy-customvariable.html" src="images/blank.gif" border="0">
						<a id="adeploy-customvariable.html" target='body' href="deploy-customvariable.html" onclick="moveArrow('deploy-customvariable.html', 'body'); return true;"><span class="menuitemspan">Custom Variable</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-systemname.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-systemname.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-systemname.html" name="deploy-systemname.html" src="images/blank.gif" border="0">
						<a id="adeploy-systemname.html" target='body' href="deploy-systemname.html" onclick="moveArrow('deploy-systemname.html', 'body'); return true;"><span class="menuitemspan">System Name</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-businessname.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-businessname.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-businessname.html" name="deploy-businessname.html" src="images/blank.gif" border="0">
						<a id="adeploy-businessname.html" target='body' href="deploy-businessname.html" onclick="moveArrow('deploy-businessname.html', 'body'); return true;"><span class="menuitemspan">Business Name</span>
						</a>
					</nobr>
				</td>
			</tr>
			<!--
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-businessif.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-businessif.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-businessif.html" name="deploy-businessif.html" src="images/blank.gif" border="0">
						<a id="adeploy-businessif.html" target='body' href="deploy-businessif.html" onclick="moveArrow('deploy-businessif.html', 'body'); return true;"><span class="menuitemspan">Business Doc</span>
						</a>
					</nobr>
				</td>
			</tr>
			-->
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-restapiprotocol.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-restapiprotocol.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-restapiprotocol.html" name="deploy-restapiprotocol.html" src="images/blank.gif" border="0">
						<a id="adeploy-restapiprotocol.html" target='body' href="deploy-restapiprotocol.html" onclick="moveArrow('deploy-restapiprotocol.html', 'body'); return true;"><span class="menuitemspan">REST API Protocol</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-docinterfaceid.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-docinterfaceid.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-docinterfaceid.html" name="deploy-docinterfaceid.html" src="images/blank.gif" border="0">
						<a id="adeploy-docinterfaceid.html" target='body' href="deploy-docinterfaceid.html" onclick="moveArrow('deploy-docinterfaceid.html', 'body'); return true;"><span class="menuitemspan">Interface Doc</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-httpdocinterfaceid.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-httpdocinterfaceid.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-httpdocinterfaceid.html" name="deploy-httpdocinterfaceid.html" src="images/blank.gif" border="0">
						<a id="adeploy-httpdocinterfaceid.html" target='body' href="deploy-httpdocinterfaceid.html" onclick="moveArrow('deploy-httpdocinterfaceid.html', 'body'); return true;"><span class="menuitemspan">HTTP/S Target Doc</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-docschemadef.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-docschemadef.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-docschemadef.html" name="deploy-docschemadef.html" src="images/blank.gif" border="0">
						<a id="adeploy-docschemadef.html" target='body' href="deploy-docschemadef.html" onclick="moveArrow('deploy-docschemadef.html', 'body'); return true;"><span class="menuitemspan">Doc Schema Define</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-schemadeployreservation.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-schemadeployreservation.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-schemadeployreservation.html" name="deploy-schemadeployreservation.html" src="images/blank.gif" border="0">
						<a id="adeploy-schemadeployreservation.html" target='body' href="deploy-schemadeployreservation.html" onclick="moveArrow('deploy-schemadeployreservation.html', 'body'); return true;"><span class="menuitemspan">Doc Schema Reservation</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-localfile.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-localfile.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-localfile.html" name="deploy-localfile.html" src="images/blank.gif" border="0">
						<a id="adeploy-localfile.html" target='body' href="deploy-localfile.html" onclick="moveArrow('deploy-localfile.html', 'body'); return true;"><span class="menuitemspan">Delete Local File</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-localserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-localserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-localserver.html" name="deploy-localserver.html" src="images/blank.gif" border="0">
						<a id="adeploy-localserver.html" target='body' href="deploy-localserver.html" onclick="moveArrow('deploy-localserver.html', 'body'); return true;"><span class="menuitemspan">Local Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-remoteserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-remoteserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-remoteserver.html" name="deploy-remoteserver.html" src="images/blank.gif" border="0">
						<a id="adeploy-remoteserver.html" target='body' href="deploy-remoteserver.html" onclick="moveArrow('deploy-remoteserver.html', 'body'); return true;"><span class="menuitemspan">Remote Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>					
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-queuetopic.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-queuetopic.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-queuetopic.html" name="deploy-queuetopic.html" src="images/blank.gif" border="0">
						<a id="adeploy-queuetopic.html" target='body' href="deploy-queuetopic.html" onclick="moveArrow('deploy-queuetopic.html', 'body'); return true;"><span class="menuitemspan">Queue/Topic</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-stemail.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-stemail.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-stemail.html" name="deploy-stemail.html" src="images/blank.gif" border="0">
						<a id="adeploy-stemail.html" target='body' href="deploy-stemail.html" onclick="moveArrow('deploy-stemail.html', 'body'); return true;"><span class="menuitemspan">Source Target Email</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-scheduler.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-scheduler.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-scheduler.html" name="deploy-scheduler.html" src="images/blank.gif" border="0">
						<a id="adeploy-scheduler.html" target='body' href="deploy-scheduler.html" onclick="moveArrow('deploy-scheduler.html', 'body'); return true;"><span class="menuitemspan">Online Check Schedule</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-trigger.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-trigger.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-trigger.html" name="deploy-trigger.html" src="images/blank.gif" border="0">
						<a id="adeploy-trigger.html" target='body' href="deploy-trigger.html" onclick="moveArrow('deploy-trigger.html', 'body'); return true;"><span class="menuitemspan">Online Trigger</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-schedule.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-schedule.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-schedule.html" name="deploy-schedule.html" src="images/blank.gif" border="0">
						<a id="adeploy-schedule.html" target='body' href="deploy-schedule.html" onclick="moveArrow('deploy-schedule.html', 'body'); return true;"><span class="menuitemspan">Schedule</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-scheduledeployreservation.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-scheduledeployreservation.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-scheduledeployreservation.html" name="deploy-scheduledeployreservation.html" src="images/blank.gif" border="0">
						<a id="adeploy-scheduledeployreservation.html" target='body' href="deploy-scheduledeployreservation.html" onclick="moveArrow('deploy-scheduledeployreservation.html', 'body'); return true;"><span class="menuitemspan">Schedule Reservation</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="DeployConfig_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'deploy-allconfig.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['deploy-allconfig.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="deploy-allconfig.html" name="deploy-allconfig.html" src="images/blank.gif" border="0">
						<a id="adeploy-allconfig.html" target='body' href="deploy-allconfig.html" onclick="moveArrow('deploy-allconfig.html', 'body'); return true;"><span class="menuitemspan">All Config</span>
						</a>
					</nobr>
				</td>
			</tr>
			
			<!-- IS Memory Object -->
			<tr manualhide="true" onClick="toggle(this, 'SavedObjectMemory_subMenu', 'SavedObjectMemory_twistie');" OnMouseOver="this.className='cursor';">
  			<td>
					<img id='SavedObjectMemory_twistie' src="images/fc.gif">&nbsp;IS Memory Object
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-customvariable.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-customvariable.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-customvariable.html" name="savedobject-customvariable.html" src="images/blank.gif" border="0">
						<a id="asavedobject-customvariable.html" target='body' href="savedobject-customvariable.html" onclick="moveArrow('savedobject-customvariable.html', 'body'); return true;"><span class="menuitemspan">Custom Variable</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-businessname.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-businessname.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-businessname.html" name="savedobject-businessname.html" src="images/blank.gif" border="0">
						<a id="asavedobject-businessname.html" target='body' href="savedobject-businessname.html" onclick="moveArrow('savedobject-businessname.html', 'body'); return true;"><span class="menuitemspan">Business Name</span>
						</a>
					</nobr>
				</td>
			</tr>
			<!--
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-businessif.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-businessif.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-businessif.html" name="savedobject-businessif.html" src="images/blank.gif" border="0">
						<a id="asavedobject-businessif.html" target='body' href="savedobject-businessif.html" onclick="moveArrow('savedobject-businessif.html', 'body'); return true;"><span class="menuitemspan">Business Doc</span>
						</a>
					</nobr>
				</td>
			</tr>
			-->
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-businessdocschemadef.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-businessdocschemadef.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-businessdocschemadef.html" name="savedobject-businessdocschemadef.html" src="images/blank.gif" border="0">
						<a id="asavedobject-businessdocschemadef.html" target='body' href="savedobject-businessdocschemadef.html" onclick="moveArrow('savedobject-businessdocschemadef.html', 'body'); return true;"><span class="menuitemspan">Client Doc Schema Define</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-restapiprotocol.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-restapiprotocol.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-restapiprotocol.html" name="savedobject-restapiprotocol.html" src="images/blank.gif" border="0">
						<a id="asavedobject-restapiprotocol.html" target='body' href="savedobject-restapiprotocol.html" onclick="moveArrow('savedobject-restapiprotocol.html', 'body'); return true;"><span class="menuitemspan">REST API Protocol</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-docinterfaceid.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-docinterfaceid.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-docinterfaceid.html" name="savedobject-docinterfaceid.html" src="images/blank.gif" border="0">
						<a id="asavedobject-docinterfaceid.html" target='body' href="savedobject-docinterfaceid.html" onclick="moveArrow('savedobject-docinterfaceid.html', 'body'); return true;"><span class="menuitemspan">Interface Doc</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-docschemadef.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-docschemadef.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-docschemadef.html" name="savedobject-docschemadef.html" src="images/blank.gif" border="0">
						<a id="asavedobject-docschemadef.html" target='body' href="savedobject-docschemadef.html" onclick="moveArrow('savedobject-docschemadef.html', 'body'); return true;"><span class="menuitemspan">Server Doc Schema Define</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-runninglocalserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-runninglocalserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-runninglocalserver.html" name="savedobject-runninglocalserver.html" src="images/blank.gif" border="0">
						<a id="asavedobject-runninglocalserver.html" target='body' href="savedobject-runninglocalserver.html" onclick="moveArrow('savedobject-runninglocalserver.html', 'body'); return true;"><span class="menuitemspan">Running Local Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-localserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-localserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-localserver.html" name="savedobject-localserver.html" src="images/blank.gif" border="0">
						<a id="asavedobject-localserver.html" target='body' href="savedobject-localserver.html" onclick="moveArrow('savedobject-localserver.html', 'body'); return true;"><span class="menuitemspan">Local Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-remoteserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-remoteserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-remoteserver.html" name="savedobject-remoteserver.html" src="images/blank.gif" border="0">
						<a id="asavedobject-remoteserver.html" target='body' href="savedobject-remoteserver.html" onclick="moveArrow('savedobject-remoteserver.html', 'body'); return true;"><span class="menuitemspan">Remote Server Socket</span>
						</a>
					</nobr>
				</td>
			</tr>									
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-serialqueue.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-serialqueue.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-serialqueue.html" name="savedobject-serialqueue.html" src="images/blank.gif" border="0">
						<a id="asavedobject-serialqueue.html" target='body' href="savedobject-serialqueue.html" onclick="moveArrow('savedobject-serialqueue.html', 'body'); return true;"><span class="menuitemspan">Local Serial Queuing Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-socketlogqueue.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-socketlogqueue.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-socketlogqueue.html" name="savedobject-socketlogqueue.html" src="images/blank.gif" border="0">
						<a id="asavedobject-socketlogqueue.html" target='body' href="savedobject-socketlogqueue.html" onclick="moveArrow('savedobject-socketlogqueue.html', 'body'); return true;"><span class="menuitemspan">Socket Log Queue</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-socketobject.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-socketobject.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-socketobject.html" name="savedobject-socketobject.html" src="images/blank.gif" border="0">
						<a id="asavedobject-socketobject.html" target='body' href="savedobject-socketobject.html" onclick="moveArrow('savedobject-socketobject.html', 'body'); return true;"><span class="menuitemspan">Request Socket Object</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-threadid.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-threadid.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-threadid.html" name="savedobject-threadid.html" src="images/blank.gif" border="0">
						<a id="asavedobject-threadid.html" target='body' href="savedobject-threadid.html" onclick="moveArrow('savedobject-threadid.html', 'body'); return true;"><span class="menuitemspan">Service Thread ID</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlinesocketclient.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlinesocketclient.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlinesocketclient.html" name="savedobject-onlinesocketclient.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlinesocketclient.html" target='body' href="savedobject-onlinesocketclient.html" onclick="moveArrow('savedobject-onlinesocketclient.html', 'body'); return true;"><span class="menuitemspan">Online Client Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlineconnectcount.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlineconnectcount.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlineconnectcount.html" name="savedobject-onlineconnectcount.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlineconnectcount.html" target='body' href="savedobject-onlineconnectcount.html" onclick="moveArrow('savedobject-onlineconnectcount.html', 'body'); return true;"><span class="menuitemspan">Online Connect Count</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlinerequestheader.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlinerequestheader.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlinerequestheader.html" name="savedobject-onlinerequestheader.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlinerequestheader.html" target='body' href="savedobject-onlinerequestheader.html" onclick="moveArrow('savedobject-onlinerequestheader.html', 'body'); return true;"><span class="menuitemspan">Online Request Header</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlinesendstatus.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlinesendstatus.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlinesendstatus.html" name="savedobject-onlinesendstatus.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlinesendstatus.html" target='body' href="savedobject-onlinesendstatus.html" onclick="moveArrow('savedobject-onlinesendstatus.html', 'body'); return true;"><span class="menuitemspan">Online Send Status</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlineresponsedata.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlineresponsedata.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlineresponsedata.html" name="savedobject-onlineresponsedata.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlineresponsedata.html" target='body' href="savedobject-onlineresponsedata.html" onclick="moveArrow('savedobject-onlineresponsedata.html', 'body'); return true;"><span class="menuitemspan">Online Response Data</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlinerunningserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlinerunningserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlinerunningserver.html" name="savedobject-onlinerunningserver.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlinerunningserver.html" target='body' href="savedobject-onlinerunningserver.html" onclick="moveArrow('savedobject-onlinerunningserver.html', 'body'); return true;"><span class="menuitemspan">Online Running Server</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlinereconnectingserver.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlinereconnectingserver.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlinereconnectingserver.html" name="savedobject-onlinereconnectingserver.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlinereconnectingserver.html" target='body' href="savedobject-onlinereconnectingserver.html" onclick="moveArrow('savedobject-onlinereconnectingserver.html', 'body'); return true;"><span class="menuitemspan">Online Reconnecting Server</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlinereceivesequence.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlinereceivesequence.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlinereceivesequence.html" name="savedobject-onlinereceivesequence.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlinereceivesequence.html" target='body' href="savedobject-onlinereceivesequence.html" onclick="moveArrow('savedobject-onlinereceivesequence.html', 'body'); return true;"><span class="menuitemspan">Online Receive Sequence</span>
						</a>
					</nobr>
				</td>
			</tr>
			<!-- Online Socket Queue 메뉴와 Online Queuing Socket 메뉴를 하나로 통합
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlinesocketqueue.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlinesocketqueue.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlinesocketqueue.html" name="savedobject-onlinesocketqueue.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlinesocketqueue.html" target='body' href="savedobject-onlinesocketqueue.html" onclick="moveArrow('savedobject-onlinesocketqueue.html', 'body'); return true;"><span class="menuitemspan">Online Socket Queue</span>
						</a>
					</nobr>
				</td>
			</tr>
			-->
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlinequeuing.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlinequeuing.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlinequeuing.html" name="savedobject-onlinequeuing.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlinequeuing.html" target='body' href="savedobject-onlinequeuing.html" onclick="moveArrow('savedobject-onlinequeuing.html', 'body'); return true;"><span class="menuitemspan">Online Queuing Socket</span>
						</a>
					</nobr>
				</td>
			</tr>
			<tr name="SavedObjectMemory_subMenu" style="display: none">
				<td
					onmouseover="menuMouseOver(this, 'savedobject-onlinedatadelete.html');"
          				onmouseout="menuMouseOut(this);"
          				onclick="document.all['savedobject-onlinedatadelete.html'].click();"

				>
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
						<img valign="middle" id="savedobject-onlinedatadelete.html" name="savedobject-onlinedatadelete.html" src="images/blank.gif" border="0">
						<a id="asavedobject-onlinedatadelete.html" target='body' href="savedobject-onlinedatadelete.html" onclick="moveArrow('savedobject-onlinedatadelete.html', 'body'); return true;"><span class="menuitemspan">Temp Data Delete Schedule</span>
						</a>
					</nobr>
				</td>
			</tr>
		</table>
	</body>
</html>