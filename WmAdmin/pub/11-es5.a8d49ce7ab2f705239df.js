!function(){function e(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}function t(e,t){for(var a=0;a<t.length;a++){var n=t[a];n.enumerable=n.enumerable||!1,n.configurable=!0,"value"in n&&(n.writable=!0),Object.defineProperty(e,(i=n.key,r=void 0,"symbol"==typeof(r=function(e,t){if("object"!=typeof e||null===e)return e;var a=e[Symbol.toPrimitive];if(void 0!==a){var n=a.call(e,t||"default");if("object"!=typeof n)return n;throw new TypeError("@@toPrimitive must return a primitive value.")}return("string"===t?String:Number)(e)}(i,"string"))?r:String(r)),n)}var i,r}function a(e,a,n){return a&&t(e.prototype,a),n&&t(e,n),Object.defineProperty(e,"prototype",{writable:!1}),e}(window.webpackJsonp=window.webpackJsonp||[]).push([[11],{"0cCp":function(t,n,i){"use strict";i.r(n),i.d(n,"PackagesUpdatesModule",function(){return S}),i.d(n,"createTranslateLoader",function(){return U});var r=i("IheW"),c=i("SVse"),o=i("iInd"),s=i("D3+B"),d=i("8Y7J"),u=i("TSSN"),l=i("s7LF"),f=["packagesAndUpdatesForm"];function p(e,t){if(1&e&&(d.fc(0,"form",12,13),d.ac(2,"input",14),d.ac(3,"input",15),d.ac(4,"input",16),d.ac(5,"input",17),d.ec()),2&e){var a=d.tc();d.Bc("action",a.packagesUpdatesUrl,d.Uc),d.Lb(2),d.Bc("value",a.wmSecureCSRFToken)}}function m(e,t){if(1&e&&(d.fc(0,"div",18),d.ac(1,"iframe",19,20),d.uc(3,"translate"),d.uc(4,"safeUrl"),d.ec()),2&e){var a=d.tc();d.Lb(1),d.Bc("title",d.vc(3,2,"about.server.packages.updates.title")),d.Ac("src",d.vc(4,4,a.packagesUpdatesUrl),d.Tc)}}function g(e,t){1&e&&(d.fc(0,"div",18),d.ac(1,"iframe",21,20),d.uc(3,"translate"),d.ec()),2&e&&(d.Lb(1),d.Bc("title",d.vc(3,1,"about.server.packages.updates.title")))}var b,h,v,k=[{path:"",component:(b=function(){function t(a,n,i,r,c){var o=this;e(this,t),this.route=a,this.translate=n,this.router=i,this.sharedMessageService=r,this.wmSecureCSRFToken="",this.csrfEnabled=!1,this.homeLink="#/integration/dashboard/overview",this.authService=c;var d=s.K.getISBaseUrl();d.indexOf("WmAdmin/")>0?d=d.replace("WmAdmin/","WmRoot/"):d.endsWith("WmAdmin")&&(d=d.replace("WmAdmin","WmRoot")+"/"),d.indexOf("WmRoot")<0&&(d+="/WmRoot/"),this.packagesUpdatesUrl=d+"updates.dsp?webMethods-wM-AdminUI=true",a.params.subscribe(function(e){o.translate.setDefaultLang("en"),o.subscription=o.sharedMessageService.getMessage().subscribe(function(e){e&&"change-locale"===e.data.action&&o.translate.use(e.data.data.locale)})})}return a(t,[{key:"ngOnInit",value:function(){this.csrfEnabled=!1;var e=this.authService.getCSRFToken();e&&(this.csrfEnabled=!0,this.wmSecureCSRFToken=e)}},{key:"ngAfterViewInit",value:function(){this.packagesAndUpdatesForm&&!0===this.csrfEnabled&&this.packagesAndUpdatesForm.nativeElement.submit()}},{key:"goToHomePage",value:function(){this.router.navigateByUrl(this.homeLink)}},{key:"ngOnDestroy",value:function(){this.subscription.unsubscribe()}}]),t}(),b.\u0275fac=function(e){return new(e||b)(d.Zb(o.a),d.Zb(u.d),d.Zb(o.f),d.Zb(s.B),d.Zb(s.d))},b.\u0275cmp=d.Tb({type:b,selectors:[["packages-updates"]],viewQuery:function(e,t){var a;1&e&&d.hd(f,1),2&e&&d.Oc(a=d.qc())&&(t.packagesAndUpdatesForm=a.first)},inputs:{mode:"mode"},decls:26,vars:15,consts:[["method","POST","target","packagesAndUpdatesFrame",3,"action",4,"ngIf"],[1,"breadcrumbs-container"],["aria-label","breadcrumb",1,"dlt-breadcrumbs"],["routerLink","/integration/dashboard/overview","tabindex","0",1,"dlt-links"],["routerLink","/about","tabindex","0",1,"dlt-links"],["aria-current","page",1,"dlt-links"],[1,"packages-updates-container"],[1,"titleContainer"],[1,"dlg-title-wrapper"],["width","100%","role","presentation"],[1,"page-title"],["class","iframecontainer",4,"ngIf"],["method","POST","target","packagesAndUpdatesFrame",3,"action"],["packagesAndUpdatesForm",""],["type","hidden","name","secureCSRFToken",3,"value"],["type","hidden","name","webMethods-wM-AdminUI","value","true"],["type","hidden","name","name","value","htmlform_updates"],["type","hidden","name","id","value","htmlform_updates"],[1,"iframecontainer"],["name","packagesAndUpdatesFrame","width","100%","height","100%","frameborder","0",3,"title","src"],["packagesAndUpdatesFrame",""],["name","packagesAndUpdatesFrame","width","100%","height","100%","frameborder","0",3,"title"]],template:function(e,t){1&e&&(d.Zc(0,p,6,2,"form",0),d.fc(1,"div",1),d.fc(2,"ol",2),d.fc(3,"li"),d.fc(4,"a",3),d.bd(5),d.uc(6,"translate"),d.ec(),d.ec(),d.fc(7,"li"),d.fc(8,"a",4),d.bd(9),d.uc(10,"translate"),d.ec(),d.ec(),d.fc(11,"li"),d.fc(12,"a",5),d.bd(13),d.uc(14,"translate"),d.ec(),d.ec(),d.ec(),d.ec(),d.fc(15,"div",6),d.fc(16,"div",7),d.fc(17,"div",8),d.fc(18,"table",9),d.fc(19,"tr"),d.fc(20,"td",10),d.fc(21,"h1"),d.bd(22),d.uc(23,"translate"),d.ec(),d.ec(),d.ec(),d.ec(),d.ec(),d.ec(),d.Zc(24,m,5,6,"div",11),d.Zc(25,g,4,3,"div",11),d.ec()),2&e&&(d.Ac("ngIf",!0===t.csrfEnabled),d.Lb(5),d.cd(d.vc(6,7,"masthead.administration")),d.Lb(4),d.cd(d.vc(10,9,"masthead.profile.about")),d.Lb(4),d.cd(d.vc(14,11,"about.server.packages.updates.title")),d.Lb(9),d.cd(d.vc(23,13,"about.server.packages.updates.title")),d.Lb(2),d.Ac("ngIf",!t.csrfEnabled),d.Lb(1),d.Ac("ngIf",!0===t.csrfEnabled))},directives:[c.o,o.i,l.A,l.o,l.p],pipes:[u.c,s.w],styles:["td[_ngcontent-%COMP%], th[_ngcontent-%COMP%]{color:#000;font-family:Roboto,Helvetica,Arial,sans-serif;font-size:16px;padding:4px;text-align:left}.packages-updates-container[_ngcontent-%COMP%]{width:100%;height:100%;margin-left:1rem;padding-bottom:1rem}.breadcrumbs-container[_ngcontent-%COMP%]{padding-top:.74rem;padding-left:.08rem}.rightSideFixedcontainer[_ngcontent-%COMP%]{padding-top:.74rem;margin-right:25px}.titleContainer[_ngcontent-%COMP%]{width:100%;height:100%;padding:.48rem 1.8rem .9rem 0,0}.page-title[_ngcontent-%COMP%]{font-size:1.25rem;line-height:1.5rem;font-weight:500;width:100%;margin-left:-.36rem;margin-right:-.2rem;padding-top:.68rem;font-family:Roboto,Helvetica,Arial,sans-serif}.iframecontainer[_ngcontent-%COMP%]{width:100%;height:calc(60vh);margin-left:1rem;padding-right:2rem}"]}),b)}],w=((h=a(function t(){e(this,t)})).\u0275fac=function(e){return new(e||h)},h.\u0275mod=d.Xb({type:h}),h.\u0275inj=d.Wb({imports:[[o.j.forChild(k)],o.j]}),h),y=i("ZRSf"),A=i("2ilO"),S=((v=a(function t(){e(this,t)})).\u0275fac=function(e){return new(e||v)},v.\u0275mod=d.Xb({type:v}),v.\u0275inj=d.Wb({imports:[[c.c,y.k,w,u.b,A.a,u.b.forChild({loader:{provide:u.a,useFactory:U,deps:[r.b]},extend:!0})]]}),v);function U(e){return new s.r(e,[])}}}])}();