/*! Magnific Popup - v0.9.9 - 2013-12-04
* http://dimsemenov.com/plugins/magnific-popup/
* Copyright (c) 2013 Dmitry Semenov; */
!function(e){var t,i,n,a,o,r,s,l="Close",d="BeforeClose",c="AfterClose",u="BeforeAppend",p="MarkupParse",f="Open",h="Change",m="mfp",g="."+m,v="mfp-ready",y="mfp-removing",b="mfp-prevent-close",_=function(){},x=!!window.jQuery,w=e(window),C=function(e,i){t.ev.on(m+e+g,i)},k=function(t,i,n,a){var o=document.createElement("div");return o.className="mfp-"+t,n&&(o.innerHTML=n),a?i&&i.appendChild(o):(o=e(o),i&&o.appendTo(i)),o},S=function(i,n){t.ev.triggerHandler(m+i,n),t.st.callbacks&&(i=i.charAt(0).toLowerCase()+i.slice(1),t.st.callbacks[i]&&t.st.callbacks[i].apply(t,e.isArray(n)?n:[n]))},T=function(i){return i===s&&t.currTemplate.closeBtn||(t.currTemplate.closeBtn=e(t.st.closeMarkup.replace("%title%",t.st.tClose)),s=i),t.currTemplate.closeBtn},F=function(){e.magnificPopup.instance||(t=new _,t.init(),e.magnificPopup.instance=t)},E=function(){var e=document.createElement("p").style,t=["ms","O","Moz","Webkit"];if(void 0!==e.transition)return!0;for(;t.length;)if(t.pop()+"Transition"in e)return!0;return!1};_.prototype={constructor:_,init:function(){var i=navigator.appVersion;t.isIE7=-1!==i.indexOf("MSIE 7."),t.isIE8=-1!==i.indexOf("MSIE 8."),t.isLowIE=t.isIE7||t.isIE8,t.isAndroid=/android/gi.test(i),t.isIOS=/iphone|ipad|ipod/gi.test(i),t.supportsTransition=E(),t.probablyMobile=t.isAndroid||t.isIOS||/(Opera Mini)|Kindle|webOS|BlackBerry|(Opera Mobi)|(Windows Phone)|IEMobile/i.test(navigator.userAgent),a=e(document),t.popupsCache={}},open:function(i){n=e(document.body);var o;if(i.isObj===!1){t.items=i.items.toArray(),t.index=0;var s,l=i.items;for(o=0;o<l.length;o++)if(s=l[o],s.parsed&&(s=s.el[0]),s===i.el[0]){t.index=o;break}}else t.items=e.isArray(i.items)?i.items:[i.items],t.index=i.index||0;if(t.isOpen)return void t.updateItemHTML();t.types=[],r="",t.ev=i.mainEl&&i.mainEl.length?i.mainEl.eq(0):a,i.key?(t.popupsCache[i.key]||(t.popupsCache[i.key]={}),t.currTemplate=t.popupsCache[i.key]):t.currTemplate={},t.st=e.extend(!0,{},e.magnificPopup.defaults,i),t.fixedContentPos="auto"===t.st.fixedContentPos?!t.probablyMobile:t.st.fixedContentPos,t.st.modal&&(t.st.closeOnContentClick=!1,t.st.closeOnBgClick=!1,t.st.showCloseBtn=!1,t.st.enableEscapeKey=!1),t.bgOverlay||(t.bgOverlay=k("bg").on("click"+g,function(){t.close()}),t.wrap=k("wrap").attr("tabindex",-1).on("click"+g,function(e){t._checkIfClose(e.target)&&t.close()}),t.container=k("container",t.wrap)),t.contentContainer=k("content"),t.st.preloader&&(t.preloader=k("preloader",t.container,t.st.tLoading));var d=e.magnificPopup.modules;for(o=0;o<d.length;o++){var c=d[o];c=c.charAt(0).toUpperCase()+c.slice(1),t["init"+c].call(t)}S("BeforeOpen"),t.st.showCloseBtn&&(t.st.closeBtnInside?(C(p,function(e,t,i,n){i.close_replaceWith=T(n.type)}),r+=" mfp-close-btn-in"):t.wrap.append(T())),t.st.alignTop&&(r+=" mfp-align-top"),t.wrap.css(t.fixedContentPos?{overflow:t.st.overflowY,overflowX:"hidden",overflowY:t.st.overflowY}:{top:w.scrollTop(),position:"absolute"}),(t.st.fixedBgPos===!1||"auto"===t.st.fixedBgPos&&!t.fixedContentPos)&&t.bgOverlay.css({height:a.height(),position:"absolute"}),t.st.enableEscapeKey&&a.on("keyup"+g,function(e){27===e.keyCode&&t.close()}),w.on("resize"+g,function(){t.updateSize()}),t.st.closeOnContentClick||(r+=" mfp-auto-cursor"),r&&t.wrap.addClass(r);var u=t.wH=w.height(),h={};if(t.fixedContentPos&&t._hasScrollBar(u)){var m=t._getScrollbarSize();m&&(h.marginRight=m)}t.fixedContentPos&&(t.isIE7?e("body, html").css("overflow","hidden"):h.overflow="hidden");var y=t.st.mainClass;return t.isIE7&&(y+=" mfp-ie7"),y&&t._addClassToMFP(y),t.updateItemHTML(),S("BuildControls"),e("html").css(h),t.bgOverlay.add(t.wrap).prependTo(t.st.prependTo||n),t._lastFocusedEl=document.activeElement,setTimeout(function(){t.content?(t._addClassToMFP(v),t._setFocus()):t.bgOverlay.addClass(v),a.on("focusin"+g,t._onFocusIn)},16),t.isOpen=!0,t.updateSize(u),S(f),i},close:function(){t.isOpen&&(S(d),t.isOpen=!1,t.st.removalDelay&&!t.isLowIE&&t.supportsTransition?(t._addClassToMFP(y),setTimeout(function(){t._close()},t.st.removalDelay)):t._close())},_close:function(){S(l);var i=y+" "+v+" ";if(t.bgOverlay.detach(),t.wrap.detach(),t.container.empty(),t.st.mainClass&&(i+=t.st.mainClass+" "),t._removeClassFromMFP(i),t.fixedContentPos){var n={marginRight:""};t.isIE7?e("body, html").css("overflow",""):n.overflow="",e("html").css(n)}a.off("keyup"+g+" focusin"+g),t.ev.off(g),t.wrap.attr("class","mfp-wrap").removeAttr("style"),t.bgOverlay.attr("class","mfp-bg"),t.container.attr("class","mfp-container"),!t.st.showCloseBtn||t.st.closeBtnInside&&t.currTemplate[t.currItem.type]!==!0||t.currTemplate.closeBtn&&t.currTemplate.closeBtn.detach(),t._lastFocusedEl&&e(t._lastFocusedEl).focus(),t.currItem=null,t.content=null,t.currTemplate=null,t.prevHeight=0,S(c)},updateSize:function(e){if(t.isIOS){var i=document.documentElement.clientWidth/window.innerWidth,n=window.innerHeight*i;t.wrap.css("height",n),t.wH=n}else t.wH=e||w.height();t.fixedContentPos||t.wrap.css("height",t.wH),S("Resize")},updateItemHTML:function(){var i=t.items[t.index];t.contentContainer.detach(),t.content&&t.content.detach(),i.parsed||(i=t.parseEl(t.index));var n=i.type;if(S("BeforeChange",[t.currItem?t.currItem.type:"",n]),t.currItem=i,!t.currTemplate[n]){var a=t.st[n]?t.st[n].markup:!1;S("FirstMarkupParse",a),t.currTemplate[n]=a?e(a):!0}o&&o!==i.type&&t.container.removeClass("mfp-"+o+"-holder");var r=t["get"+n.charAt(0).toUpperCase()+n.slice(1)](i,t.currTemplate[n]);t.appendContent(r,n),i.preloaded=!0,S(h,i),o=i.type,t.container.prepend(t.contentContainer),S("AfterChange")},appendContent:function(e,i){t.content=e,e?t.st.showCloseBtn&&t.st.closeBtnInside&&t.currTemplate[i]===!0?t.content.find(".mfp-close").length||t.content.append(T()):t.content=e:t.content="",S(u),t.container.addClass("mfp-"+i+"-holder"),t.contentContainer.append(t.content)},parseEl:function(i){var n=t.items[i],a=n.type;if(n=n.tagName?{el:e(n)}:{data:n,src:n.src},n.el){for(var o=t.types,r=0;r<o.length;r++)if(n.el.hasClass("mfp-"+o[r])){a=o[r];break}n.src=n.el.attr("data-mfp-src"),n.src||(n.src=n.el.attr("href"))}return n.type=a||t.st.type||"inline",n.index=i,n.parsed=!0,t.items[i]=n,S("ElementParse",n),t.items[i]},addGroup:function(e,i){var n=function(n){n.mfpEl=this,t._openClick(n,e,i)};i||(i={});var a="click.magnificPopup";i.mainEl=e,i.items?(i.isObj=!0,e.off(a).on(a,n)):(i.isObj=!1,i.delegate?e.off(a).on(a,i.delegate,n):(i.items=e,e.off(a).on(a,n)))},_openClick:function(i,n,a){var o=void 0!==a.midClick?a.midClick:e.magnificPopup.defaults.midClick;if(o||2!==i.which&&!i.ctrlKey&&!i.metaKey){var r=void 0!==a.disableOn?a.disableOn:e.magnificPopup.defaults.disableOn;if(r)if(e.isFunction(r)){if(!r.call(t))return!0}else if(w.width()<r)return!0;i.type&&(i.preventDefault(),t.isOpen&&i.stopPropagation()),a.el=e(i.mfpEl),a.delegate&&(a.items=n.find(a.delegate)),t.open(a)}},updateStatus:function(e,n){if(t.preloader){i!==e&&t.container.removeClass("mfp-s-"+i),n||"loading"!==e||(n=t.st.tLoading);var a={status:e,text:n};S("UpdateStatus",a),e=a.status,n=a.text,t.preloader.html(n),t.preloader.find("a").on("click",function(e){e.stopImmediatePropagation()}),t.container.addClass("mfp-s-"+e),i=e}},_checkIfClose:function(i){if(!e(i).hasClass(b)){var n=t.st.closeOnContentClick,a=t.st.closeOnBgClick;if(n&&a)return!0;if(!t.content||e(i).hasClass("mfp-close")||t.preloader&&i===t.preloader[0])return!0;if(i===t.content[0]||e.contains(t.content[0],i)){if(n)return!0}else if(a&&e.contains(document,i))return!0;return!1}},_addClassToMFP:function(e){t.bgOverlay.addClass(e),t.wrap.addClass(e)},_removeClassFromMFP:function(e){this.bgOverlay.removeClass(e),t.wrap.removeClass(e)},_hasScrollBar:function(e){return(t.isIE7?a.height():document.body.scrollHeight)>(e||w.height())},_setFocus:function(){(t.st.focus?t.content.find(t.st.focus).eq(0):t.wrap).focus()},_onFocusIn:function(i){return i.target===t.wrap[0]||e.contains(t.wrap[0],i.target)?void 0:(t._setFocus(),!1)},_parseMarkup:function(t,i,n){var a;n.data&&(i=e.extend(n.data,i)),S(p,[t,i,n]),e.each(i,function(e,i){if(void 0===i||i===!1)return!0;if(a=e.split("_"),a.length>1){var n=t.find(g+"-"+a[0]);if(n.length>0){var o=a[1];"replaceWith"===o?n[0]!==i[0]&&n.replaceWith(i):"img"===o?n.is("img")?n.attr("src",i):n.replaceWith('<img src="'+i+'" class="'+n.attr("class")+'" />'):n.attr(a[1],i)}}else t.find(g+"-"+e).html(i)})},_getScrollbarSize:function(){if(void 0===t.scrollbarSize){var e=document.createElement("div");e.id="mfp-sbm",e.style.cssText="width: 99px; height: 99px; overflow: scroll; position: absolute; top: -9999px;",document.body.appendChild(e),t.scrollbarSize=e.offsetWidth-e.clientWidth,document.body.removeChild(e)}return t.scrollbarSize}},e.magnificPopup={instance:null,proto:_.prototype,modules:[],open:function(t,i){return F(),t=t?e.extend(!0,{},t):{},t.isObj=!0,t.index=i||0,this.instance.open(t)},close:function(){return e.magnificPopup.instance&&e.magnificPopup.instance.close()},registerModule:function(t,i){i.options&&(e.magnificPopup.defaults[t]=i.options),e.extend(this.proto,i.proto),this.modules.push(t)},defaults:{disableOn:0,key:null,midClick:!1,mainClass:"",preloader:!0,focus:"",closeOnContentClick:!1,closeOnBgClick:!0,closeBtnInside:!0,showCloseBtn:!0,enableEscapeKey:!0,modal:!1,alignTop:!1,removalDelay:0,prependTo:null,fixedContentPos:"auto",fixedBgPos:"auto",overflowY:"auto",closeMarkup:'<button title="%title%" type="button" class="mfp-close">&times;</button>',tClose:"Close (Esc)",tLoading:"Loading..."}},e.fn.magnificPopup=function(i){F();var n=e(this);if("string"==typeof i)if("open"===i){var a,o=x?n.data("magnificPopup"):n[0].magnificPopup,r=parseInt(arguments[1],10)||0;o.items?a=o.items[r]:(a=n,o.delegate&&(a=a.find(o.delegate)),a=a.eq(r)),t._openClick({mfpEl:a},n,o)}else t.isOpen&&t[i].apply(t,Array.prototype.slice.call(arguments,1));else i=e.extend(!0,{},i),x?n.data("magnificPopup",i):n[0].magnificPopup=i,t.addGroup(n,i);return n};var $,A,D,j="inline",P=function(){D&&(A.after(D.addClass($)).detach(),D=null)};e.magnificPopup.registerModule(j,{options:{hiddenClass:"hide",markup:"",tNotFound:"Content not found"},proto:{initInline:function(){t.types.push(j),C(l+"."+j,function(){P()})},getInline:function(i,n){if(P(),i.src){var a=t.st.inline,o=e(i.src);if(o.length){var r=o[0].parentNode;r&&r.tagName&&(A||($=a.hiddenClass,A=k($),$="mfp-"+$),D=o.after(A).detach().removeClass($)),t.updateStatus("ready")}else t.updateStatus("error",a.tNotFound),o=e("<div>");return i.inlineElement=o,o}return t.updateStatus("ready"),t._parseMarkup(n,{},i),n}}});var I,z="ajax",M=function(){I&&n.removeClass(I)},O=function(){M(),t.req&&t.req.abort()};e.magnificPopup.registerModule(z,{options:{settings:null,cursor:"mfp-ajax-cur",tError:'<a href="%url%">The content</a> could not be loaded.'},proto:{initAjax:function(){t.types.push(z),I=t.st.ajax.cursor,C(l+"."+z,O),C("BeforeChange."+z,O)},getAjax:function(i){I&&n.addClass(I),t.updateStatus("loading");var a=e.extend({url:i.src,success:function(n,a,o){var r={data:n,xhr:o};S("ParseAjax",r),t.appendContent(e(r.data),z),i.finished=!0,M(),t._setFocus(),setTimeout(function(){t.wrap.addClass(v)},16),t.updateStatus("ready"),S("AjaxContentAdded")},error:function(){M(),i.finished=i.loadError=!0,t.updateStatus("error",t.st.ajax.tError.replace("%url%",i.src))}},t.st.ajax.settings);return t.req=e.ajax(a),""}}});var L,H=function(i){if(i.data&&void 0!==i.data.title)return i.data.title;var n=t.st.image.titleSrc;if(n){if(e.isFunction(n))return n.call(t,i);if(i.el)return i.el.attr(n)||""}return""};e.magnificPopup.registerModule("image",{options:{markup:'<div class="mfp-figure"><div class="mfp-close"></div><figure><div class="mfp-img"></div><figcaption><div class="mfp-bottom-bar"><div class="mfp-title"></div><div class="mfp-counter"></div></div></figcaption></figure></div>',cursor:"mfp-zoom-out-cur",titleSrc:"title",verticalFit:!0,tError:'<a href="%url%">The image</a> could not be loaded.'},proto:{initImage:function(){var e=t.st.image,i=".image";t.types.push("image"),C(f+i,function(){"image"===t.currItem.type&&e.cursor&&n.addClass(e.cursor)}),C(l+i,function(){e.cursor&&n.removeClass(e.cursor),w.off("resize"+g)}),C("Resize"+i,t.resizeImage),t.isLowIE&&C("AfterChange",t.resizeImage)},resizeImage:function(){var e=t.currItem;if(e&&e.img&&t.st.image.verticalFit){var i=0;t.isLowIE&&(i=parseInt(e.img.css("padding-top"),10)+parseInt(e.img.css("padding-bottom"),10)),e.img.css("max-height",t.wH-i)}},_onImageHasSize:function(e){e.img&&(e.hasSize=!0,L&&clearInterval(L),e.isCheckingImgSize=!1,S("ImageHasSize",e),e.imgHidden&&(t.content&&t.content.removeClass("mfp-loading"),e.imgHidden=!1))},findImageSize:function(e){var i=0,n=e.img[0],a=function(o){L&&clearInterval(L),L=setInterval(function(){return n.naturalWidth>0?void t._onImageHasSize(e):(i>200&&clearInterval(L),i++,void(3===i?a(10):40===i?a(50):100===i&&a(500)))},o)};a(1)},getImage:function(i,n){var a=0,o=function(){i&&(i.img[0].complete?(i.img.off(".mfploader"),i===t.currItem&&(t._onImageHasSize(i),t.updateStatus("ready")),i.hasSize=!0,i.loaded=!0,S("ImageLoadComplete")):(a++,200>a?setTimeout(o,100):r()))},r=function(){i&&(i.img.off(".mfploader"),i===t.currItem&&(t._onImageHasSize(i),t.updateStatus("error",s.tError.replace("%url%",i.src))),i.hasSize=!0,i.loaded=!0,i.loadError=!0)},s=t.st.image,l=n.find(".mfp-img");if(l.length){var d=document.createElement("img");d.className="mfp-img",i.img=e(d).on("load.mfploader",o).on("error.mfploader",r),d.src=i.src,l.is("img")&&(i.img=i.img.clone()),d=i.img[0],d.naturalWidth>0?i.hasSize=!0:d.width||(i.hasSize=!1)}return t._parseMarkup(n,{title:H(i),img_replaceWith:i.img},i),t.resizeImage(),i.hasSize?(L&&clearInterval(L),i.loadError?(n.addClass("mfp-loading"),t.updateStatus("error",s.tError.replace("%url%",i.src))):(n.removeClass("mfp-loading"),t.updateStatus("ready")),n):(t.updateStatus("loading"),i.loading=!0,i.hasSize||(i.imgHidden=!0,n.addClass("mfp-loading"),t.findImageSize(i)),n)}}});var N,q=function(){return void 0===N&&(N=void 0!==document.createElement("p").style.MozTransform),N};e.magnificPopup.registerModule("zoom",{options:{enabled:!1,easing:"ease-in-out",duration:300,opener:function(e){return e.is("img")?e:e.find("img")}},proto:{initZoom:function(){var e,i=t.st.zoom,n=".zoom";if(i.enabled&&t.supportsTransition){var a,o,r=i.duration,s=function(e){var t=e.clone().removeAttr("style").removeAttr("class").addClass("mfp-animated-image"),n="all "+i.duration/1e3+"s "+i.easing,a={position:"fixed",zIndex:9999,left:0,top:0,"-webkit-backface-visibility":"hidden"},o="transition";return a["-webkit-"+o]=a["-moz-"+o]=a["-o-"+o]=a[o]=n,t.css(a),t},c=function(){t.content.css("visibility","visible")};C("BuildControls"+n,function(){if(t._allowZoom()){if(clearTimeout(a),t.content.css("visibility","hidden"),e=t._getItemToZoom(),!e)return void c();o=s(e),o.css(t._getOffset()),t.wrap.append(o),a=setTimeout(function(){o.css(t._getOffset(!0)),a=setTimeout(function(){c(),setTimeout(function(){o.remove(),e=o=null,S("ZoomAnimationEnded")},16)},r)},16)}}),C(d+n,function(){if(t._allowZoom()){if(clearTimeout(a),t.st.removalDelay=r,!e){if(e=t._getItemToZoom(),!e)return;o=s(e)}o.css(t._getOffset(!0)),t.wrap.append(o),t.content.css("visibility","hidden"),setTimeout(function(){o.css(t._getOffset())},16)}}),C(l+n,function(){t._allowZoom()&&(c(),o&&o.remove(),e=null)})}},_allowZoom:function(){return"image"===t.currItem.type},_getItemToZoom:function(){return t.currItem.hasSize?t.currItem.img:!1},_getOffset:function(i){var n;n=i?t.currItem.img:t.st.zoom.opener(t.currItem.el||t.currItem);var a=n.offset(),o=parseInt(n.css("padding-top"),10),r=parseInt(n.css("padding-bottom"),10);a.top-=e(window).scrollTop()-o;var s={width:n.width(),height:(x?n.innerHeight():n[0].offsetHeight)-r-o};return q()?s["-moz-transform"]=s.transform="translate("+a.left+"px,"+a.top+"px)":(s.left=a.left,s.top=a.top),s}}});var R="iframe",B="//about:blank",W=function(e){if(t.currTemplate[R]){var i=t.currTemplate[R].find("iframe");i.length&&(e||(i[0].src=B),t.isIE8&&i.css("display",e?"block":"none"))}};e.magnificPopup.registerModule(R,{options:{markup:'<div class="mfp-iframe-scaler"><div class="mfp-close"></div><iframe class="mfp-iframe" src="//about:blank" frameborder="0" allowfullscreen></iframe></div>',srcAction:"iframe_src",patterns:{youtube:{index:"youtube.com",id:"v=",src:"//www.youtube.com/embed/%id%?autoplay=1"},vimeo:{index:"vimeo.com/",id:"/",src:"//player.vimeo.com/video/%id%?autoplay=1"},gmaps:{index:"//maps.google.",src:"%id%&output=embed"}}},proto:{initIframe:function(){t.types.push(R),C("BeforeChange",function(e,t,i){t!==i&&(t===R?W():i===R&&W(!0))}),C(l+"."+R,function(){W()})},getIframe:function(i,n){var a=i.src,o=t.st.iframe;e.each(o.patterns,function(){return a.indexOf(this.index)>-1?(this.id&&(a="string"==typeof this.id?a.substr(a.lastIndexOf(this.id)+this.id.length,a.length):this.id.call(this,a)),a=this.src.replace("%id%",a),!1):void 0});var r={};return o.srcAction&&(r[o.srcAction]=a),t._parseMarkup(n,r,i),t.updateStatus("ready"),n}}});var V=function(e){var i=t.items.length;return e>i-1?e-i:0>e?i+e:e},U=function(e,t,i){return e.replace(/%curr%/gi,t+1).replace(/%total%/gi,i)};e.magnificPopup.registerModule("gallery",{options:{enabled:!1,arrowMarkup:'<button title="%title%" type="button" class="mfp-arrow mfp-arrow-%dir%"></button>',preload:[0,2],navigateByImgClick:!0,arrows:!0,tPrev:"Previous (Left arrow key)",tNext:"Next (Right arrow key)",tCounter:"%curr% of %total%"},proto:{initGallery:function(){var i=t.st.gallery,n=".mfp-gallery",o=Boolean(e.fn.mfpFastClick);return t.direction=!0,i&&i.enabled?(r+=" mfp-gallery",C(f+n,function(){i.navigateByImgClick&&t.wrap.on("click"+n,".mfp-img",function(){return t.items.length>1?(t.next(),!1):void 0}),a.on("keydown"+n,function(e){37===e.keyCode?t.prev():39===e.keyCode&&t.next()})}),C("UpdateStatus"+n,function(e,i){i.text&&(i.text=U(i.text,t.currItem.index,t.items.length))}),C(p+n,function(e,n,a,o){var r=t.items.length;a.counter=r>1?U(i.tCounter,o.index,r):""}),C("BuildControls"+n,function(){if(t.items.length>1&&i.arrows&&!t.arrowLeft){var n=i.arrowMarkup,a=t.arrowLeft=e(n.replace(/%title%/gi,i.tPrev).replace(/%dir%/gi,"left")).addClass(b),r=t.arrowRight=e(n.replace(/%title%/gi,i.tNext).replace(/%dir%/gi,"right")).addClass(b),s=o?"mfpFastClick":"click";a[s](function(){t.prev()}),r[s](function(){t.next()}),t.isIE7&&(k("b",a[0],!1,!0),k("a",a[0],!1,!0),k("b",r[0],!1,!0),k("a",r[0],!1,!0)),t.container.append(a.add(r))}}),C(h+n,function(){t._preloadTimeout&&clearTimeout(t._preloadTimeout),t._preloadTimeout=setTimeout(function(){t.preloadNearbyImages(),t._preloadTimeout=null},16)}),void C(l+n,function(){a.off(n),t.wrap.off("click"+n),t.arrowLeft&&o&&t.arrowLeft.add(t.arrowRight).destroyMfpFastClick(),t.arrowRight=t.arrowLeft=null})):!1},next:function(){t.direction=!0,t.index=V(t.index+1),t.updateItemHTML()},prev:function(){t.direction=!1,t.index=V(t.index-1),t.updateItemHTML()},goTo:function(e){t.direction=e>=t.index,t.index=e,t.updateItemHTML()},preloadNearbyImages:function(){var e,i=t.st.gallery.preload,n=Math.min(i[0],t.items.length),a=Math.min(i[1],t.items.length);for(e=1;e<=(t.direction?a:n);e++)t._preloadItem(t.index+e);for(e=1;e<=(t.direction?n:a);e++)t._preloadItem(t.index-e)},_preloadItem:function(i){if(i=V(i),!t.items[i].preloaded){var n=t.items[i];n.parsed||(n=t.parseEl(i)),S("LazyLoad",n),"image"===n.type&&(n.img=e('<img class="mfp-img" />').on("load.mfploader",function(){n.hasSize=!0}).on("error.mfploader",function(){n.hasSize=!0,n.loadError=!0,S("LazyLoadError",n)}).attr("src",n.src)),n.preloaded=!0}}}});var Q="retina";e.magnificPopup.registerModule(Q,{options:{replaceSrc:function(e){return e.src.replace(/\.\w+$/,function(e){return"@2x"+e})},ratio:1},proto:{initRetina:function(){if(window.devicePixelRatio>1){var e=t.st.retina,i=e.ratio;i=isNaN(i)?i():i,i>1&&(C("ImageHasSize."+Q,function(e,t){t.img.css({"max-width":t.img[0].naturalWidth/i,width:"100%"})}),C("ElementParse."+Q,function(t,n){n.src=e.replaceSrc(n,i)}))}}}}),function(){var t=1e3,i="ontouchstart"in window,n=function(){w.off("touchmove"+o+" touchend"+o)},a="mfpFastClick",o="."+a;e.fn.mfpFastClick=function(a){return e(this).each(function(){var r,s=e(this);if(i){var l,d,c,u,p,f;s.on("touchstart"+o,function(e){u=!1,f=1,p=e.originalEvent?e.originalEvent.touches[0]:e.touches[0],d=p.clientX,c=p.clientY,w.on("touchmove"+o,function(e){p=e.originalEvent?e.originalEvent.touches:e.touches,f=p.length,p=p[0],(Math.abs(p.clientX-d)>10||Math.abs(p.clientY-c)>10)&&(u=!0,n())}).on("touchend"+o,function(e){n(),u||f>1||(r=!0,e.preventDefault(),clearTimeout(l),l=setTimeout(function(){r=!1},t),a())})})}s.on("click"+o,function(){r||a()})})},e.fn.destroyMfpFastClick=function(){e(this).off("touchstart"+o+" click"+o),i&&w.off("touchmove"+o+" touchend"+o)}}(),F()}(window.jQuery||window.Zepto);