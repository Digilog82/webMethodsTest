%comment%----- Lists Polling Notifications -----%endcomment%

<HTML>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" CONTENT="-1">
    <TITLE>Polling Notifications</title>
    <link rel="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css"></link>
	<Link REL="stylesheet" TYPE="text/css" HREF="../WmART/webMethods.css"></LINK>

    <SCRIPT LANGUAGE="JavaScript">
      function confirmDisable (aliasName)
      {
         var s1 = "OK to disable the `"+aliasName+"' Notification?\n\n";
         return confirm (s1);
      }
      function confirmEnable (aliasName)
      {
         var s1 = "OK to enable the `"+aliasName+"' Notification?\n\n";
         return confirm (s1);
      }      
      function confirmForce (aliasName)
      {
         var s1 = "OK to force the `"+aliasName+"' Notification to disabled status?\n\n";
         return confirm (s1);
      }
    </SCRIPT>
            %ifvar lt8%%else%<script src="/WmART/connectionfilter.js"></script>%endif%
    <SCRIPT SRC="/WmRoot/webMethods.js"></SCRIPT>
	<script type="text/javascript" src="/WmART/csrfGuard.js"></script>
</head>
%invoke wm.art.admin:getAdapterTypeOnlineHelp%
%onerror%
%endinvoke%
%invoke wm.art.admin:retrieveAdapterTypeData%
%onerror%
%endinvoke%
<BODY onLoad="setNavigation('ListListenerNotifications.dsp', '%value encode(javascript) helpsys%', 'foo');%ifvar lt8%%else%showHideFilterCriteria('searchListenerNotificationName');%endif%">
        %ifvar lt8%%else%<form name="form" action="ListListenerNotifications.dsp" method="POST">%endif%
