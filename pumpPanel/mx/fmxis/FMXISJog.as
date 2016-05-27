class mx.fmxis.FMXISJog extends mx.fmxis.FMXISBase
{
    var _discreteSteps, _val, __get__discreteSteps, _showTicks, tickClip, __get__showTicks, _numTicks, __get__numTicks, _units, __get__units, __get__val, _clickSnd, __get__clickSnd, rotIncr, rotDecr, _showButs, __get__showButs, vChg, baseAng, oldAng, dragOrOver, bkgnd, lastIntVal, showHand, allowEvents, showBkgnd, bkgndLinkID, attachMovie, indLinkID, _parent, onMouseMove, _xmouse, _ymouse, valPriv, holdAng, ind, snap2Int, sndObj, eventObj, dispatchEvent, createEmptyMovieClip, __set__clickSnd, __set__discreteSteps, __set__numTicks, __set__showButs, __set__showTicks, __set__units, __set__val;
    function FMXISJog()
    {
        super();
    } // End of the function
    function set discreteSteps(f)
    {
        _discreteSteps = f;
        this.setVal(_val, true);
        //return (this.discreteSteps());
        null;
    } // End of the function
    function get discreteSteps()
    {
        return (_discreteSteps);
    } // End of the function
    function set showTicks(f)
    {
        _showTicks = f;
        if (f)
        {
            this.drawTicks();
        } // end if
        tickClip._visible = f;
        //return (this.showTicks());
        null;
    } // End of the function
    function get showTicks()
    {
        return (_showTicks);
    } // End of the function
    function set numTicks(n)
    {
        _numTicks = n;
        if (_showTicks)
        {
            this.drawTicks();
        } // end if
        //return (this.numTicks());
        null;
    } // End of the function
    function get numTicks()
    {
        return (_numTicks);
    } // End of the function
    function set units(v)
    {
        _units = v;
        this.setVal(_val, true);
        //return (this.units());
        null;
    } // End of the function
    function get units()
    {
        return (_units);
    } // End of the function
    function set val(v)
    {
        this.setVal(v, true);
        //return (this.val());
        null;
    } // End of the function
    function get val()
    {
        return (_val);
    } // End of the function
    function set clickSnd(s)
    {
        this.setClickSound(s);
        _clickSnd = s;
        //return (this.clickSnd());
        null;
    } // End of the function
    function get clickSnd()
    {
        return (_clickSnd);
    } // End of the function
    function set showButs(f)
    {
        rotIncr._visible = rotDecr._visible = _showButs = f;
        //return (this.showButs());
        null;
    } // End of the function
    function get showButs()
    {
        return (_showButs);
    } // End of the function
    function init(evts)
    {
        if (myEvents[0] != vChg || evts != null)
        {
            myEvents = [vChg, "disabled"];
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
        this.attachChildren();
        oldAng = baseAng = 0;
        if (dragOrOver == "drag")
        {
            bkgnd.onPress = jogEngage;
            bkgnd.onRelease = jogRelease;
            bkgnd.onReleaseOutside = jogRelease;
        }
        else
        {
            bkgnd.onRollOver = jogEngage;
            bkgnd.onRollOut = jogRelease;
        } // end else if
        lastIntVal = int(_val);
        this.setVal(_val, true);
        rotIncr.onPress = incrJog;
        rotDecr.onPress = decrJog;
        rotIncr._visible = rotDecr._visible = _showButs;
        if (this.__get__clickSnd() != "")
        {
            this.setClickSound(this.__get__clickSnd());
        } // end if
        if (_showTicks)
        {
            this.drawTicks();
        } // end if
        bkgnd.useHandCursor = showHand;
        allowEvents = true;
        bkgnd._alpha = showBkgnd ? (100) : (0);
    } // End of the function
    function attachChildren()
    {
        var _loc2 = "defJogBkgnd";
        if (bkgndLinkID != undefined && bkgndLinkID != "")
        {
            _loc2 = bkgndLinkID;
        } // end if
        this.attachMovie(_loc2, "bkgnd", 1);
        this.attachMovie("defJogIncr", "rotIncr", 2);
        this.attachMovie("defJogDecr", "rotDecr", 3);
        rotIncr._x = 30;
        rotIncr._y = 90;
        rotDecr._x = -30;
        rotDecr._y = 90;
        if (indLinkID != undefined && indLinkID != "")
        {
            this.attachMovie(indLinkID, "ind", 4);
        }
        else
        {
            this.attachMovie("defJogIndicator", "ind", 4);
        } // end else if
    } // End of the function
    function jogEngage()
    {
        if (!_parent.allowEvents)
        {
            _parent.eventObj.type = "disabled";
            _parent.dispatchEvent(_parent.eventObj);
            return;
        } // end if
        _parent.holdAng = undefined;
        _parent._beginVal = _parent._val;
        onMouseMove = _parent.trackMouse;
    } // End of the function
    function jogRelease()
    {
        if (!_parent.allowEvents)
        {
            return;
        } // end if
        if (_parent.snap2Int)
        {
            _parent.setVal(Math.round(_parent._val));
            if (_parent._val == _parent._beginVal)
            {
                if (_parent.sndObj != undefined)
                {
                    _parent.sndObj.start();
                } // end if
                _parent.genEvent(0);
            } // end if
        } // end if
        delete this.onMouseMove;
    } // End of the function
    function trackMouse()
    {
        var _loc4;
        var _loc2;
        var _loc6;
        var _loc5;
        var _loc7;
        var _loc3;
        _loc4 = _xmouse;
        _loc2 = _ymouse;
        _loc6 = _loc4 < 0;
        _loc5 = Math.sqrt(_loc4 * _loc4 + _loc2 * _loc2);
        if (_loc5 == 0)
        {
            return;
        } // end if
        _loc2 = _loc2 / _loc5;
        _loc7 = -_loc2;
        _loc3 = 57.295780 * Math.acos(_loc7);
        if (_loc6)
        {
            _loc3 = _loc3 * -1;
        } // end if
        if (_parent.holdAng == undefined)
        {
            _parent.holdAng = _loc3;
        } // end if
        _parent.baseAng = _parent.baseAng + (_loc3 - _parent.holdAng);
        _parent.setAVal(_parent.baseAng, _loc3);
        updateAfterEvent();
    } // End of the function
    function setAVal(ang, realAng)
    {
        var _loc2 = ang - oldAng;
        var _loc3;
        var _loc5 = _val;
        if (ang > oldAng)
        {
            if (_loc2 > 180)
            {
                _loc2 = _loc2 - 360;
            } // end if
        }
        else if (_loc2 < -180)
        {
            _loc2 = _loc2 + 360;
        } // end else if
        oldAng = ang;
        _loc3 = _units * _loc2 / 360;
        valPriv = valPriv + _loc3;
        this.setVal(valPriv);
        holdAng = realAng;
    } // End of the function
    function incrJog()
    {
        _parent.incrVal(1);
    } // End of the function
    function decrJog()
    {
        _parent.incrVal(-1);
    } // End of the function
    function incrVal(incr, q)
    {
        this.setVal(_val + incr, q);
    } // End of the function
    function setVal(v, q)
    {
        var _loc3 = v % _units;
        var _loc4;
        var _loc2 = _val;
        valPriv = v;
        _loc4 = 360 / _units * _loc3;
        if (_discreteSteps)
        {
            _val = Math.round(valPriv);
            ind._rotation = 360 / _units * (_val % _units);
        }
        else
        {
            _val = valPriv;
            ind._rotation = _loc4;
        } // end else if
        if (_val != _loc2 && q != true)
        {
            if (!snap2Int && !_discreteSteps)
            {
                this.genEvent(_val - _loc2);
                sndObj.start();
            }
            else if (_discreteSteps && Math.abs(_val - _loc2) >= 1)
            {
                this.genEvent(_val - _loc2);
                sndObj.start();
            }
            else if (snap2Int && Math.abs(valPriv - lastIntVal) >= 1)
            {
                if (lastIntVal != _val)
                {
                    this.genEvent(Math.round(valPriv - lastIntVal));
                    sndObj.start();
                } // end if
                lastIntVal = Math.round(valPriv);
            } // end else if
        } // end else if
    } // End of the function
    function genEvent(v)
    {
        eventObj.type = vChg;
        eventObj.val = v;
        this.dispatchEvent(eventObj);
    } // End of the function
    function drawTicks()
    {
        var _loc5 = 5 + bkgnd._width / 2;
        var _loc4 = 360 / _numTicks;
        var _loc3;
        if (tickClip != undefined)
        {
            tickClip.removeMovieClip();
        } // end if
        this.createEmptyMovieClip("tickClip", -100);
        tickClip.clear();
        tickClip.lineStyle(0);
        _loc3 = new Object();
        _loc3.x = 0;
        _loc3.y = -_loc5;
        for (var _loc2 = 0; _loc2 < 360; _loc2 = _loc2 + _loc4)
        {
            this.rotZ(_loc3, _loc2);
            tickClip.moveTo(0, 0);
            tickClip.lineTo(_loc3.xp, _loc3.yp);
        } // end of for
        false;
    } // End of the function
    function rotZ(vObj, ang)
    {
        ang = 0.017453 * ang;
        vObj.xp = Math.cos(ang) * vObj.x - Math.sin(ang) * vObj.y;
        vObj.yp = Math.sin(ang) * vObj.x + Math.cos(ang) * vObj.y;
    } // End of the function
    function setClickSound(s)
    {
        if (sndObj == undefined)
        {
            sndObj = new Sound(this);
        } // end if
        sndObj.attachSound(s);
    } // End of the function
    function execEvent(evName, evVal, q)
    {
        if (evName == myEvents[0])
        {
            this.incrVal(evVal, q);
        } // end if
    } // End of the function
    var className = "FMXISJog";
    static var symbolOwner = mx.fmxis.FMXISJog;
    static var symbolName = "FMXISJog";
    static var JogEvent = new Array("onValChg", "disabled");
    var myEvents = mx.fmxis.FMXISJog.JogEvent;
    var clipParameters = {listener: 1, vChg: 1, showBkgnd: 1, showHand: 1, showButs: 1, clickSnd: 1, units: 1, numTicks: 1, showTicks: 1, dragOrOver: 1, snap2Int: 1, discreteSteps: 1, val: 1, bkgndLinkID: 1, indLinkID: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISJog.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
} // End of Class
