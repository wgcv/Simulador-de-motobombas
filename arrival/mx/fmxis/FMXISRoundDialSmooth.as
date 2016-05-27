class mx.fmxis.FMXISRoundDialSmooth extends mx.fmxis.FMXISRoundDial
{
    var units, _targVal, __get__targVal, evtReachTarg, needleRate, _unitsPupd, _val, _inX, _xID, eventObj, dispatchEvent, setNeedle, __get__val, __set__targVal, __set__val;
    function FMXISRoundDialSmooth()
    {
        super();
    } // End of the function
    function set targVal(v)
    {
        v = v % units;
        this.setTargVal(v);
        _targVal = v;
        //return (this.targVal());
        null;
    } // End of the function
    function get targVal()
    {
        return (_targVal);
    } // End of the function
    function init(evts)
    {
        if (myEvents[0] != evtReachTarg || evts != null)
        {
            myEvents = [evtReachTarg];
        } // end if
        if (evts != null)
        {
            if (!(evts instanceof Array))
            {
                evts = [evts];
            } // end if
            super.init(myEvents = myEvents.concat(evts));
        }
        else
        {
            super.init(myEvents);
        } // end else if
    } // End of the function
    function setTargVal(v)
    {
        _unitsPupd = needleRate / 20;
        if (v < _val)
        {
            _unitsPupd = _unitsPupd * -1;
        } // end if
        if (!_inX && v != _val)
        {
            _xID = setInterval(this, "xCbk", 50);
            _inX = true;
        } // end if
        _targVal = v;
    } // End of the function
    function xCbk()
    {
        var _loc2 = _val + _unitsPupd;
        var _loc3;
        _loc3 = Math.abs(_loc2 - _targVal);
        if (_loc3 < Math.abs(_unitsPupd))
        {
            clearInterval(_xID);
            _inX = false;
            _loc2 = _val = _targVal;
            eventObj.type = evtReachTarg;
            eventObj.val = _loc2;
            this.dispatchEvent(eventObj);
        } // end if
        this.setNeedle(_loc2);
        _val = _loc2;
    } // End of the function
    function set val(v)
    {
        if (_inX)
        {
            clearInterval(_xID);
            _inX = false;
            _targVal = v;
        } // end if
        this.setNeedle(v);
        _val = v;
        //return (this.val());
        null;
    } // End of the function
    function get val()
    {
        return (_val);
    } // End of the function
    var className = "FMXISRoundDialSmooth";
    static var symbolOwner = mx.fmxis.FMXISRoundDialSmooth;
    static var symbolName = "FMXISRoundDialSmooth";
    var clipParameters = {units: 1, showBack: 1, centerVis: 1, nXScale: 1, nYScale: 1, val: 1, bkgndLinkID: 1, centerLinkID: 1, needleLinkID: 1, needleRate: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISRoundDialSmooth.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
    static var dialEvents = new Array("onReachTarg");
    var myEvents = mx.fmxis.FMXISRoundDialSmooth.dialEvents;
} // End of Class
