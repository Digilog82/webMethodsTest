%invoke JSocketAdapter.COMMON.UTIL.FLOW:createStringKeyIv%

<html>
	<body>
		<form name="kform" method="post" action="socket-iframe.dsp">
			<input type="hidden" name="alg" value="">
		</form>
		
		%ifvar sk equals('')%
		
		%else%
			<script language="javascript">
				parent.setChangedKeyIv('%value sk%', '%value sk24%', '%value sk32%', '%value iv%');
			</script>
		%endifvar%
	</body>
</html>