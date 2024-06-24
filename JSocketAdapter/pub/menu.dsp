<html>
<head>
<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="Expires" content="-1">
<script src="/WmRoot/common-menu.js"></script>
<script src="/WmRoot/csrf-guard.js"></script>
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
//Action on TAB key
function checkTabPress(e) {
    'use strict';
    var ele = document.activeElement;
	if (e.shiftKey) {
		return;
	}
    if (e.keyCode === 9 && ele.nodeName.toLowerCase() === 'a') {
		//var pNode = ele.parentNode.parentNode.parentNode.previousElementSibling;
		var pNode = ele.parentNode.parentNode;
		//alert(pNode);
		if (pNode.getAttribute('manualhide') == 'true') {
			var id = pNode.getAttribute('id').concat('_subMenu');
			//alert(id);
			var imgId = pNode.getAttribute('id').concat('_twistie');
			//alert(imgId);
			toggle(pNode, id, imgId);
			var nextEl = findNextTabStop(ele);
			nextEl.focus();
		}
		if (pNode.getAttribute('manualhide') == 'false') {
			var nextEl = findNextTabStop(ele);
			nextEl.focus();
		}
    }
}

//Action on SHIFT-TAB key
function checkShiftTabPress(e) {
    'use strict';
    var ele = document.activeElement;
    if (e.shiftKey && e.keyCode === 9 && ele.nodeName.toLowerCase() === 'a') {
		var pNode = ele.parentNode.parentNode;
		//alert(pNode.getAttribute('id').concat('_subMenu'));
		
		if (pNode.getAttribute('manualhide') == 'true' || pNode.getAttribute('manualhide') == 'false') {
			var id = pNode.getAttribute('id').concat('_subMenu');
			//alert(id);
			var imgId = pNode.getAttribute('id').concat('_twistie');
			//alert(imgId);
			toggle(pNode, id, imgId);
			var prevEl = findPreviousTabStop(ele);
			prevEl.focus();
		}
    }
}
//Add an event listener for Tab key
document.addEventListener('keyup', function (e) {
    checkTabPress(e);
}, false);

//Add an event listener for Shift Tab key
document.addEventListener('keyup', function (e) {
    checkShiftTabPress(e);
}, false);

//Find the next TAB stop
function findNextTabStop(el) {
    var universe = document.querySelectorAll('a[href]');
    var list = Array.prototype.filter.call(universe, function(item) {return item.tabIndex >= "0"});
    var index = list.indexOf(el);
    return list[index + 1] || list[0];
  }

//Find the previous TAB stop  
function findPreviousTabStop(el) {
    var universe = document.querySelectorAll('a[href]');
    var list = Array.prototype.filter.call(universe, function(item) {return item.tabIndex >= "0"});
    var index = list.indexOf(el);
    return list[index - 1] || list[0];
  }
</script>
</head>

%invoke JSocketAdapter.ADMIN:getMainMenu%
<body class="menu" onload="initMenu('%value buttonUrls/sections[0]/submenu[0]/url encode(javascript)%');">
<table class="menuTable" width="100%" cellspacing="0" cellpadding="0" border="0" id="mTable">

%scope buttonUrls%
%loop sections%
    %ifvar name equals('hide')%
    %else%
        %scope param(truestr='true') param(falsestr='false') param(expanded='false')%
            %rename ../name name -copy%
            %rename ../text text -copy%
            %ifvar text equals('Basic Info')%
                %rename truestr expanded -copy%
            %endif%
            %include ../../WmRoot/pub/menu-section.dsp%
        %endscope%
    %endif%

    %loop submenu%
        %ifvar url -notempty%
            %scope param(tablerow='table-row') param(display='none') param(class='menuitem-selected') param(className='xyz')%
                %rename ../../text section -copy%
                %rename ../text text -copy%
                %rename ../url url -copy%
                %rename ../target target -copy%
                %ifvar section equals('Basic Info')%
                    %rename tablerow display -copy%
                    %ifvar url equals('basic-about.dsp')%
                        %rename class className -copy%
                    %endif%
                %endif%
                %include ../../WmRoot/pub/menu-subelement.dsp%
            %endscope%
        %endif%
    %endloop%
%endloop%
%endscope%

</table>

<script>menuSelect('', 'basic-about.dsp')</script>
<script>
document.getElementsByClassName("menusection-BasicInfo")[0].style.color="#ffffff";
</script>
</body>
</html>