class mx.fmxis.FMXISButtonRepeater extends mx.fmxis.FMXISButton
{
    var pulseFreq, mcButDown, mcButUp, wait4Start, intID, evtPress, genEvent;
    function FMXISButtonRepeater()
    {
        super();
    } // End of the function
    function init(evts)
    {
        super.init(evts);
        pulseFreq = Math.max(pulseFreq, 10);
    } // End of the function
    function setDown(state)
    {
        mcButDown._visible = state;
        mcButUp._visible = !state;
        if (state)
        {
            if (wait4Start != -1)
            {
                if (intID != undefined)
                {
                    clearInterval(intID);
                } // end if
                intID = setInterval(this, "waitElapse", wait4Start);
            } // end if
        }
        else
        {
            clearInterval(intID);
            intID = undefined;
        } // end else if
    } // End of the function
    function genDownEvent()
    {
        this.genEvent(evtPress, true);
    } // End of the function
    function waitElapse()
    {
        if (intID != null)
        {
            clearInterval(intID);
        } // end if
        intID = setInterval(this, "genDownEvent", pulseFreq);
    } // End of the function
    var className = "FMXISButtonRepeater";
    static var symbolOwner = mx.fmxis.FMXISButtonRepeater;
    static var symbolName = "FMXISButtonRepeater";
    var clipParameters = {listener: 1, evtPress: 1, evtRelease: 1, evtReleaseOutside: 1, evtRollOver: 1, evtRollOut: 1, evtDragOut: 1, pulseFreq: 1, wait4Start: 1, showHand: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISButtonRepeater.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
} // End of Class
