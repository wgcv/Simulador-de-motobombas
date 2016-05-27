class mx.fmxis.FMXISRoundDial extends mx.fmxis.FMXISBase
{
    var _val, __get__val, h, _nXScale, __get__nXScale, _nYScale, __get__nYScale, dCenter, _centerVis, __get__centerVis, bkgnd, _showBack, __get__showBack, needleLinkID, bkgndLinkID, centerLinkID, attachMovie, units, __set__centerVis, __set__nXScale, __set__nYScale, __set__showBack, __set__val;
    function FMXISRoundDial()
    {
        super();
    } // End of the function
    function set val(v)
    {
        this.setNeedle(v);
        _val = v;
        //return (this.val());
        null;
    } // End of the function
    function get val()
    {
        return (_val);
    } // End of the function
    function set nXScale(v)
    {
        h._xscale = v;
        _nXScale = v;
        //return (this.nXScale());
        null;
    } // End of the function
    function get nXScale()
    {
        return (_nXScale);
    } // End of the function
    function set nYScale(v)
    {
        h._yscale = v;
        _nYScale = v;
        //return (this.nYScale());
        null;
    } // End of the function
    function get nYScale()
    {
        return (_nYScale);
    } // End of the function
    function set centerVis(f)
    {
        dCenter._visible = _centerVis = f;
        //return (this.centerVis());
        null;
    } // End of the function
    function get centerVis()
    {
        return (_centerVis);
    } // End of the function
    function set showBack(f)
    {
        bkgnd._visible = _showBack = f;
        //return (this.showBack());
        null;
    } // End of the function
    function get showBack()
    {
        return (_showBack);
    } // End of the function
    function init(evts)
    {
        super.init(evts);
        this.attachChildren();
        bkgnd._visible = _showBack;
        dCenter._visible = _centerVis;
        h._xscale = _nXScale;
        h._yscale = _nYScale;
        this.setNeedle(_val);
    } // End of the function
    function attachChildren()
    {
        var _loc4 = needleLinkID == "" ? ("defRoundDialHand") : (needleLinkID);
        var _loc2 = bkgndLinkID == "" ? ("defRoundDialBkgnd") : (bkgndLinkID);
        var _loc3 = centerLinkID == "" ? ("defRoundDialCenter") : (centerLinkID);
        this.attachMovie(_loc2, "bkgnd", 1);
        this.attachMovie(_loc4, "h", 2);
        this.attachMovie(_loc3, "dCenter", 3);
    } // End of the function
    function setNeedle(v)
    {
        v = v % units;
        if (v < 0)
        {
            v = units + v;
        } // end if
        h._rotation = 360 * v / units;
    } // End of the function
    function setNumUnits(nu)
    {
        units = nu;
        this.setNeedle(_val);
    } // End of the function
    var className = "FMXISRoundDial";
    static var symbolOwner = mx.fmxis.FMXISRoundDial;
    static var symbolName = "FMXISRoundDial";
    var clipParameters = {listener: 1, units: 1, showBack: 1, centerVis: 1, nXScale: 1, nYScale: 1, val: 1, bkgndLinkID: 1, centerLinkID: 1, needleLinkID: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISRoundDial.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
} // End of Class
