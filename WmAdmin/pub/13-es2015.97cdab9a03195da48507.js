(window.webpackJsonp=window.webpackJsonp||[]).push([[13],{Kj7K:function(e,t,s){"use strict";s.r(t),s.d(t,"QuiesceReportModule",function(){return C});var i=s("SVse"),n=s("iInd"),c=s("D3+B"),r=s("8Y7J"),o=s("TSSN"),a=s("GX/v"),d=s("ZRSf"),p=s("hhfa");function g(e,t){1&e&&(r.dc(0),r.bd(1),r.uc(2,"translate"),r.cc()),2&e&&(r.Lb(1),r.dd(" ",r.vc(2,1,"masthead.settings.quiesce.entering.msg")," "))}function l(e,t){1&e&&(r.dc(0),r.bd(1),r.uc(2,"translate"),r.cc()),2&e&&(r.Lb(1),r.dd(" ",r.vc(2,1,"masthead.settings.quiesce.exiting.msg")," "))}function h(e,t){if(1&e&&(r.dc(0),r.ac(1,"ac-loader"),r.fc(2,"div",12),r.Zc(3,g,3,3,"ng-container",11),r.Zc(4,l,3,3,"ng-container",11),r.ec(),r.cc()),2&e){const e=r.tc();r.Lb(3),r.Ac("ngIf","enter"===e.mode),r.Lb(1),r.Ac("ngIf","exit"===e.mode)}}function u(e,t){if(1&e&&(r.fc(0,"li"),r.bd(1),r.ec()),2&e){const e=t.$implicit;r.Lb(1),r.dd(" ",e," ")}}function f(e,t){if(1&e&&(r.dc(0),r.fc(1,"h5"),r.fc(2,"ul"),r.Zc(3,u,2,1,"li",14),r.ec(),r.ec(),r.cc()),2&e){const e=r.tc(2);r.Lb(3),r.Ac("ngForOf",e.quiesceErrorSuggestions)}}function b(e,t){1&e&&(r.fc(0,"tr"),r.fc(1,"th",20),r.uc(2,"translate"),r.bd(3),r.uc(4,"translate"),r.ec(),r.fc(5,"th",21),r.uc(6,"translate"),r.bd(7),r.uc(8,"translate"),r.ec(),r.fc(9,"th",22),r.uc(10,"translate"),r.bd(11),r.uc(12,"translate"),r.ec(),r.ec()),2&e&&(r.Lb(1),r.Bc("pTooltip",r.vc(2,6,"masthead.settings.quiesce.report.type.header")),r.Lb(2),r.dd(" ",r.vc(4,8,"masthead.settings.quiesce.report.type.header")," "),r.Lb(2),r.Bc("pTooltip",r.vc(6,10,"masthead.settings.quiesce.report.status.header")),r.Lb(2),r.dd(" ",r.vc(8,12,"masthead.settings.quiesce.report.status.header")," "),r.Lb(2),r.Bc("pTooltip",r.vc(10,14,"masthead.settings.quiesce.report.message.header")),r.Lb(2),r.dd(" ",r.vc(12,16,"masthead.settings.quiesce.report.message.header")," "))}function m(e,t){if(1&e&&(r.fc(0,"tr"),r.fc(1,"td",20),r.fc(2,"div",23),r.bd(3),r.ec(),r.ec(),r.fc(4,"td",21),r.fc(5,"div",23),r.bd(6),r.ec(),r.ec(),r.fc(7,"td",22),r.fc(8,"div",23),r.bd(9),r.ec(),r.ec(),r.ec()),2&e){const e=t.$implicit;r.Lb(1),r.Bc("pTooltip",e.type),r.Lb(2),r.cd(e.type),r.Lb(1),r.Bc("pTooltip",e.status),r.Lb(2),r.cd(e.status),r.Lb(1),r.Bc("pTooltip",e.message),r.Lb(2),r.cd(e.message)}}function w(e,t){if(1&e&&(r.dc(0),r.fc(1,"div",15),r.fc(2,"div",16),r.fc(3,"p-table",17),r.Zc(4,b,13,18,"ng-template",18),r.Zc(5,m,10,6,"ng-template",19),r.ec(),r.ec(),r.ec(),r.cc()),2&e){const e=r.tc(2);r.Lb(3),r.Ac("columns",e.rptCols)("value",e.quiesceResponse.report)("scrollable",!1)}}function v(e,t){if(1&e&&(r.dc(0),r.fc(1,"div",13),r.fc(2,"h3"),r.bd(3),r.ec(),r.ec(),r.Zc(4,f,4,1,"ng-container",11),r.Zc(5,w,6,3,"ng-container",11),r.cc()),2&e){const e=r.tc();r.Lb(3),r.cd(e.quiesceResponse.message),r.Lb(1),r.Ac("ngIf",e.quiesceErrorSuggestions),r.Lb(1),r.Ac("ngIf",!e.errorOccurred)}}const M=function(e){return{pageTitle:e}},O=[{path:"",component:(()=>{class e{constructor(e,t,s,i,n){this.mastHeadService=e,this.route=t,this.translate=s,this.router=i,this.sharedMessageService=n,this.homeLink="#/integration/dashboard/overview",this.quiesceReportHelp="WmRoot/doc/OnlineHelp/index.html#page/is-onlinehelp%2FIS_Server_EnterExitQuiesceModeScrn.html%23",this.fetchingQuiesceReport=!1,this.isQuiesceMode=!1,this.errorOccurred=!1,t.params.subscribe(e=>{this.translate.setDefaultLang("en"),this.subscription=this.sharedMessageService.getMessage().subscribe(e=>{e&&"change-locale"===e.data.action&&this.translate.use(e.data.data.locale)})}),t.queryParams.subscribe(e=>this.queryParamChange(e.mode,e.timeout))}queryParamChange(e,t){this.mode===e&&this.maxMinutesWaitPkgDisable===t||(this.mode=e,this.maxMinutesWaitPkgDisable=t,this.fetchingQuiesceReport=!0,"enter"===this.mode?this.enterQuiesceMode():"exit"===this.mode&&this.exitQuiesceMode())}enterQuiesceMode(){this.pageTitle=this.translate.instant("masthead.settings.quiesce.report.title"),this.quiesceErrorSuggestions=null,this.mastHeadService.enterQuiesceMode(this.maxMinutesWaitPkgDisable.toString()).subscribe(e=>{this.errorOccurred=!0,e&&(this.quiesceResponse=e,(e.status&&"1"===e.status&&"INVALID"===e.message||"ISS.0030.0229"===e.status)&&(this.quiesceResponse.message=this.translate.instant("masthead.settings.quiesce.port.error.msg"),this.quiesceErrorSuggestions=[this.translate.instant("masthead.settings.quiesce.port.error.suggestion.1"),this.translate.instant("masthead.settings.quiesce.port.error.suggestion.2"),this.translate.instant("masthead.settings.quiesce.port.error.suggestion.3"),this.translate.instant("masthead.settings.quiesce.port.error.suggestion.4")])),e&&e.message&&e.report&&e.report.length>0&&(this.mastHeadService.changeMode("QUIESCE"),this.errorOccurred=!1),this.fetchingQuiesceReport=!1})}exitQuiesceMode(){this.pageTitle=this.translate.instant("masthead.settings.quiesce.report.title"),this.quiesceErrorSuggestions=null,this.mastHeadService.exitQuiesceMode().subscribe(e=>{this.errorOccurred=!0,e&&(this.quiesceResponse=e),e&&e.message&&e.report&&e.report.length>0&&(this.mastHeadService.changeMode("ACTIVE"),this.errorOccurred=!1),this.fetchingQuiesceReport=!1})}goToHomePage(){this.router.navigateByUrl(this.homeLink)}showHelp(){const e=c.K.getISBaseUrl()+"/"+this.quiesceReportHelp;window.open(e,e)}ngOnDestroy(){this.subscription.unsubscribe()}}return e.\u0275fac=function(t){return new(t||e)(r.Zb(c.q),r.Zb(n.a),r.Zb(o.d),r.Zb(n.f),r.Zb(c.B))},e.\u0275cmp=r.Tb({type:e,selectors:[["quiesce-report"]],inputs:{mode:"mode"},decls:24,vars:21,consts:[[1,"breadcrumbs-container"],["aria-label","breadcrumb",1,"dlt-breadcrumbs"],["routerLink","/integration/dashboard/overview","tabindex","0",1,"dlt-links"],["aria-current","page",1,"dlt-links"],[1,"quiesce-container"],[1,"dlg-title-wrapper"],["width","100%","role","presentation"],[1,"page-title","padding-top"],[1,"padding-top"],["tabindex","0","showDelay","250",1,"help1",3,"pTooltip","click"],["src","assets/images/dlt-icon-help.svg","width","22","height","22",3,"alt"],[4,"ngIf"],[1,"loading-message"],[1,"msg"],[4,"ngFor","ngForOf"],[1,"dlt-data-table-container"],[1,"dlt-table-wrapper"],[3,"columns","value","scrollable"],["pTemplate","header"],["pTemplate","body"],["showDelay","250","tooltipPosition","top",1,"t30pct",3,"pTooltip"],["showDelay","250","tooltipPosition","top",1,"t10pct",3,"pTooltip"],["showDelay","250","tooltipPosition","top",1,"t60pct",3,"pTooltip"],[1,"wrap"]],template:function(e,t){1&e&&(r.fc(0,"div",0),r.fc(1,"ol",1),r.fc(2,"li"),r.fc(3,"a",2),r.bd(4),r.uc(5,"translate"),r.ec(),r.ec(),r.fc(6,"li"),r.fc(7,"a",3),r.bd(8),r.uc(9,"translate"),r.ec(),r.ec(),r.ec(),r.ec(),r.fc(10,"div",4),r.fc(11,"div",5),r.fc(12,"table",6),r.fc(13,"tr"),r.fc(14,"td",7),r.fc(15,"h1"),r.bd(16),r.ec(),r.ec(),r.fc(17,"td",8),r.fc(18,"button",9),r.pc("click",function(){return t.showHelp()}),r.uc(19,"translate"),r.ac(20,"img",10),r.uc(21,"translate"),r.ec(),r.ec(),r.ec(),r.ec(),r.ec(),r.Zc(22,h,5,2,"ng-container",11),r.Zc(23,v,6,3,"ng-container",11),r.ec()),2&e&&(r.Lb(4),r.cd(r.vc(5,7,"masthead.administration")),r.Lb(4),r.cd(r.vc(9,9,"masthead.settings.quiesce.report.title")),r.Lb(8),r.cd(t.pageTitle),r.Lb(2),r.Bc("pTooltip",r.wc(19,11,"dsp.help",r.Gc(17,M,t.pageTitle))),r.Lb(2),r.Bc("alt",r.wc(21,14,"dsp.help",r.Gc(19,M,t.pageTitle))),r.Lb(2),r.Ac("ngIf",t.fetchingQuiesceReport),r.Lb(1),r.Ac("ngIf",t.quiesceResponse))},directives:[n.i,a.a,i.o,i.n,d.h,p.j],pipes:[o.c],styles:[".break-column[_ngcontent-%COMP%]{word-wrap:break-word;width:100%}td[_ngcontent-%COMP%], th[_ngcontent-%COMP%]{color:#000;font-family:Roboto,Helvetica,Arial,sans-serif;font-size:16px;padding:4px;text-align:left}td[_ngcontent-%COMP%]{word-break:break-all}th.t10pct[_ngcontent-%COMP%]{width:10%}th.t10pct[_ngcontent-%COMP%], th.t30pct[_ngcontent-%COMP%]{font-size:16px;word-break:break-all}th.t30pct[_ngcontent-%COMP%]{width:30%}th.t60pct[_ngcontent-%COMP%]{width:60%;font-size:16px;word-wrap:break-word}td.t10pct[_ngcontent-%COMP%]{width:10%}td.t10pct[_ngcontent-%COMP%], td.t30pct[_ngcontent-%COMP%]{font-size:16px;word-break:break-all}td.t30pct[_ngcontent-%COMP%]{width:30%}td.t60pct[_ngcontent-%COMP%]{width:60%}div.wrap[_ngcontent-%COMP%], td.t60pct[_ngcontent-%COMP%]{font-size:16px;word-wrap:break-word}div.wrap[_ngcontent-%COMP%]{text-overflow:ellipsis;overflow:hidden}.quiesce-container[_ngcontent-%COMP%]{width:100%;height:calc(100vh - 24px - 40px - 40px);padding:1rem;overflow-x:hidden;overflow-y:auto}.breadcrumbs-container[_ngcontent-%COMP%]{padding-top:.74rem;padding-left:.08rem}.rightSideFixedcontainer[_ngcontent-%COMP%]{padding-top:.74rem;margin-right:25px}.page-title[_ngcontent-%COMP%]{font-size:16px;line-height:1.5rem;font-weight:500;width:100%;font-family:Roboto,Helvetica,Arial,sans-serif}.padding-top[_ngcontent-%COMP%], .page-title[_ngcontent-%COMP%]{padding-top:1.07rem}.msg[_ngcontent-%COMP%]{padding-left:1rem}.report-message[_ngcontent-%COMP%]{padding-left:1.16rem}.report-message[_ngcontent-%COMP%], .report-suggestions[_ngcontent-%COMP%]{font-size:16px;line-height:1.5rem;font-weight:500;width:100%;padding-top:1.07rem;font-family:Roboto,Helvetica,Arial,sans-serif}.loading-message[_ngcontent-%COMP%], .report-suggestions[_ngcontent-%COMP%]{padding-left:2rem}.loading-message[_ngcontent-%COMP%]{font-size:16px;line-height:1.5rem;text-align:center;width:100%;padding-top:1.07rem;font-family:Roboto,Helvetica,Arial,sans-serif}"]}),e})()}];let P=(()=>{class e{}return e.\u0275fac=function(t){return new(t||e)},e.\u0275mod=r.Xb({type:e}),e.\u0275inj=r.Wb({imports:[[n.j.forChild(O)],n.j]}),e})();var q=s("2ilO");let C=(()=>{class e{}return e.\u0275fac=function(t){return new(t||e)},e.\u0275mod=r.Xb({type:e}),e.\u0275inj=r.Wb({imports:[[i.c,d.k,P,o.b,q.a]]}),e})()}}]);