<table width="100%">  
    <tr>
       	<td class="breadcrumb" colspan=5>Adapters &gt; %value displayName% &gt; Listener Notifications</TD>
    </tr>
    %comment%
    -- If we arrive at this page because of an enable/disable request, or an edit save, the
    -- action field will be set, we perform the requested action before refreshing the page.
    %endcomment%
      
    %ifvar action%
        %switch action%
        %case 'enableNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %case 'disableNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %case 'forceNotification'%
    %comment%
            %invoke wm.art.admin:forceNotificationDisable%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
    %endcomment%
         %case 'editAsyncListener'%
    		%invoke wm.art.admin:setNotificationJMSSettings%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %endswitch%
    %endif%

    %comment% When we arrive here, we start generating the tabular list of notifications %endcomment%  
    %ifvar lt8%%else%<tr>
                <td colspan=2>
                    <ul>
                         <li id="showfew" name="showfew"><a href="javascript:showFilterPanel(true)">Filter Listener Notifications</a></li>
                	 <li style="display:none" id="showall" name="showall"><a id="Show_All_Listener_Notifications" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS">Show All Listener Notifications</a>
					 <script>updateURL("Show_All_Listener_Notifications", "Show All Listener Notifications");</script>
					 </li>
                	 <DIV id="filterContainer" name="filterContainer" style="display:none;padding-top=2mm;">
			 	<br>
			 		<table>
			 		<tr valign="top">
			 		<td>
						<span>Filter criteria</span><br>
						<input id="searchListenerNotificationName" name="searchListenerNotificationName" value="%value -urldecode searchListenerNotificationName%" onkeydown="return processKey(event)" />
			 		</td>
			 		<td>
			 			<br>
			 				<input id="submitButton" name="Submit" type="submit" value="Submit" width="15" height="15" onClick="validateSearchCriteria('searchListenerNotificationName');return false;"/>                                        
			 			</br>
			 		</td> 
			 		</tr>
			 		</table>
			 	</br>  
                	</DIV>
                    </ul>
                </td>
            </tr>%endif%
    %comment% Get list of notifications that match our type %endcomment%
    %invoke wm.sap.Admin:listNotifications%
        %ifvar lt8%%else%<tr>
        <td colspan=8 align="right">
        	<label style="color:#666666;font-weight:bold;text-align:inherit;">%value pageLabel%</label>
        </td>
        </tr>%endif%
	<tr>
		<td>
			<table class="tableView" width="100%">
				<tbody>
	<TR>
        <td class="heading" colspan=3>%value displayName% Listener Notifications</td>
    </tr>
    <tr class="subheading2">
        <td class="oddcol-l">Notification Name%ifvar lt8%%else%<a id="ascLN" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=LN&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" style="float: middle" src="/WmART/images/arrow_up.gif" width="15" height="15"></a>
		<script>updateURL("ascLN", '<img border="0" style="float: middle" src="/WmART/images/arrow_up.gif" width="15" height="15">');</script>
            		<a id="desLN" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=LN&DES=true&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" src="/WmART/images/arrow_down.gif" style="float: middle" width="15" height="16"></a>
					<script>updateURL("desLN", '<img border="0" src="/WmART/images/arrow_down.gif" style="float: middle" width="15" height="16">');</script>
					%endif%</td>
        <td class="oddcol-l">Package Name%ifvar lt8%%else%<a id="ascPN" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=PN&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" style="float: middle" src="/WmART/images/arrow_up.gif" width="15" height="15"></a>
		<script>updateURL("ascPN", '<img border="0" style="float: middle" src="/WmART/images/arrow_up.gif" width="15" height="15">');</script>
            		<a id="desPN" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=PN&DES=true&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" src="/WmART/images/arrow_down.gif" style="float: middle" width="15" height="16"></a>
					<script>updateURL("desPN", '<img border="0" src="/WmART/images/arrow_down.gif" style="float: middle" width="15" height="16">');</script>
					%endif%</td>        
        <td class="oddcol">Enabled%ifvar lt8%%else%<a id="ascStatus" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=EN&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" style="float: middle" src="/WmART/images/arrow_up.gif" width="15" height="15"></a>
		<script>updateURL("ascStatus", '<img border="0" style="float: middle" src="/WmART/images/arrow_up.gif" width="15" height="15">');</script>
            		<a id="desStatus" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&sort=EN&DES=true&dspName=.LISTLISTENERNOTIFICATIONS"><img border="0" src="/WmART/images/arrow_down.gif" style="float: middle" width="15" height="16"></a>
					<script>updateURL("desStatus", '<img border="0" src="/WmART/images/arrow_down.gif" style="float: middle" width="15" height="16">');</script>
					%endif%</td>
    </tr>

    %comment% if we have notifications, loop over response, constructing output table %end%
    %ifvar notificationDataList -notempty%
        %loop notificationDataList%
            <tr>
            <script>writeTD('rowdata-l');</script>
            %value notificationNodeName% </td>
            <script>writeTD('rowdata-l');</script>
            %value packageName% </td>
            <script>writeTD('rowdata');</script>
            %switch notificationEnabled%
            %case 'yes'%
                <a id="listener_notification_status%value $index%" href="ListListenerNotifications.dsp?%ifvar ../lt8%lt8=true&amp;%endif%action=disableNotification&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&notificationEnabled=yes&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                ONCLICK="return confirmDisable('%value notificationNodeName%');">
                <img src="/WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes</a>
				<script>updateURL("listener_notification_status%value $index%", '<img src="../WmRoot/images/green_check.gif" height=13 width=13 alt="Enabled" border=0>Yes');</script>
				</td>
            %case 'no'%
                <a id="listener_notification_status%value $index%" href="ListListenerNotifications.dsp?%ifvar ../lt8%lt8=true&amp;%endif%action=enableNotification&notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                 ONCLICK="return confirmEnable('%value notificationNodeName%');">       
                 <img src="/WmRoot/images/blank.gif" border=0 alt="Disabled">No</a>
				 <script>updateURL("listener_notification_status%value $index%", '<img src="../WmRoot/images/blank.gif" border=0 alt="Disabled">No');</script>
				 </td>
            %case 'pending'%         
                <a id="listener_notification_status%value $index%" href="ListListenerNotifications.dsp?%ifvar ../lt8%lt8=true&amp;%endif%action=forceNotification&notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTLISTENERNOTIFICATIONS"
                 ONCLICK="return confirmForce('%value notificationNodeName%');">       
                 <img src="/WmRoot/images/blank.gif" border=0 alt="Pending disable">Pending disable</a>
				 <script>updateURL("listener_notification_status%value $index%", '<img src="../WmRoot/images/blank.gif" border=0 alt="Pending disable">Pending disable');</script>
				 </td>
            %endswitch%            
            </tr>
				%endloop%
    %else%
        <TR><TD colspan=3>No Listener Notifications found</TD></TR>
    %endif%
	</tbody>
	</table>
	</td>
	</tr>
    %onerror% 
            %ifvar localizedMessage%
                <tr><td class="message">Error encountered <pre>%value localizedMessage%</pre></td></tr>
            %else%
                %ifvar error%
                    <tr><td class="message">Error encountered <pre>%value errorMessage%</pre></td></tr>
                %endif%
            %endif%
    %endinvoke%
