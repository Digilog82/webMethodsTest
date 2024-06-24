<html>
  %invoke wm.art.admin:retrieveAdapterTypeData%
  <head>
    <title>SAP - Lookup</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="../WmRoot/webMethods.css"></link>
    <link rel="stylesheet" type="text/css" href="../WmART/webMethods.css"></link>
	
    <script type="text/javascript" src="/WmRoot/webMethods.js"></script>
	<script type="text/javascript" src="/WmART/csrfGuard.js"></script>
    <!-- %invoke wm.sap.Bapi:getBAPIDefinition% -->
    <!-- %ifvar errorMessage% -->
    <meta http-equiv="refresh" content="5;url=lookupBO.dsp?systemId=%value /systemId%&amp;internalName=%value /defObjectTypeName%"></meta>
  </head>
  <body>
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup &gt; BAPI &gt; Error
	</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a id="return_to_lookup1" href="lookup.dsp">Return to Lookup</a><script>updateURL("return_to_lookup1", "Return to Lookup");</script></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table width="80%" class="tableView">
	    <tr>
	      <td class="subHeading">%value errorMessage%</td>
	    </tr>
	    <tr>
	      <td class="oddrowdata-l">
		BAPI
		%ifvar /defObjectName -notempty%%value /defObjectName%.%endif%%value /bapiName%
		not found. Check <a id="overview_page" href="lookupBO.dsp?systemId=%value -urlencode /systemId%&amp;internalName=%value -urlencode /defObjectTypeName%">%value /defObjectName% overview page</a>.
		<script>updateURL("overview_page", "%value /defObjectName% overview page");</script>
	      </td>
	    </tr>
	  </table>
	</td>
      </tr>
    </table>
  </body>
  <!-- %else% -->
  </head>
  <body onLoad="setNavigation('/WmSAP/lookup.dsp', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LP_BAPI', 'foo');">
    <table width="100%">
      <tr>
	<td class="breadcrumb" colspan="2">Adapters &gt; webMethods Adapter for SAP &gt; Lookup
	  &gt; BAPI
	</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a id="return_to_lookup2" href="lookup.dsp?adapterTypeName=WmSAP&amp;systemId=%value -urlencode systemId%&amp;objectName=%value -urlencode defObjectName%">Return to Lookup</a>
		<script>updateURL("return_to_lookup2", "Return to Lookup");</script>
		</li>
	    <li><a id="return_to_bo%value defObjectName%" href="lookupBO.dsp?systemId=%value -urlencode systemId%&amp;internalName=%value -urlencode defObjectTypeName%&amp;bapiName=%value -urlencode bapiName%">Return to Business Object %value defObjectName%</a>
		<script>updateURL("return_to_bo%value defObjectName%", "Return to Business Object %value defObjectName%");</script>
		</li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <thead>
	      <tr>
		<td class="subheading2" colspan="2">BAPI %value defObjectName%.%value bapiName%</td>
	      </tr>
	      <tr>
		<td class="oddrow">Static method</td>
		<td class="oddrowdata-l">%value isStatic%</td>
	      </tr>
	      <tr>
		<td class="evenrow">Dialog method</td>
		<td class="evenrowdata-l">%value isDialog%</td>
	      </tr>
	      <tr>
		<td class="oddrow">Factory method</td>
		<td class="oddrowdata-l">%value isFactory%</td>
	      </tr>
	      <tr>
		<td class="evenrow">Function module</td>
		<td class="evenrowdata-l">%value functionName%</td>
	      </tr>
	      <!-- %ifvar messageType% -->
	      <tr>
		<td class="oddrow">ALE message type</td>
		<td class="oddrowdata-l">%value messageType%</td>
	      </tr>
	      <!-- %endif% -->
	      <tr>
		<td class="subHeading" colspan="2">Parameters</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop parameterNames% -->
	      <tr>
		<td class="evenrowdata-l" colspan="2">
		  <a id="parameter_%value%" href="lookupBOParameter.dsp?systemId=%value -urlencode systemId%&amp;defObjectTypeName=%value -urlencode defObjectTypeName%&amp;defObjectName=%value -urlencode defObjectName%&amp;bapiName=%value -urlencode bapiName%&amp;parameterName=%value -urlencode%">%value%</a>
		  <script>updateURL("parameter_%value%", "%value%");</script>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
	    <tbody>
	      <tr>
		<td class="action" colspan="2">
		  <form action="lookupBOCreateTemplate.dsp" method="post">
		    <input type="hidden" name="objectName" value="%value defObjectName%"></input>
		    <input type="hidden" name="bapiName" value="%value bapiName%"></input>
		    <input type="hidden" name="systemId" value="%value systemId%"></input>
		    <input class="button2" type="submit" value="Create XML template"></input>
		  </form>
		</td>
	      </tr>
	    </tbody>
	  </table>
	  <script>swapColor('tbodyNode', false);</script>
	</td>
      </tr>
    </table>
  </body>
  <!-- %endif% -->
  <!-- %endinvoke% -->
</html>