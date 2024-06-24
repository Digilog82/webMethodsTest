<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>WmSAP - Mapping</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    
    <script type="text/javascript" src="/WmRoot/webMethods.js"></script>
	<script type="text/javascript" src="/WmART/csrfGuard.js"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/cbr.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_RG_TYP', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; %value displayName% &gt; Routing/Mapping &gt; Types</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a id="Return_to_Routing_Mapping_Settings" href="cbr.dsp?adapterTypeName=WmSAP">Return to Routing Mapping Settings</a>
		<script>updateURL("Return_to_Routing_Mapping_Settings", "Return to Routing Mapping Settings");</script>
		</li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView" width="95%">
	    <tr>
	      <td class="subheading2" colspan="2">Routing/Mapping Types</td>
	    </tr>
	    <tr>
	      <td class="oddcol">Routing/Mapping Type</td>
	      <td class="oddcol">Description</td>
	    </tr>
	    <tr>
	      <td class="evenrow-l"><a id="ALE_Routing_Info_Default" 
				       href="cbrRegister.dsp?adapterTypeName=WmSAP&amp;isInbound=true&amp;msgType=$default&amp;action=%value action%">ALE&nbsp;Routing&nbsp;Info&nbsp;Default</a>
					   <script>updateURL("ALE_Routing_Info_Default", "ALE&nbsp;Routing&nbsp;Info&nbsp;Default");</script>
	      </td>
	      <td class="evenrow-l">Allows to
		%ifvar action equals('Unregister')%un%endif%register an user exit
		service that will be called for all incoming IDocs to extract
		sender|receiver|msgType from the IDoc.
	      </td>
	    </tr>
	    <tr>
	      <td class="oddrow-l"><a id="ALE_Routing_Info" href="cbrRegister.dsp?adapterTypeName=WmSAP&amp;isInbound=true&amp;action=%value action%">ALE&nbsp;Routing&nbsp;Info</a>
		  <script>updateURL("ALE_Routing_Info", "ALE&nbsp;Routing&nbsp;Info");</script>
	      </td>
	      <td class="oddrow-l">Allows to
		%ifvar action equals('Unregister')%un%endif%register a message
		type dependent user exit service that will be called for all incoming IDocs of this message
		type. This service will be called after the default
		service, if existing, to further manipulate fields sender|receiver|msgType.
	      </td>
	    </tr>
	    <tr>
	      <td class="evenrow-l"><a id="ALE_Mapping_Info_Default" href="cbrRegister.dsp?adapterTypeName=WmSAP&amp;isInbound=false&amp;msgType=$default&amp;action=%value action%">ALE&nbsp;Mapping&nbsp;Info&nbsp;Default</a>
		  <script>updateURL("ALE_Mapping_Info_Default", "ALE&nbsp;Mapping&nbsp;Info&nbsp;Default");</script>
	      </td>
	      <td class="evenrow-l">Allows to
		%ifvar action equals('Unregister')%un%endif%register an user exit
		service that will be called for all outgoing IDocs.
	      </td>
	    </tr>
	    <tr>
	      <td class="oddrow-l"><a id="ALE_Mapping_Info" href="cbrRegister.dsp?adapterTypeName=WmSAP&amp;isInbound=false&amp;action=%value action%">ALE&nbsp;Mapping&nbsp;Info</a>
		  <script>updateURL("ALE_Mapping_Info", "ALE&nbsp;Mapping&nbsp;Info");</script>
	      </td>
	      <td class="oddrow-l">Allows to
		%ifvar action equals('Unregister')%un%endif%register a message type
		dependent user exit service that will be called for all outgoing IDocs of this message type.
	      </td>
	    </tr>
	    <tr>
	      <td class="evenrow-l"><a id="XML_Routing_Info" href="cbrRegister.dsp?adapterTypeName=WmSAP&amp;isInbound=true&amp;msgType=$xml&amp;action=%value action%">XML&nbsp;Routing&nbsp;Info</a>
		  <script>updateURL("XML_Routing_Info", "XML&nbsp;Routing&nbsp;Info");</script>
	      </td>
	      <td class="evenrow-l">Allows to
		%ifvar action equals('Unregister')%un%endif%register an user exit
		service that will be called for all incoming XML
		documents received via service
		"pub.sap.transport.XML:InboundProcess" to extract fields
		sender|receiver|msgType from the document.
	      </td>
	    </tr>
	  </table>
	</td>
      </tr>
    </table>
  </body>
</html>
