/*! Magnific Popup - v0.9.9 - 2013-12-04
* http://dimsemenov.com/plugins/magnific-popup/
* Copyright (c) 2013 Dmitry Semenov; */
!function(t){var e,i,n,a,s,o,r,l="Close",d="BeforeClose",c="AfterClose",u="BeforeAppend",p="MarkupParse",h="Open",f="Change",m="mfp",g="."+m,v="mfp-ready",y="mfp-removing",b="mfp-prevent-close",_=function(){},w=!!window.jQuery,x=t(window),C=function(t,i){e.ev.on(m+t+g,i)},k=function(e,i,n,a){var s=document.createElement("div");return s.className="mfp-"+e,n&&(s.innerHTML=n),a?i&&i.appendChild(s):(s=t(s),i&&s.appendTo(i)),s},T=function(i,n){e.ev.triggerHandler(m+i,n),e.st.callbacks&&(i=i.charAt(0).toLowerCase()+i.slice(1),e.st.callbacks[i]&&e.st.callbacks[i].apply(e,t.isArray(n)?n:[n]))},S=function(i){return i===r&&e.currTemplate.closeBtn||(e.currTemplate.closeBtn=t(e.st.closeMarkup.replace("%title%",e.st.tClose)),r=i),e.currTemplate.closeBtn},F=function(){t.magnificPopup.instance||(e=new _,e.init(),t.magnificPopup.instance=e)},E=function(){var t=document.createElement("p").style,e=["ms","O","Moz","Webkit"];if(void 0!==t.transition)return!0;for(;e.length;)if(e.pop()+"Transition"in t)return!0;return!1};_.prototype={constructor:_,init:function(){var i=navigator.appVersion;e.isIE7=-1!==i.indexOf("MSIE 7."),e.isIE8=-1!==i.indexOf("MSIE 8."),e.isLowIE=e.isIE7||e.isIE8,e.isAndroid=/android/gi.test(i),e.isIOS=/iphone|ipad|ipod/gi.test(i),e.supportsTransition=E(),e.probablyMobile=e.isAndroid||e.isIOS||/(Opera Mini)|Kindle|webOS|BlackBerry|(Opera Mobi)|(Windows Phone)|IEMobile/i.test(navigator.userAgent),a=t(document),e.popupsCache={}},open:function(i){n=t(document.body);var s;if(i.isObj===!1){e.items=i.items.toArray(),e.index=0;var r,l=i.items;for(s=0;s<l.length;s++)if(r=l[s],r.parsed&&(r=r.el[0]),r===i.el[0]){e.index=s;break}}else e.items=t.isArray(i.items)?i.items:[i.items],e.index=i.index||0;if(e.isOpen)return void e.updateItemHTML();e.types=[],o="",e.ev=i.mainEl&&i.mainEl.length?i.mainEl.eq(0):a,i.key?(e.popupsCache[i.key]||(e.popupsCache[i.key]={}),e.currTemplate=e.popupsCache[i.key]):e.currTemplate={},e.st=t.extend(!0,{},t.magnificPopup.defaults,i),e.fixedContentPos="auto"===e.st.fixedContentPos?!e.probablyMobile:e.st.fixedContentPos,e.st.modal&&(e.st.closeOnContentClick=!1,e.st.closeOnBgClick=!1,e.st.showCloseBtn=!1,e.st.enableEscapeKey=!1),e.bgOverlay||(e.bgOverlay=k("bg").on("click"+g,function(){e.close()}),e.wrap=k("wrap").attr("tabindex",-1).on("click"+g,function(t){e._checkIfClose(t.target)&&e.close()}),e.container=k("container",e.wrap)),e.contentContainer=k("content"),e.st.preloader&&(e.preloader=k("preloader",e.container,e.st.tLoading));var d=t.magnificPopup.modules;for(s=0;s<d.length;s++){var c=d[s];c=c.charAt(0).toUpperCase()+c.slice(1),e["init"+c].call(e)}T("BeforeOpen"),e.st.showCloseBtn&&(e.st.closeBtnInside?(C(p,function(t,e,i,n){i.close_replaceWith=S(n.type)}),o+=" mfp-close-btn-in"):e.wrap.append(S())),e.st.alignTop&&(o+=" mfp-align-top"),e.wrap.css(e.fixedContentPos?{overflow:e.st.overflowY,overflowX:"hidden",overflowY:e.st.overflowY}:{top:x.scrollTop(),position:"absolute"}),(e.st.fixedBgPos===!1||"auto"===e.st.fixedBgPos&&!e.fixedContentPos)&&e.bgOverlay.css({height:a.height(),position:"absolute"}),e.st.enableEscapeKey&&a.on("keyup"+g,function(t){27===t.keyCode&&e.close()}),x.on("resize"+g,function(){e.updateSize()}),e.st.closeOnContentClick||(o+=" mfp-auto-cursor"),o&&e.wrap.addClass(o);var u=e.wH=x.height(),f={};if(e.fixedContentPos&&e._hasScrollBar(u)){var m=e._getScrollbarSize();m&&(f.marginRight=m)}e.fixedContentPos&&(e.isIE7?t("body, html").css("overflow","hidden"):f.overflow="hidden");var y=e.st.mainClass;return e.isIE7&&(y+=" mfp-ie7"),y&&e._addClassToMFP(y),e.updateItemHTML(),T("BuildControls"),t("html").css(f),e.bgOverlay.add(e.wrap).prependTo(e.st.prependTo||n),e._lastFocusedEl=document.activeElement,setTimeout(function(){e.content?(e._addClassToMFP(v),e._setFocus()):e.bgOverlay.addClass(v),a.on("focusin"+g,e._onFocusIn)},16),e.isOpen=!0,e.updateSize(u),T(h),i},close:function(){e.isOpen&&(T(d),e.isOpen=!1,e.st.removalDelay&&!e.isLowIE&&e.supportsTransition?(e._addClassToMFP(y),setTimeout(function(){e._close()},e.st.removalDelay)):e._close())},_close:function(){T(l);var i=y+" "+v+" ";if(e.bgOverlay.detach(),e.wrap.detach(),e.container.empty(),e.st.mainClass&&(i+=e.st.mainClass+" "),e._removeClassFromMFP(i),e.fixedContentPos){var n={marginRight:""};e.isIE7?t("body, html").css("overflow",""):n.overflow="",t("html").css(n)}a.off("keyup"+g+" focusin"+g),e.ev.off(g),e.wrap.attr("class","mfp-wrap").removeAttr("style"),e.bgOverlay.attr("class","mfp-bg"),e.container.attr("class","mfp-container"),!e.st.showCloseBtn||e.st.closeBtnInside&&e.currTemplate[e.currItem.type]!==!0||e.currTemplate.closeBtn&&e.currTemplate.closeBtn.detach(),e._lastFocusedEl&&t(e._lastFocusedEl).focus(),e.currItem=null,e.content=null,e.currTemplate=null,e.prevHeight=0,T(c)},updateSize:function(t){if(e.isIOS){var i=document.documentElement.clientWidth/window.innerWidth,n=window.innerHeight*i;e.wrap.css("height",n),e.wH=n}else e.wH=t||x.height();e.fixedContentPos||e.wrap.css("height",e.wH),T("Resize")},updateItemHTML:function(){var i=e.items[e.index];e.contentContainer.detach(),e.content&&e.content.detach(),i.parsed||(i=e.parseEl(e.index));var n=i.type;if(T("BeforeChange",[e.currItem?e.currItem.type:"",n]),e.currItem=i,!e.currTemplate[n]){var a=e.st[n]?e.st[n].markup:!1;T("FirstMarkupParse",a),e.currTemplate[n]=a?t(a):!0}s&&s!==i.type&&e.container.removeClass("mfp-"+s+"-holder");var o=e["get"+n.charAt(0).toUpperCase()+n.slice(1)](i,e.currTemplate[n]);e.appendContent(o,n),i.preloaded=!0,T(f,i),s=i.type,e.container.prepend(e.contentContainer),T("AfterChange")},appendContent:function(t,i){e.content=t,t?e.st.showCloseBtn&&e.st.closeBtnInside&&e.currTemplate[i]===!0?e.content.find(".mfp-close").length||e.content.append(S()):e.content=t:e.content="",T(u),e.container.addClass("mfp-"+i+"-holder"),e.contentContainer.append(e.content)},parseEl:function(i){var n=e.items[i],a=n.type;if(n=n.tagName?{el:t(n)}:{data:n,src:n.src},n.el){for(var s=e.types,o=0;o<s.length;o++)if(n.el.hasClass("mfp-"+s[o])){a=s[o];break}n.src=n.el.attr("data-mfp-src"),n.src||(n.src=n.el.attr("href"))}return n.type=a||e.st.type||"inline",n.index=i,n.parsed=!0,e.items[i]=n,T("ElementParse",n),e.items[i]},addGroup:function(t,i){var n=function(n){n.mfpEl=this,e._openClick(n,t,i)};i||(i={});var a="click.magnificPopup";i.mainEl=t,i.items?(i.isObj=!0,t.off(a).on(a,n)):(i.isObj=!1,i.delegate?t.off(a).on(a,i.delegate,n):(i.items=t,t.off(a).on(a,n)))},_openClick:function(i,n,a){var s=void 0!==a.midClick?a.midClick:t.magnificPopup.defaults.midClick;if(s||2!==i.which&&!i.ctrlKey&&!i.metaKey){var o=void 0!==a.disableOn?a.disableOn:t.magnificPopup.defaults.disableOn;if(o)if(t.isFunction(o)){if(!o.call(e))return!0}else if(x.width()<o)return!0;i.type&&(i.preventDefault(),e.isOpen&&i.stopPropagation()),a.el=t(i.mfpEl),a.delegate&&(a.items=n.find(a.delegate)),e.open(a)}},updateStatus:function(t,n){if(e.preloader){i!==t&&e.container.removeClass("mfp-s-"+i),n||"loading"!==t||(n=e.st.tLoading);var a={status:t,text:n};T("UpdateStatus",a),t=a.status,n=a.text,e.preloader.html(n),e.preloader.find("a").on("click",function(t){t.stopImmediatePropagation()}),e.container.addClass("mfp-s-"+t),i=t}},_checkIfClose:function(i){if(!t(i).hasClass(b)){var n=e.st.closeOnContentClick,a=e.st.closeOnBgClick;if(n&&a)return!0;if(!e.content||t(i).hasClass("mfp-close")||e.preloader&&i===e.preloader[0])return!0;if(i===e.content[0]||t.contains(e.content[0],i)){if(n)return!0}else if(a&&t.contains(document,i))return!0;return!1}},_addClassToMFP:function(t){e.bgOverlay.addClass(t),e.wrap.addClass(t)},_removeClassFromMFP:function(t){this.bgOverlay.removeClass(t),e.wrap.removeClass(t)},_hasScrollBar:function(t){return(e.isIE7?a.height():document.body.scrollHeight)>(t||x.height())},_setFocus:function(){(e.st.focus?e.content.find(e.st.focus).eq(0):e.wrap).focus()},_onFocusIn:function(i){return i.target===e.wrap[0]||t.contains(e.wrap[0],i.target)?void 0:(e._setFocus(),!1)},_parseMarkup:function(e,i,n){var a;n.data&&(i=t.extend(n.data,i)),T(p,[e,i,n]),t.each(i,function(t,i){if(void 0===i||i===!1)return!0;if(a=t.split("_"),a.length>1){var n=e.find(g+"-"+a[0]);if(n.length>0){var s=a[1];"replaceWith"===s?n[0]!==i[0]&&n.replaceWith(i):"img"===s?n.is("img")?n.attr("src",i):n.replaceWith('<img src="'+i+'" class="'+n.attr("class")+'" />'):n.attr(a[1],i)}}else e.find(g+"-"+t).html(i)})},_getScrollbarSize:function(){if(void 0===e.scrollbarSize){var t=document.createElement("div");t.id="mfp-sbm",t.style.cssText="width: 99px; height: 99px; overflow: scroll; position: absolute; top: -9999px;",document.body.appendChild(t),e.scrollbarSize=t.offsetWidth-t.clientWidth,document.body.removeChild(t)}return e.scrollbarSize}},t.magnificPopup={instance:null,proto:_.prototype,modules:[],open:function(e,i){return F(),e=e?t.extend(!0,{},e):{},e.isObj=!0,e.index=i||0,this.instance.open(e)},close:function(){return t.magnificPopup.instance&&t.magnificPopup.instance.close()},registerModule:function(e,i){i.options&&(t.magnificPopup.defaults[e]=i.options),t.extend(this.proto,i.proto),this.modules.push(e)},defaults:{disableOn:0,key:null,midClick:!1,mainClass:"",preloader:!0,focus:"",closeOnContentClick:!1,closeOnBgClick:!0,closeBtnInside:!0,showCloseBtn:!0,enableEscapeKey:!0,modal:!1,alignTop:!1,removalDelay:0,prependTo:null,fixedContentPos:"auto",fixedBgPos:"auto",overflowY:"auto",closeMarkup:'<button title="%title%" type="button" class="mfp-close">&times;</button>',tClose:"Close (Esc)",tLoading:"Loading..."}},t.fn.magnificPopup=function(i){F();var n=t(this);if("string"==typeof i)if("open"===i){var a,s=w?n.data("magnificPopup"):n[0].magnificPopup,o=parseInt(arguments[1],10)||0;s.items?a=s.items[o]:(a=n,s.delegate&&(a=a.find(s.delegate)),a=a.eq(o)),e._openClick({mfpEl:a},n,s)}else e.isOpen&&e[i].apply(e,Array.prototype.slice.call(arguments,1));else i=t.extend(!0,{},i),w?n.data("magnificPopup",i):n[0].magnificPopup=i,e.addGroup(n,i);return n};var D,$,A,M="inline",j=function(){A&&($.after(A.addClass(D)).detach(),A=null)};t.magnificPopup.registerModule(M,{options:{hiddenClass:"hide",markup:"",tNotFound:"Content not found"},proto:{initInline:function(){e.types.push(M),C(l+"."+M,function(){j()})},getInline:function(i,n){if(j(),i.src){var a=e.st.inline,s=t(i.src);if(s.length){var o=s[0].parentNode;o&&o.tagName&&($||(D=a.hiddenClass,$=k(D),D="mfp-"+D),A=s.after($).detach().removeClass(D)),e.updateStatus("ready")}else e.updateStatus("error",a.tNotFound),s=t("<div>");return i.inlineElement=s,s}return e.updateStatus("ready"),e._parseMarkup(n,{},i),n}}});var P,z="ajax",I=function(){P&&n.removeClass(P)},O=function(){I(),e.req&&e.req.abort()};t.magnificPopup.registerModule(z,{options:{settings:null,cursor:"mfp-ajax-cur",tError:'<a href="%url%">The content</a> could not be loaded.'},proto:{initAjax:function(){e.types.push(z),P=e.st.ajax.cursor,C(l+"."+z,O),C("BeforeChange."+z,O)},getAjax:function(i){P&&n.addClass(P),e.updateStatus("loading");var a=t.extend({url:i.src,success:function(n,a,s){var o={data:n,xhr:s};T("ParseAjax",o),e.appendContent(t(o.data),z),i.finished=!0,I(),e._setFocus(),setTimeout(function(){e.wrap.addClass(v)},16),e.updateStatus("ready"),T("AjaxContentAdded")},error:function(){I(),i.finished=i.loadError=!0,e.updateStatus("error",e.st.ajax.tError.replace("%url%",i.src))}},e.st.ajax.settings);return e.req=t.ajax(a),""}}});var N,L=function(i){if(i.data&&void 0!==i.data.title)return i.data.title;var n=e.st.image.titleSrc;if(n){if(t.isFunction(n))return n.call(e,i);if(i.el)return i.el.attr(n)||""}return""};t.magnificPopup.registerModule("image",{options:{markup:'<div class="mfp-figure"><div class="mfp-close"></div><figure><div class="mfp-img"></div><figcaption><div class="mfp-bottom-bar"><div class="mfp-title"></div><div class="mfp-counter"></div></div></figcaption></figure></div>',cursor:"mfp-zoom-out-cur",titleSrc:"title",verticalFit:!0,tError:'<a href="%url%">The image</a> could not be loaded.'},proto:{initImage:function(){var t=e.st.image,i=".image";e.types.push("image"),C(h+i,function(){"image"===e.currItem.type&&t.cursor&&n.addClass(t.cursor)}),C(l+i,function(){t.cursor&&n.removeClass(t.cursor),x.off("resize"+g)}),C("Resize"+i,e.resizeImage),e.isLowIE&&C("AfterChange",e.resizeImage)},resizeImage:function(){var t=e.currItem;if(t&&t.img&&e.st.image.verticalFit){var i=0;e.isLowIE&&(i=parseInt(t.img.css("padding-top"),10)+parseInt(t.img.css("padding-bottom"),10)),t.img.css("max-height",e.wH-i)}},_onImageHasSize:function(t){t.img&&(t.hasSize=!0,N&&clearInterval(N),t.isCheckingImgSize=!1,T("ImageHasSize",t),t.imgHidden&&(e.content&&e.content.removeClass("mfp-loading"),t.imgHidden=!1))},findImageSize:function(t){var i=0,n=t.img[0],a=function(s){N&&clearInterval(N),N=setInterval(function(){return n.naturalWidth>0?void e._onImageHasSize(t):(i>200&&clearInterval(N),i++,void(3===i?a(10):40===i?a(50):100===i&&a(500)))},s)};a(1)},getImage:function(i,n){var a=0,s=function(){i&&(i.img[0].complete?(i.img.off(".mfploader"),i===e.currItem&&(e._onImageHasSize(i),e.updateStatus("ready")),i.hasSize=!0,i.loaded=!0,T("ImageLoadComplete")):(a++,200>a?setTimeout(s,100):o()))},o=function(){i&&(i.img.off(".mfploader"),i===e.currItem&&(e._onImageHasSize(i),e.updateStatus("error",r.tError.replace("%url%",i.src))),i.hasSize=!0,i.loaded=!0,i.loadError=!0)},r=e.st.image,l=n.find(".mfp-img");if(l.length){var d=document.createElement("img");d.className="mfp-img",i.img=t(d).on("load.mfploader",s).on("error.mfploader",o),d.src=i.src,l.is("img")&&(i.img=i.img.clone()),d=i.img[0],d.naturalWidth>0?i.hasSize=!0:d.width||(i.hasSize=!1)}return e._parseMarkup(n,{title:L(i),img_replaceWith:i.img},i),e.resizeImage(),i.hasSize?(N&&clearInterval(N),i.loadError?(n.addClass("mfp-loading"),e.updateStatus("error",r.tError.replace("%url%",i.src))):(n.removeClass("mfp-loading"),e.updateStatus("ready")),n):(e.updateStatus("loading"),i.loading=!0,i.hasSize||(i.imgHidden=!0,n.addClass("mfp-loading"),e.findImageSize(i)),n)}}});var H,q=function(){return void 0===H&&(H=void 0!==document.createElement("p").style.MozTransform),H};t.magnificPopup.registerModule("zoom",{options:{enabled:!1,easing:"ease-in-out",duration:300,opener:function(t){return t.is("img")?t:t.find("img")}},proto:{initZoom:function(){var t,i=e.st.zoom,n=".zoom";if(i.enabled&&e.supportsTransition){var a,s,o=i.duration,r=function(t){var e=t.clone().removeAttr("style").removeAttr("class").addClass("mfp-animated-image"),n="all "+i.duration/1e3+"s "+i.easing,a={position:"fixed",zIndex:9999,left:0,top:0,"-webkit-backface-visibility":"hidden"},s="transition";return a["-webkit-"+s]=a["-moz-"+s]=a["-o-"+s]=a[s]=n,e.css(a),e},c=function(){e.content.css("visibility","visible")};C("BuildControls"+n,function(){if(e._allowZoom()){if(clearTimeout(a),e.content.css("visibility","hidden"),t=e._getItemToZoom(),!t)return void c();s=r(t),s.css(e._getOffset()),e.wrap.append(s),a=setTimeout(function(){s.css(e._getOffset(!0)),a=setTimeout(function(){c(),setTimeout(function(){s.remove(),t=s=null,T("ZoomAnimationEnded")},16)},o)},16)}}),C(d+n,function(){if(e._allowZoom()){if(clearTimeout(a),e.st.removalDelay=o,!t){if(t=e._getItemToZoom(),!t)return;s=r(t)}s.css(e._getOffset(!0)),e.wrap.append(s),e.content.css("visibility","hidden"),setTimeout(function(){s.css(e._getOffset())},16)}}),C(l+n,function(){e._allowZoom()&&(c(),s&&s.remove(),t=null)})}},_allowZoom:function(){return"image"===e.currItem.type},_getItemToZoom:function(){return e.currItem.hasSize?e.currItem.img:!1},_getOffset:function(i){var n;n=i?e.currItem.img:e.st.zoom.opener(e.currItem.el||e.currItem);var a=n.offset(),s=parseInt(n.css("padding-top"),10),o=parseInt(n.css("padding-bottom"),10);a.top-=t(window).scrollTop()-s;var r={width:n.width(),height:(w?n.innerHeight():n[0].offsetHeight)-o-s};return q()?r["-moz-transform"]=r.transform="translate("+a.left+"px,"+a.top+"px)":(r.left=a.left,r.top=a.top),r}}});var R="iframe",W="//about:blank",U=function(t){if(e.currTemplate[R]){var i=e.currTemplate[R].find("iframe");i.length&&(t||(i[0].src=W),e.isIE8&&i.css("display",t?"block":"none"))}};t.magnificPopup.registerModule(R,{options:{markup:'<div class="mfp-iframe-scaler"><div class="mfp-close"></div><iframe class="mfp-iframe" src="//about:blank" frameborder="0" allowfullscreen></iframe></div>',srcAction:"iframe_src",patterns:{youtube:{index:"youtube.com",id:"v=",src:"//www.youtube.com/embed/%id%?autoplay=1"},vimeo:{index:"vimeo.com/",id:"/",src:"//player.vimeo.com/video/%id%?autoplay=1"},gmaps:{index:"//maps.google.",src:"%id%&output=embed"}}},proto:{initIframe:function(){e.types.push(R),C("BeforeChange",function(t,e,i){e!==i&&(e===R?U():i===R&&U(!0))}),C(l+"."+R,function(){U()})},getIframe:function(i,n){var a=i.src,s=e.st.iframe;t.each(s.patterns,function(){return a.indexOf(this.index)>-1?(this.id&&(a="string"==typeof this.id?a.substr(a.lastIndexOf(this.id)+this.id.length,a.length):this.id.call(this,a)),a=this.src.replace("%id%",a),!1):void 0});var o={};return s.srcAction&&(o[s.srcAction]=a),e._parseMarkup(n,o,i),e.updateStatus("ready"),n}}});var V=function(t){var i=e.items.length;return t>i-1?t-i:0>t?i+t:t},B=function(t,e,i){return t.replace(/%curr%/gi,e+1).replace(/%total%/gi,i)};t.magnificPopup.registerModule("gallery",{options:{enabled:!1,arrowMarkup:'<button title="%title%" type="button" class="mfp-arrow mfp-arrow-%dir%"></button>',preload:[0,2],navigateByImgClick:!0,arrows:!0,tPrev:"Previous (Left arrow key)",tNext:"Next (Right arrow key)",tCounter:"%curr% of %total%"},proto:{initGallery:function(){var i=e.st.gallery,n=".mfp-gallery",s=Boolean(t.fn.mfpFastClick);return e.direction=!0,i&&i.enabled?(o+=" mfp-gallery",C(h+n,function(){i.navigateByImgClick&&e.wrap.on("click"+n,".mfp-img",function(){return e.items.length>1?(e.next(),!1):void 0}),a.on("keydown"+n,function(t){37===t.keyCode?e.prev():39===t.keyCode&&e.next()})}),C("UpdateStatus"+n,function(t,i){i.text&&(i.text=B(i.text,e.currItem.index,e.items.length))}),C(p+n,function(t,n,a,s){var o=e.items.length;a.counter=o>1?B(i.tCounter,s.index,o):""}),C("BuildControls"+n,function(){if(e.items.length>1&&i.arrows&&!e.arrowLeft){var n=i.arrowMarkup,a=e.arrowLeft=t(n.replace(/%title%/gi,i.tPrev).replace(/%dir%/gi,"left")).addClass(b),o=e.arrowRight=t(n.replace(/%title%/gi,i.tNext).replace(/%dir%/gi,"right")).addClass(b),r=s?"mfpFastClick":"click";a[r](function(){e.prev()}),o[r](function(){e.next()}),e.isIE7&&(k("b",a[0],!1,!0),k("a",a[0],!1,!0),k("b",o[0],!1,!0),k("a",o[0],!1,!0)),e.container.append(a.add(o))}}),C(f+n,function(){e._preloadTimeout&&clearTimeout(e._preloadTimeout),e._preloadTimeout=setTimeout(function(){e.preloadNearbyImages(),e._preloadTimeout=null},16)}),void C(l+n,function(){a.off(n),e.wrap.off("click"+n),e.arrowLeft&&s&&e.arrowLeft.add(e.arrowRight).destroyMfpFastClick(),e.arrowRight=e.arrowLeft=null})):!1},next:function(){e.direction=!0,e.index=V(e.index+1),e.updateItemHTML()},prev:function(){e.direction=!1,e.index=V(e.index-1),e.updateItemHTML()},goTo:function(t){e.direction=t>=e.index,e.index=t,e.updateItemHTML()},preloadNearbyImages:function(){var t,i=e.st.gallery.preload,n=Math.min(i[0],e.items.length),a=Math.min(i[1],e.items.length);for(t=1;t<=(e.direction?a:n);t++)e._preloadItem(e.index+t);for(t=1;t<=(e.direction?n:a);t++)e._preloadItem(e.index-t)},_preloadItem:function(i){if(i=V(i),!e.items[i].preloaded){var n=e.items[i];n.parsed||(n=e.parseEl(i)),T("LazyLoad",n),"image"===n.type&&(n.img=t('<img class="mfp-img" />').on("load.mfploader",function(){n.hasSize=!0}).on("error.mfploader",function(){n.hasSize=!0,n.loadError=!0,T("LazyLoadError",n)}).attr("src",n.src)),n.preloaded=!0}}}});var Y="retina";t.magnificPopup.registerModule(Y,{options:{replaceSrc:function(t){return t.src.replace(/\.\w+$/,function(t){return"@2x"+t})},ratio:1},proto:{initRetina:function(){if(window.devicePixelRatio>1){var t=e.st.retina,i=t.ratio;i=isNaN(i)?i():i,i>1&&(C("ImageHasSize."+Y,function(t,e){e.img.css({"max-width":e.img[0].naturalWidth/i,width:"100%"})}),C("ElementParse."+Y,function(e,n){n.src=t.replaceSrc(n,i)}))}}}}),function(){var e=1e3,i="ontouchstart"in window,n=function(){x.off("touchmove"+s+" touchend"+s)},a="mfpFastClick",s="."+a;t.fn.mfpFastClick=function(a){return t(this).each(function(){var o,r=t(this);if(i){var l,d,c,u,p,h;r.on("touchstart"+s,function(t){u=!1,h=1,p=t.originalEvent?t.originalEvent.touches[0]:t.touches[0],d=p.clientX,c=p.clientY,x.on("touchmove"+s,function(t){p=t.originalEvent?t.originalEvent.touches:t.touches,h=p.length,p=p[0],(Math.abs(p.clientX-d)>10||Math.abs(p.clientY-c)>10)&&(u=!0,n())}).on("touchend"+s,function(t){n(),u||h>1||(o=!0,t.preventDefault(),clearTimeout(l),l=setTimeout(function(){o=!1},e),a())})})}r.on("click"+s,function(){o||a()})})},t.fn.destroyMfpFastClick=function(){t(this).off("touchstart"+s+" click"+s),i&&x.off("touchmove"+s+" touchend"+s)}}(),F()}(window.jQuery||window.Zepto);