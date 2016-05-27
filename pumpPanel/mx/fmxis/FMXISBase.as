class mx.fmxis.FMXISBase extends mx.core.UIComponent
{
    var _xscale, _yscale, boundingBoxClip, listener, eventObj, myEvents, addEventListener, removeEventListener, _parent, myProxyListeners;
    function FMXISBase()
    {
        super();
    } // End of the function
    function init(evts)
    {
        var _loc4 = _xscale;
        var _loc3 = _yscale;
        super.init();
        _xscale = _loc4;
        _yscale = _loc3;
        boundingBoxClip._visible = false;
        this.addProxyListener(listener, evts);
        eventObj = new Object();
        eventObj.target = this;
    } // End of the function
    function addListener(lstnr)
    {
        if (lstnr instanceof Object)
        {
            for (var _loc2 = 0; _loc2 < myEvents.length; ++_loc2)
            {
                this.addEventListener(myEvents[_loc2], lstnr);
            } // end of for
        }
        else
        {
            this.addProxyListener(lstnr);
        } // end else if
    } // End of the function
    function removeListener(lstnr)
    {
        if (lstnr instanceof Object)
        {
            for (var _loc2 = 0; _loc2 < myEvents.length; ++_loc2)
            {
                this.removeEventListener(myEvents[_loc2], lstnr);
            } // end of for
        }
        else
        {
            this.removeProxyListener(lstnr);
        } // end else if
    } // End of the function
    function addProxyListener(listenerName, evts)
    {
        var thisPL;
        var len;
        var timeline = this._parent;
        var already = false;
        if (listenerName != "" && listenerName != undefined)
        {
            if (listenerName.indexOf(".") != -1)
            {
                var pfx = listenerName.toUpperCase();
                var lastDot;
                var fullPfx;
                lastDot = pfx.lastIndexOf(".");
                fullPfx = listenerName.substr(0, lastDot).toLowerCase();
                if (pfx.substr(0, 7) == "_PARENT")
                {
                    timeline = eval("this._parent." + fullPfx);
                }
                else
                {
                    timeline = eval(fullPfx);
                } // end else if
                listenerName = listenerName.substr(lastDot + 1);
            } // end if
            if (evts == undefined)
            {
                evts = this.myEvents;
            } // end if
            if (this.myProxyListeners == undefined)
            {
                this.myProxyListeners = new Array(new mx.fmxis.FMXISProxyListener(timeline, listenerName));
            }
            else
            {
                var i = 0;
                while (i < this.myProxyListeners.length)
                {
                    if (this.myProxyListeners[i].lstner == listenerName && this.myProxyListeners[i].tline == timeline)
                    {
                        already = true;
                        break;
                    } // end if
                    ++i;
                } // end while
                if (already)
                {
                    return;
                } // end if
                this.myProxyListeners.push(new mx.fmxis.FMXISProxyListener(timeline, listenerName));
            } // end else if
            thisPL = this.myProxyListeners[this.myProxyListeners.length - 1];
            len = evts.length;
            var i = 0;
            while (i < len)
            {
                this.addEventListener(evts[i], thisPL);
                ++i;
            } // end while
        } // end if
    } // End of the function
    function removeProxyListener(listenerName)
    {
        var thisPL;
        var MPLs = this.myProxyListeners.length;
        var MEs = this.myEvents.length;
        var timeline = this._parent;
        if (listenerName.indexOf(".") != -1)
        {
            var pfx = listenerName.toUpperCase();
            var lastDot;
            var fullPfx;
            lastDot = pfx.lastIndexOf(".");
            fullPfx = listenerName.substr(0, lastDot).toLowerCase();
            if (pfx.substr(0, 7) == "_PARENT")
            {
                timeline = eval("this._parent." + fullPfx);
            }
            else
            {
                timeline = eval(fullPfx);
            } // end else if
            listenerName = listenerName.substr(lastDot + 1);
        } // end if
        if (this.myProxyListeners != undefined)
        {
            var i = 0;
            while (i < MPLs)
            {
                if (this.myProxyListeners[i].lstner == listenerName && this.myProxyListeners[i].tline == timeline)
                {
                    thisPL = this.myProxyListeners[i];
                    var j = 0;
                    while (i < MEs)
                    {
                        this.removeEventListener(this.myEvents[i], thisPL);
                        ++i;
                    } // end while
                    this.myProxyListeners.splice(i, 1);
                    break;
                } // end if
                ++i;
            } // end while
        } // end if
    } // End of the function
    var className = "FMXISBase";
    static var symbolOwner = mx.fmxis.FMXISBase;
    static var symbolName = "FMXISBase";
    static var _BCastMixin = mx.events.EventDispatcher.initialize(mx.fmxis.FMXISBase.prototype);
    var clipParameters = {listener: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISBase.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
} // End of Class
