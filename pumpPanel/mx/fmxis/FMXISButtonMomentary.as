class mx.fmxis.FMXISButtonMomentary extends mx.fmxis.FMXISButtonRepeater
{
    var _ulID, invalidate, __get__UpLinkID, _dlID, __get__DownLinkID, ouc, attachMovie, mcButUp, odc, mcButDown, __set__DownLinkID, __set__UpLinkID;
    function FMXISButtonMomentary()
    {
        super();
    } // End of the function
    function set UpLinkID(id)
    {
        _ulID = id;
        this.invalidate();
        //return (this.UpLinkID());
        null;
    } // End of the function
    function get UpLinkID()
    {
        return (_ulID);
    } // End of the function
    function set DownLinkID(id)
    {
        _dlID = id;
        this.invalidate();
        //return (this.DownLinkID());
        null;
    } // End of the function
    function get DownLinkID()
    {
        return (_dlID);
    } // End of the function
    function attachChildren()
    {
        super.attachChildren(_ulID == "", _dlID == "");
    } // End of the function
    function draw()
    {
        if (_ulID != "")
        {
            this.setUpTile(_ulID);
        } // end if
        if (_dlID != "")
        {
            this.setDownTile(_dlID);
        } // end if
    } // End of the function
    function setUpTile(id)
    {
        if (id == "" || id == undefined)
        {
            return;
        } // end if
        ouc.removeMovieClip();
        this.attachMovie(id, "ouc", 1);
        mcButUp = ouc;
        mcButUp._visible = true;
    } // End of the function
    function setDownTile(id)
    {
        if (id == "" || id == undefined)
        {
            return;
        } // end if
        odc.removeMovieClip();
        this.attachMovie(id, "odc", 2);
        mcButDown = odc;
        mcButDown._visible = false;
    } // End of the function
    var className = "FMXISButtonMomentary";
    static var symbolOwner = mx.fmxis.FMXISButtonMomentary;
    static var symbolName = "FMXISButtonMomentary";
    var clipParameters = {listener: 1, evtPress: 1, evtRelease: 1, evtReleaseOutside: 1, evtRollOver: 1, evtRollOut: 1, evtDragOut: 1, pulseFreq: 1, wait4Start: 1, showHand: 1, UpLinkID: 1, DownLinkID: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISButtonMomentary.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
} // End of Class
