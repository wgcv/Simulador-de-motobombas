class mx.fmxis.FMXISButton extends mx.fmxis.FMXISBase
{
    var useHandCursor, _showHand, __get__showHand, evtPress, evtRelease, evtReleaseOutside, evtRollOver, evtRollOut, evtDragOut, allowEvents, attachMovie, eventObj, dispatchEvent, mcButDown, mcButUp, __set__showHand;
    function FMXISButton()
    {
        super();
        this.setDown(false);
    } // End of the function
    function set showHand(f)
    {
        useHandCursor = f;
        _showHand = f;
        //return (this.showHand());
        null;
    } // End of the function
    function get showHand()
    {
        return (_showHand);
    } // End of the function
    function init(evts)
    {
        if (myEvents[0] != evtPress || myEvents[1] != evtRelease || myEvents[2] != evtReleaseOutside || myEvents[3] != evtRollOver || myEvents[4] != evtRollOut || myEvents[5] != evtDragOut || evts != null)
        {
            myEvents = new Array(evtPress, evtRelease, evtReleaseOutside, evtRollOver, evtRollOut, evtDragOut, "disabled");
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
        useHandCursor = _showHand;
        allowEvents = true;
        this.attachChildren();
    } // End of the function
    function attachChildren(up, down)
    {
        if (down != false)
        {
            this.attachMovie("defaultButDn", "mcButDown", 2);
        } // end if
        if (up != false)
        {
            this.attachMovie("defaultButUp", "mcButUp", 1);
        } // end if
    } // End of the function
    function onPress(q)
    {
        if (!allowEvents)
        {
            eventObj.type = "disabled";
            eventObj.val = evtPress;
            this.dispatchEvent(eventObj);
            return;
        } // end if
        this.setDown(true);
        if (!q)
        {
            this.genEvent(evtPress, true);
        } // end if
    } // End of the function
    function onRelease(q)
    {
        if (!allowEvents)
        {
            eventObj.type = "disabled";
            eventObj.val = evtRelease;
            this.dispatchEvent(eventObj);
            return;
        } // end if
        this.setDown(false);
        if (!q)
        {
            this.genEvent(evtRelease, false);
        } // end if
    } // End of the function
    function onReleaseOutside(q)
    {
        if (!allowEvents)
        {
            eventObj.type = "disabled";
            eventObj.val = evtReleaseOutside;
            this.dispatchEvent(eventObj);
            return;
        } // end if
        this.setDown(false);
        if (!q)
        {
            this.genEvent(evtReleaseOutside, false);
        } // end if
    } // End of the function
    function onRollOver(q)
    {
        if (!allowEvents)
        {
            eventObj.type = "disabled";
            eventObj.val = evtRollOver;
            this.dispatchEvent(eventObj);
            return;
        } // end if
        if (!q)
        {
            this.genEvent(evtRollOver, false);
        } // end if
    } // End of the function
    function onRollOut(q)
    {
        if (!allowEvents)
        {
            eventObj.type = "disabled";
            eventObj.val = evtRollOut;
            this.dispatchEvent(eventObj);
            return;
        } // end if
        if (!q)
        {
            this.genEvent(evtRollOut, false);
        } // end if
    } // End of the function
    function onDragOut(q)
    {
        if (!allowEvents)
        {
            return;
        } // end if
        if (!q)
        {
            this.genEvent(evtDragOut, false);
        } // end if
    } // End of the function
    function execEvent(evtName, evtVal, q)
    {
        switch (evtName)
        {
            case myEvents[0]:
            {
                this.onPress(q);
                break;
            } 
            case myEvents[1]:
            {
                this.onRelease(q);
                break;
            } 
            case myEvents[2]:
            {
                this.onReleaseOutside(q);
                break;
            } 
            case myEvents[3]:
            {
                this.onRollOver(q);
                break;
            } 
            case myEvents[4]:
            {
                this.onRollOut(q);
                break;
            } 
            case myEvents[5]:
            {
                this.onDragOut(q);
                break;
            } 
        } // End of switch
    } // End of the function
    function setDown(state)
    {
        mcButDown._visible = state;
        mcButUp._visible = !state;
    } // End of the function
    function genEvent(msg, upState)
    {
        eventObj.type = msg;
        eventObj.down = upState;
        this.dispatchEvent(eventObj);
    } // End of the function
    var className = "FMXISButton";
    static var symbolOwner = mx.fmxis.FMXISButton;
    static var symbolName = "FMXISButton";
    var clipParameters = {listener: 1, evtPress: 1, evtRelease: 1, evtReleaseOutside: 1, evtRollOver: 1, evtRollOut: 1, evtDragOut: 1, showHand: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISButton.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
    static var buttonEvents = new Array("onPress", "onRelease", "onReleaseOutside", "onRollOver", "onRollOut", "onDragOut", "disabled");
    var myEvents = mx.fmxis.FMXISButton.buttonEvents;
} // End of Class
