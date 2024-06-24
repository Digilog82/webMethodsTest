%invoke JSocketAdapter.ADMIN:adminServerResources%

<html>
	<head>		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">			
		<LINK REL="stylesheet" TYPE="text/css" HREF="%value designPath%webMethods.css">
		<script language="javascript">
			function doAction(target) {
				var frm = document.pform;
				var refreshTypeA = document.getElementById("refreshTypeA").checked;
				var refreshInterval = frm.refreshInterval.value;
				
				if (refreshTypeA == true && refreshInterval == "") {
				  alert("Refresh Type이 Auto일 경우 Refresh Interval을 입력해야 합니다.");
				  return;
				}
				
				frm.target.value = target;
				frm.submit();
			}
			
			function refreshPage() {
			  window.location.href = "utility-serverresource.dsp?target=%value target%&remoteInvoke=false&refreshType=%value refreshType%&refreshInterval=%value refreshInterval%";
			}
		</script>
	</head>
	<body>
	
	  %ifvar lastError/error -notempty%
			<div class="message">%value lastError/error%</div>
		%endifvar%
		
		<form name="pform" method="post" target="_self">
			<input type="hidden" name="target" value="%value target%">
			<input type="hidden" name="remoteInvoke" value="false">

		<table width="100%">
			<tr>
					<td class="menusection-Settings" colspan="2">
						JSocketAdapter Package Home &gt;
						Utility &gt;
						Server Resources
					</td>
			</tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="4">Server Resources Display Properties</td>
			</tr>
			<tr>
				<td class="evenrow" width="15%">Select Server</td>
				<td class="evenrow-l" width="85%" colspan="3">
					%loop targetServerList%
					  <input type="button" name="SUBMIT" value="%value targetServerList%"  onclick="return doAction('%value targetServerList%')"></input>&nbsp;&nbsp;
					%endloop%
				</td>
			</tr>
			<tr>
				<td class="evenrow" width="15%">Refresh Type</td>
				<td class="evenrow-l" width="15%">
				  <input type="radio" id="refreshTypeM" name="refreshType" value="manual" %ifvar refreshType equals('manual')% checked %endifvar%>&nbsp;Manual&nbsp;
				  <input type="radio" id="refreshTypeA" name="refreshType" value="auto" %ifvar refreshType equals('auto')% checked %endifvar%>&nbsp;Auto
				<td class="evenrow" width="15%">Auto Refresh Interval</td>
				<td class="evenrow-l" width="55%">
				  <input type="text" name="refreshInterval" value="%value refreshInterval%" size="20" style="font-size:10pt;width:50">&nbsp;seconds&nbsp;
				  <input type="button" name="SUBMIT" value="Refresh"  onclick="return doAction('%value target%')">
				</td>
			</tr>
		</table>
				
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="4">%value target% IS Heap Memory</td>
			</tr>
			<tr>
        <td nowrap class="evenrow">Maximum</td>
        <td nowrap class="evenrowdata-r">%value maxMem% KB</td>
        <td nowrap class="evenrowdata-r">&nbsp;</td>
        <td nowrap class="evenrowdata-l" width="100%">&nbsp;</td>
      </tr>
      <tr>
        <td nowrap class="oddrow">Committed</td>
        <td nowrap class="oddrow-r">%value totalMem% KB</td>
        <td nowrap class="oddrow-r">&nbsp;</td>
        <td nowrap class="oddrow-l" width="100%">&nbsp;</td>
      </tr>
      <tr>
        <td nowrap class="evenrow">Used</td>
        <td nowrap class="evenrowdata-r">%value usedMem% KB</td>
        <td nowrap class="evenrowdata-r">%value usedMemPer%% (memory)</td>
        <td width="100%">
          <table id="usedMemoryBar" width="%value usedMemPer%%">
            <tr>
              <td><img border="0" src="%value designPath%images/pixel.gif" width="1" height="6" /></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td nowrap class="oddrow">Free</td>
        <td nowrap class="oddrow-r">%value freeMem% KB</td>
        <td nowrap class="oddrow-r">%value freeMemPer%%</td>
        <td nowrap class="oddrow-l" width="100%">
          <table id="freeMemoryBar" width="%value freeMemPer%%" >
            <tr>
              <td><img border="0" src="%value designPath%images/pixel.gif" height="6" width="1" ></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td colspan=4 width="100%" >
          <table class="memoryGraph" width="100%" cellpadding=0 cellspacing=2>
            <tr>
              <td width="25%" style="text-align: center">
                <table class="memoryTable" style="text-align: center">
                  <tr>
                    <td class="evenrowdata"><img src="images/blank.gif" height="10" width="10"></td>
                    <td class="evenrowdata" colspan="24">Memory Usage (average per hour)</td>
                    <td style="font-weight: normal;" class="evenrowdata-l">%value memArrayMax% KB</td>
                  </tr>
                  <tr>
                    <td class="evenrowdata"></td>
                    %loop -struct memArray%
                      <td class="memgraph">
                        <img src="%value designPath%images/pixel.gif"
                             width="14"
                             height="%value percent%"
                             alt="%ifvar $key equals('1')%%value $key% hour ago: %value actual% KB (%value percent%%) used
                                   %else%%value $key% hours ago: %value actual% KB (%value percent%%) used
                                   %endif%"/>
                      </td>
                    %endloop%
                    <td class="evenrowdata-l">
                      <img border="0" width="14" height="100" src="%value designPath%images/memory_gauge.gif">
                    </td>
                  </tr>
                  <tr>
                    %loop -struct memArray%
                      %switch $key%
                        %case '1'%
                        %case '2'%
                          <td class="evenrowdata" colspan=2>&nbsp;-1h</td>
                        %case '11'%
                        %case '12'%
                          <td class="evenrowdata" colspan=3>&nbsp;-12h</td>
                        %case '13'%
                        %case '23'%
                        %case '24'%
                          <td class="evenrowdata" colspan=3>&nbsp;-24h</td>
                        %case%
                          <td class="evenrowdata">&nbsp;</td>
                      %endswitch%
                    %endloop%
                    <td nowrap style="font-weight: normal;" class="evenrowdata-l">0 KB</td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">%value target% Thread Usage</td>
			</tr>
			<tr>
        <td nowrap class="evenrow" width="200">Service Instances</td>
        <td nowrap class="evenrowdata-l">%value svrT% (The number of running services currently active)</td>
      </tr>
      <tr>
        <td nowrap class="evenrow" width="200">Service Threads</td>
        <td nowrap class="evenrowdata-l">%value srvThreadCount% (The number of service threads spawned by the server’s running services and currently active)</td>
      </tr>
      <tr>
        <td nowrap class="evenrow" width="200">System Threads</td>
        <td nowrap class="evenrowdata-l">%value sysT% (The number of system threads spawned by the server’s internal processes and currently active)</td>
      </tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">%value target% %value Resources/ServerThreadPool/name%</td>
			</tr>
			<tr>
        <td nowrap class="evenrow" width="200">%value Resources/ServerThreadPool/fields/AvailableThreads/title%</td>
        <td nowrap class="evenrowdata-l">%value Resources/ServerThreadPool/fields/AvailableThreads/value%</td>
      </tr>
      <tr>
        <td nowrap class="evenrow" width="200">%value Resources/ServerThreadPool/fields/MaximumThreads/title%</td>
        <td nowrap class="evenrowdata-l">%value Resources/ServerThreadPool/fields/MaximumThreads/value%</td>
      </tr>
		</table>
		
		<table class="tableForm" width="100%">
			<tr>
				<td class="heading" colspan="2">%value target% HW Resources</td>
			</tr>
			<tr>
        <td nowrap class="evenrow" width="200">CPU</td>
        <td nowrap class="evenrowdata-l">
          %loop cpuInfoList%
            %value cpuInfoList%<br>
          %endloop%
        </td>
      </tr>
      <tr>
        <td nowrap class="evenrow" width="200">Memory</td>
        <td nowrap class="evenrowdata-l">
          %loop memInfoList%
            %value memInfoList%<br>
          %endloop%
        </td>
      </tr>
      <tr>
        <td nowrap class="evenrow" width="200">Java Process</td>
        <td nowrap class="evenrowdata-l">
          <script>
            var javaProcInfo = "%value javaProcInfo encode(none)%";
            javaProcInfo = javaProcInfo.replace(/ /gi, "&nbsp;"); // Space를 &nbsp;로 변환
            document.write(javaProcInfo);
          </script>
        </td>
      </tr>
		</table>
		
		</form>		
	</body>
</html>

<script>
  var refreshType = "%value refreshType%";
  var refreshInterval = "%value refreshInterval%";
  
  if (refreshType == "auto") {
    window.setInterval("refreshPage()", refreshInterval * 1000);
  }
</script>

%endinvoke%