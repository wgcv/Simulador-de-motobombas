class mx.fmxis.FMXISAlphaNum extends mx.fmxis.FMXISDigits
{
    var _numDigs, _digs2Del, invalidate, __get__numDigs, setVal, __get__val, pval, _leftJust, __get__leftJust, myEvents, evtOverflow, digPBkgndID, attachMovie, digsOn, eventObj, dispatchEvent, digs, __set__leftJust, __set__numDigs, __set__val;
    function FMXISAlphaNum()
    {
        super();
    } // End of the function
    function set numDigs(v)
    {
        _digs2Del = _numDigs;
        _numDigs = v;
        this.invalidate();
        //return (this.numDigs());
        null;
    } // End of the function
    function get numDigs()
    {
        return (_numDigs);
    } // End of the function
    function set val(v)
    {
        this.setVal(v);
        //return (this.val());
        null;
    } // End of the function
    function get val()
    {
        return (pval);
    } // End of the function
    function set leftJust(v)
    {
        _leftJust = v;
        this.update();
        //return (this.leftJust());
        null;
    } // End of the function
    function get leftJust()
    {
        return (_leftJust);
    } // End of the function
    function init(evts)
    {
        if (myEvents[0] != evtOverflow || evts != null)
        {
            myEvents = [evtOverflow];
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
        var _loc4 = parseFloat(pval);
        if (isFinite(_loc4))
        {
            pval = _loc4;
        } // end if
        this.setVal(pval);
    } // End of the function
    function attachChildren()
    {
        var _loc2 = "defDigXPlusBkgnd";
        if (digPBkgndID != "" && digPBkgndID != undefined)
        {
            _loc2 = digPBkgndID;
        } // end if
        this.attachMovie(_loc2, "digEx", 0);
    } // End of the function
    function update()
    {
        if (typeof(pval) == "number")
        {
            super.update();
            return;
        } // end if
        var _loc3;
        var _loc5;
        var _loc4;
        var _loc6;
        var _loc7 = Math.min(this.__get__numDigs(), pval.length);
        if (digsOn)
        {
            _loc5 = this.__get__leftJust() ? (0) : (this.__get__numDigs() - _loc7);
            if (pval.length > this.__get__numDigs())
            {
                eventObj.type = evtOverflow;
                eventObj.val = pval;
                this.dispatchEvent(eventObj);
            } // end if
            for (var _loc3 = _loc5; _loc3 < _loc5 + _loc7; ++_loc3)
            {
                _loc6 = _loc3 - _loc5;
                _loc4 = pval.charCodeAt(_loc6);
                if (_loc4 >= 95)
                {
                    _loc4 = _loc4 - 32;
                } // end if
                if (_loc4 >= 65 && _loc4 <= 90)
                {
                    digs[_loc3].dig.gotoAndStop(12 + (_loc4 - 65));
                }
                else if (_loc4 >= 48 && _loc4 <= 57)
                {
                    digs[_loc3].dig.gotoAndStop(1 + (_loc4 - 48));
                }
                else if (_loc4 == 32)
                {
                    digs[_loc3].dig.gotoAndStop(38);
                }
                else if (_loc4 == 45)
                {
                    digs[_loc3].dig.gotoAndStop(11);
                }
                else if (_loc4 == 58)
                {
                    digs[_loc3].dig.gotoAndStop(39);
                }
                else if (_loc4 == 39)
                {
                    digs[_loc3].dig.gotoAndStop(40);
                }
                else if (_loc4 == 46)
                {
                    digs[_loc3].dig.gotoAndStop(41);
                } // end else if
                digs[_loc3].dig._visible = true;
                digs[_loc3].dig.dpt._visible = false;
            } // end of for
            if (this.__get__leftJust())
            {
                while (_loc3 < this.__get__numDigs())
                {
                    digs[_loc3].dig._visible = false;
                    ++_loc3;
                } // end while
            }
            else
            {
                for (var _loc3 = 0; _loc3 < _loc5; ++_loc3)
                {
                    digs[_loc3].dig._visible = false;
                } // end of for
            } // end else if
        }
        else
        {
            for (var _loc3 = 0; _loc3 < this.__get__numDigs(); ++_loc3)
            {
                digs[_loc3].dig._visible = false;
            } // end of for
        } // end else if
    } // End of the function
    var className = "FMXISAlphaNum";
    static var symbolOwner = mx.fmxis.FMXISAlphaNum;
    static var symbolName = "FMXISAlphaNum";
    var clipParameters = {listener: 1, evtOverflow: 1, numDigs: 1, val: 1, digPBkgnd: 1, leadZero: 1, decPl: 1, digTint: 1, showBkgnd: 1, display: 1, leftJust: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISAlphaNum.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
} // End of Class