</table>
	%ifvar lt8%%else%<div class="oddrowdata" id="goContainer" name="goContainer" style="display:none;padding-top=2mm;">
        	%ifvar pStart equals('1')%
			<label style="color:#666666;font-weight:bold;text-align:inherit;">
			Page (1-<script>writeTD('rowdata-l');</script>%value pageSize% )</td></label>
		%else%		
        		<a id="listener_notification_page_previous" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&prev=true&dspName=.LISTLISTENERNOTIFICATIONS">« Previous</a>
				<script>updateURL("listener_notification_page_previous", "&laquo; Previous");</script>
				&nbsp;<label style="color:#666666;font-weight:bold;text-align:inherit;">Page (1-
				<script>writeTD('rowdata-l');</script>%value pageSize% )</label></td>
		%endif%	
			<input type="text" name="pageNumber" value="%value pStart%" size="1" onkeypress="return isNumberKey(this.form,event);">&nbsp;<input type="submit" name="Go" value="Go" onClick="jumpToPage(this);return false;">
			%ifvar pStart vequals(pageSize)%			
				<!-- Next -->
		%else%
			<a id="listener_notification_page_next" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&prev=false&dspName=.LISTLISTENERNOTIFICATIONS">Next »</a>
			<script>updateURL("listener_notification_page_next", "Next &raquo;");</script>
		%endif%		
	</div>
      
	<div class="oddrowdata" id="paginationContainer" name="paginationContainer" style="display:;padding-top=2mm;">

	%ifvar pStart equals('1')%
	%else%
		<a id="listener_notification_page_no_previous" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&prev=true&dspName=.LISTLISTENERNOTIFICATIONS">« Previous</a>   
		<script>updateURL("listener_notification_page_no_previous", "&laquo; Previous");</script>
	%endif%
	%loop totalNosOfPages%
		%ifvar totalNosOfPages -notempty%           		
		<a id="listener_notification_page_no_%value $index%" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&pageNumber=%value -urlencode totalNosOfPages%&dspName=.LISTLISTENERNOTIFICATIONS">
		%ifvar totalNosOfPages vequals(/pStart)% 
		<a>
		<script>updateURL("listener_notification_page_no_%value $index%", "");</script>
		<label style="color:#666666;font-weight:bold;">%value totalNosOfPages%</label>
	%else%
		%ifvar totalNosOfPages equals('...')%
			</a>
			<script>updateURL("listener_notification_page_no_%value $index%", "");</script>
			<a href="javascript:showHidePageCriteria()">%value totalNosOfPages%</a>
	%else%
		%value totalNosOfPages%<a>
		<script>updateURL("listener_notification_page_no_%value $index%", "%value totalNosOfPages%");</script>
		%endif%
		%endif%	
		%else%
		%value pStart%
	%endif%	
        %endloop%							
	%ifvar pStart vequals(pageSize)%			
		
	%else%
		<a id="listener_notification_page_no_next" href="ListListenerNotifications.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerNotificationName=%value -urlencode searchListenerNotificationName%&prev=false&dspName=.LISTLISTENERNOTIFICATIONS">Next »</a>
		<script>updateURL("listener_notification_page_no_next", "Next &raquo;");</script>
	%endif%		
	</div>
	<input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
	<input type="hidden" name="searchListenerNotificationName" value="%value searchListenerNotificationName%">     	
	<input type="hidden" name="pStart" value="%value pStart%">
	<input type="hidden" name="totalNosOfPages" value="%value totalNosOfPages%">
    	<input type="hidden" name="pageNumber" value="%value pageNumber%">
    	<input type="hidden" value="" name="sortCriteria">
    	<input type="hidden" name="pageSize" value="%value pageSize%">
    	<input type="hidden" value="%value pageLabel%" name="pageLabel">
</form>%endif%
</body>
</HTML>