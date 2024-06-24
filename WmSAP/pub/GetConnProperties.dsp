%comment%----- Displays Connection Parameters and Properties -----%endcomment%

<HTML> 
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <title>Connection Properties</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css"></LINK>
		<Link REL="stylesheet" TYPE="text/css" HREF="../WmART/webMethods.css"></LINK>
				
        <SCRIPT SRC="/WmRoot/webMethods.js"></SCRIPT>
        <script SRC="/WmART/artconnjs.txt"></script>
        <script src="sap.js"></script>
		<script type="text/javascript" src="/WmART/csrfGuard.js"></script>
    </head>
    
    <body onload="init();">
        <form name="form" action="ListResources.dsp" method="POST" onsubmit="enableAll(form);">
        %ifvar lt8%<input type="hidden" name="lt8" value="true">%endif%
		%ifvar ISVersionGTE equals('107')%<input type="hidden" name="ISVersionGTE" value="107">%endif%
        <input type="hidden" name="action" value="saveConnection">
        <input type="hidden" name="passwordChange" value="false">
        <input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">
        
     
        %invoke wm.art.admin:retrieveAdapterTypeData%
        %onerror%
        %endinvoke%
		
		%ifvar ISVersionGTE equals('107')%
			%ifvar test equals(true)%
				<INPUT NAME="test" TYPE="hidden" VALUE="true">
			%else%
				%ifvar test equals(completed)%
					<INPUT NAME="test" TYPE="hidden" VALUE="completed">
				%else%
					<INPUT NAME="test" TYPE="hidden" VALUE="false">
				%endif%
			%endif%
		%endif%
		
        <table width="100%">  
            <tr>
               <td class="breadcrumb" colspan=7>Adapters &gt; %value displayName% &gt; Configure Connection Type</td>
            </tr>
			
			%ifvar ISVersionGTE equals('107')%
				%ifvar test equals(true)%
				  %invoke wm.art.admin.connection:testResource% 
				  <SCRIPT>testSAPCompleted();</SCRIPT>
				  %ifvar message%
					<TR><TD class="message" colspan="8">%value message encode(html)%</TD></TR>
				  %else%
				  %endif%
				  %onerror%
					 %ifvar localizedMessage%
							<tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
						%else%
							%ifvar error%
								 <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
							%endif%
						%endif%				
				  %endinvoke%
				%endif%
			%endif%
			
            <tr>
                <td colspan=2>
                    <ul>
			%comment%----- LG TRAX 1-KX9WM Added dspName=.LISTCONNECTIONTYPES -----%endcomment%
                        <li><a id="Return_to_%value displayName%_Connection_Types" href="ListAdapterConnTypes.dsp?%ifvar lt8%lt8=true&amp;%endif%adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTCONNECTIONTYPES&ISVersionGTE=%value -urlencode ISVersionGTE%">Return to %value displayName% Connection Types</a>
						<script>updateURL("Return_to_%value displayName%_Connection_Types", "Return to %value displayName% Connection Types");</script>
						</li>
                    </ul>
                </td>
            </tr>
           
            <tr>
				<td>
				<table class="tableView" width="100%">
				<tbody>
				
				%ifvar ISVersionGTE equals('107')%
					%ifvar test equals(true)%
						%invoke wm.art.admin.connection:getResourceConfiguration%
							<tr>
								<td class="heading" colspan=2>Configure Connection Type &gt; %value displayName%</td>
							</tr>
							 <tr>
								%include ../../WmART/pub/GetISPackages.dsp%
								<script>swapRows();writeTD('row');</script>Folder Name</td>
								<script>writeTD('rowdata-l');</script>
								<input size=30 name="resourceFolderName" value="%value -urlencode resourceFolderName%"></input></td>
							</tr>
							
							%include EditConnectionProperties.dsp%       
							%include ../../WmART/pub/EditConnectionManagerProperties.dsp%					
						%onerror%
							<tr>
								<td class="heading" colspan=2>Configure Connection Type</td>
							</tr>
							  %ifvar localizedMessage%
								%comment%-- Localized error message supplied --%endcomment%
								<tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
							  %else%
								%ifvar error%
								  <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
								%endif%
							  %endif%
						%endinvoke%
					%else%
						%invoke wm.art.admin.connection:getConnectionProperties%
							<tr>
								<td class="heading" colspan=2>Configure Connection Type &gt; %value displayName%</td>
							</tr>
							%include DisplayConnectionProperties.dsp%         
						%onerror%
							<tr>
								<td class="heading" colspan=2>Configure Connection Type</td>
							</tr>
							  %ifvar localizedMessage%
								%comment%-- Localized error message supplied --%endcomment%
								<tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
							  %else%
								%ifvar error%
								  <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
								%endif%
							  %endif%
						%endinvoke%
						<tr>
							%comment%----------------------ConnectionManagerProperties--------------%endcomment%  
							%invoke wm.art.admin.connection:getConnectionManagerProperties% 
								%include ../../WmART/pub/DisplayConnectionManagerProperties.dsp% 
							%onerror%
								%ifvar localizedMessage%
									%comment%-- Localized error message supplied --%endcomment%
									<tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
								%else%
									%ifvar error%
										<tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
									%endif%
								%endif%
							%endinvoke%
						</tr>
					 %endif%
				%else%
					%invoke wm.art.admin.connection:getConnectionProperties%
						<tr>
							<td class="heading" colspan=2>Configure Connection Type &gt; %value displayName%</td>
						</tr>
						%include DisplayConnectionProperties.dsp%         
					%onerror%
						<tr>
							<td class="heading" colspan=2>Configure Connection Type</td>
						</tr>
						  %ifvar localizedMessage%
							%comment%-- Localized error message supplied --%endcomment%
							<tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
						  %else%
							%ifvar error%
							  <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
							%endif%
						  %endif%
					%endinvoke%
					<tr>
						%comment%----------------------ConnectionManagerProperties--------------%endcomment%  
						%invoke wm.art.admin.connection:getConnectionManagerProperties% 
							%include ../../WmART/pub/DisplayConnectionManagerProperties.dsp% 
						%onerror%
							%ifvar localizedMessage%
								%comment%-- Localized error message supplied --%endcomment%
								<tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
							%else%
								%ifvar error%
									<tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
								%endif%
							%endif%
						%endinvoke%
					</tr>
				%endif%
				
			</tr>
			</tbody>
			</table>
			</td>
			</tr>
        </table>
    
        <table width=100%>
        <td class="action" colspan="2">
            
			%ifvar ISVersionGTE equals('107')%
				<input type="submit" name="SUBMIT" value="Save Connection"  onclick="return validateSAPConnectionForm(this.form)"></input>
				<input type="submit" name="TEST" value="Test Connection" onClick="return testSAPConnection('GetConnProperties.dsp');" />
				<input type="hidden" name="resourceName" value=""></input>
			%else%
				<input type="submit" name="SUBMIT" value="Save Connection"  onclick="return validateForm(this.form)"></input>
			%endif%			
            <input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
            <input type="hidden" name="connectionFactoryType" value="%value connectionFactoryType%"> 
        </td>    
        </tr>
        </table>
		
	</tbody>
	</table>
	</td>
	</tr>	
        </form>    
    </body>
</html>
