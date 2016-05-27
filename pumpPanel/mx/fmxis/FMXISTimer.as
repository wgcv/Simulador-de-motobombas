class mx.fmxis.FMXISTimer extends mx.fmxis.FMXISBase
{
    var __get__nIters, _nIters, __get__intvl, _intvl, evtElapsed, boundingBoxClip, active, _loopCt, _tID, eventObj, dispatchEvent, __set__intvl, __set__nIters;
    function FMXISTimer()
    {
        super();
    } // End of the function
    function set nIters(v)
    {
        this.setIterations(v);
        //return (this.nIters());
        null;
    } // End of the function
    function get nIters()
    {
        return (_nIters);
    } // End of the function
    function set intvl(v)
    {
        this.setTimingInterval(v);
        //return (this.intvl());
        null;
    } // End of the function
    function get intvl()
    {
        return (_intvl);
    } // End of the function
    function init(evts)
    {
        if (myEvents[0] != evtElapsed || evts != null)
        {
            myEvents = new Array(evtElapsed);
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
        boundingBoxClip._visible = false;
    } // End of the function
    function start()
    {
        if (active)
        {
            this.reset();
        } // end if
        if (_nIters != 0)
        {
            _loopCt = _nIters;
            _tID = setInterval(this, "TimerCbk", _intvl);
            active = true;
        } // end if
    } // End of the function
    function TimerCbk()
    {
        eventObj.type = evtElapsed;
        _loopCt = _loopCt - 1;
        eventObj.val = _nIters == -1 ? (-1) : (_loopCt);
        if (_loopCt == 0)
        {
            this.reset();
        } // end if
        this.dispatchEvent(eventObj);
    } // End of the function
    function reset()
    {
        if (active)
        {
            clearInterval(_tID);
            _tID = undefined;
            active = false;
        } // end if
    } // End of the function
    function isActive()
    {
        return (active);
    } // End of the function
    function setTimingInterval(v)
    {
        if (active)
        {
            this.reset();
            this.start();
        } // end if
        _intvl = v;
    } // End of the function
    function setIterations(v)
    {
        if (active)
        {
            _loopCt = v;
        } // end if
        _nIters = v;
    } // End of the function
    var className = "FMXISTimer";
    static var symbolOwner = mx.fmxis.FMXISTimer;
    static var symbolName = "FMXISTimer";
    var clipParameters = {listener: 1, evtElapsed: 1, intvl: 1, nIters: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISTimer.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
    static var buttonEvents = new Array("onElapsed");
    var myEvents = mx.fmxis.FMXISTimer.buttonEvents;
} // End of Class
