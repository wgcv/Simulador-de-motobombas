class mx.fmxis.FMXISJoystick extends mx.fmxis.FMXISBase
{
    var _centerEPS, __get__centerEPS, _kSticky, __get__kSticky, __get__pulseFreq, _pulseFreq, _maxVal, __get__maxVal, useHandCursor, _showHand, __get__showHand, hsExactX, limit, hsExactY, centerPx, _parent, onMouseMove, active, _pulseID, baseID, stickID, hsID, attachMovie, evtJChg, evtJPulse, evtJReturned, evtJStart, evtJReleased, allowEvents, hs, stk, stickLen, zeroCall, onEnterFrame, eventObj, dispatchEvent, forceInt, __set__centerEPS, __set__kSticky, __set__maxVal, __set__pulseFreq, __set__showHand;
    function FMXISJoystick()
    {
        super();
    } // End of the function
    function set centerEPS(v)
    {
        _centerEPS = v;
        this.resetCenter();
        //return (this.centerEPS());
        null;
    } // End of the function
    function get centerEPS()
    {
        return (_centerEPS);
    } // End of the function
    function set kSticky(v)
    {
        _kSticky = Math.min(1, Math.max(0, v));
        //return (this.kSticky());
        null;
    } // End of the function
    function get kSticky()
    {
        return (_kSticky);
    } // End of the function
    function set pulseFreq(v)
    {
        this.chgPulseFreq(v);
        //return (this.pulseFreq());
        null;
    } // End of the function
    function get pulseFreq()
    {
        return (_pulseFreq);
    } // End of the function
    function set maxVal(v)
    {
        _maxVal = v;
        this.resetCenter();
        //return (this.maxVal());
        null;
    } // End of the function
    function get maxVal()
    {
        return (_maxVal);
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
    function getVec()
    {
        ptObj.x = hsExactX / limit * _maxVal;
        ptObj.y = -hsExactY / limit * _maxVal;
        return (ptObj);
    } // End of the function
    function setVec(x, y)
    {
        this.setXY(x / _maxVal * limit, -y / _maxVal * limit);
    } // End of the function
    function resetCenter()
    {
        centerPx = _centerEPS / _maxVal * limit;
    } // End of the function
    function moveHS(noMouse, q)
    {
        var _loc2 = noMouse == undefined ? (_parent) : (this);
        if (!_loc2.allowEvents)
        {
            _loc2.eventObj.type = "disabled";
            _loc2.dispatchEvent(_loc2.eventObj);
            return;
        } // end if
        if (noMouse == undefined)
        {
            onMouseMove = _loc2.trackHS;
        } // end if
        if (!q)
        {
            _loc2.eventObj.type = _loc2.evtJStart;
            _loc2.dispatchEvent(_loc2.eventObj);
        } // end if
        delete _loc2.hs.onEnterFrame;
        if (_loc2._pulseID == undefined)
        {
            _loc2._pulseID = setInterval(_loc2, "genPulse", _loc2._pulseFreq);
        } // end if
        active = true;
    } // End of the function
    function stopMoveHS(noMouse, quiet)
    {
        var _loc2 = noMouse == undefined ? (_parent) : (this);
        if (!_loc2.allowEvents)
        {
            return;
        } // end if
        if (noMouse == undefined)
        {
            delete _loc2.hs.onMouseMove;
        } // end if
        if (_loc2.kSticky < 1)
        {
            _loc2.hs.onEnterFrame = _loc2.return2Center;
            if (!quiet)
            {
                _loc2.computeJPosition();
                _loc2.eventObj.type = _loc2.evtJReleased;
                _loc2.eventObj.val = _loc2.ptObj;
                _loc2.dispatchEvent(_loc2.eventObj);
            } // end if
        } // end if
    } // End of the function
    function chgPulseFreq(pf)
    {
        _pulseFreq = pf;
        if (active)
        {
            clearInterval(_pulseID);
            if (pf != -1)
            {
                _pulseID = setInterval(this, "genPulse", _pulseFreq);
            } // end if
        } // end if
    } // End of the function
    function attachChildren()
    {
        var _loc4 = "defJStkBase";
        var _loc3 = "defJStkStick";
        var _loc2 = "defJStkHotSpot";
        if (baseID != "" && baseID != undefined)
        {
            _loc4 = baseID;
        } // end if
        if (stickID != "" && stickID != undefined)
        {
            _loc3 = stickID;
        } // end if
        if (hsID != "" && hsID != undefined)
        {
            _loc2 = hsID;
        } // end if
        this.attachMovie(_loc4, "bkgnd", 1);
        this.attachMovie(_loc3, "stk", 2);
        this.attachMovie(_loc2, "hs", 3);
    } // End of the function
    function init(evts)
    {
        if (myEvents[0] != evtJChg || myEvents[1] != evtJPulse || myEvents[2] != evtJReturned || myEvents[3] != evtJStart || myEvents[4] != evtJReleased || evts != null)
        {
            myEvents = new Array(evtJChg, evtJPulse, evtJReturned, evtJStart, evtJReleased, "disabled");
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
        hs._x = 0;
        hs._y = -stk._height;
        limit = Math.sqrt(hs._x * hs._x + hs._y * hs._y);
        stickLen = stk._height;
        this.resetCenter();
        active = false;
        hs._x = hs._y = hsExactX = hsExactY = 0;
        zeroCall = false;
        this.setStick();
        hs.onPress = moveHS;
        hs.onRelease = hs.onReleaseOutside = stopMoveHS;
        hs.useHandCursor = showHand;
    } // End of the function
    function setStick()
    {
        var _loc3 = hs._x;
        var _loc2 = hs._y;
        var _loc4;
        var _loc5;
        var _loc6;
        _loc4 = Math.sqrt(_loc3 * _loc3 + _loc2 * _loc2);
        if (_loc4 != 0)
        {
            _loc2 = _loc2 / _loc4;
            _loc6 = -_loc2;
            _loc5 = 57.295780 * Math.acos(_loc6);
            if (_loc3 < 0)
            {
                _loc5 = _loc5 * -1;
            } // end if
            stk._rotation = _loc5;
        } // end if
        stk._yscale = 100 * (_loc4 / stickLen);
    } // End of the function
    function return2Center()
    {
        var x = this._parent.hs._x;
        var y = this._parent.hs._y;
        var coeff;
        var len;
        len = Math.sqrt(x * x + y * y);
        if (len < this._parent.centerPx)
        {
            coeff = 0;
        }
        else
        {
            coeff = this._parent.kSticky;
        } // end else if
        this._parent.hs._x = this._parent.hsExactX = coeff * x;
        this._parent.hs._y = this._parent.hsExactY = coeff * y;
        this._parent.setStick();
        if (coeff == 0)
        {
            this.active = false;
            delete this.onEnterFrame;
            this._parent.genPulse(true);
            with (this._parent)
            {
                clearInterval(_pulseID);
                _pulseID = undefined;
                eventObj.type = evtJReturned;
                eventObj.val = undefined;
                dispatchEvent(eventObj);
            } // End of with
        }
        else
        {
            this._parent.genPulse(true);
        } // end else if
    } // End of the function
    function trackHS()
    {
        _parent.setXY(_parent._xmouse, _parent._ymouse);
        _parent.genPulse(true);
    } // End of the function
    function setXY(x, y)
    {
        var _loc2;
        var _loc5;
        var _loc4;
        var _loc3;
        _loc2 = Math.sqrt(x * x + y * y);
        if (_loc2 < centerPx)
        {
            _loc4 = 0;
            _loc5 = 0;
            _loc3 = 0;
        }
        else
        {
            _loc5 = x / _loc2;
            _loc4 = y / _loc2;
            _loc3 = Math.min(_loc2, limit);
        } // end else if
        hs._x = hsExactX = _loc3 * _loc5;
        hs._y = hsExactY = _loc3 * _loc4;
        this.setStick();
    } // End of the function
    function genPulse(chg)
    {
        this.computeJPosition();
        if (zeroCall || ptObj.x != 0 || ptObj.y != 0)
        {
            eventObj.type = chg ? (evtJChg) : (evtJPulse);
            eventObj.val = ptObj;
            if (!chg)
            {
                var _loc3 = 5;
            } // end if
            this.dispatchEvent(eventObj);
            zeroCall = ptObj.x != 0 || ptObj.y != 0;
        } // end if
    } // End of the function
    function computeJPosition()
    {
        var _loc3 = hsExactX;
        var _loc2 = hsExactY;
        ptObj.x = _maxVal * (_loc3 / limit);
        ptObj.y = -_maxVal * (_loc2 / limit);
        if (forceInt)
        {
            ptObj.x = Math.round(ptObj.x);
            ptObj.y = Math.round(ptObj.y);
        } // end if
    } // End of the function
    function execEvent(evtName, evtVal, q)
    {
        switch (evtName)
        {
            case myEvents[0]:
            {
                this.setVec(evtVal.x, evtVal.y);
                break;
            } 
            case myEvents[2]:
            {
                this.setVec(0, 0);
                if (!q)
                {
                    eventObj.type = evtJReturned;
                    eventObj.val = undefined;
                    this.dispatchEvent(eventObj);
                } // end if
                break;
            } 
            case myEvents[3]:
            {
                this.moveHS(true, q);
                break;
            } 
            case myEvents[4]:
            {
                this.stopMoveHS(true, q);
                break;
            } 
        } // End of switch
    } // End of the function
    var className = "FMXISJoystick";
    static var symbolOwner = mx.fmxis.FMXISJoystick;
    static var symbolName = "FMXISJoystick";
    var clipParameters = {listener: 1, evtJChg: 1, evtJReturned: 1, evtJReleased: 1, evtJStart: 1, evtJPulse: 1, maxVal: 1, forceInt: 1, baseID: 1, stickID: 1, hsID: 1, centerEPS: 1, kSticky: 1, pulseFreq: 1, showHand: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISJoystick.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
    static var jstickEvents = new Array("onJChg", "onJPulse", "onJReturned", "onJStart", "evtJReleased", "disabled");
    var myEvents = mx.fmxis.FMXISJoystick.jstickEvents;
    var ptObj = {x: 0, y: 0};
} // End of Class
