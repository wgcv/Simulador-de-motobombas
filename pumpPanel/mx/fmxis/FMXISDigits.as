class mx.fmxis.FMXISDigits extends mx.fmxis.FMXISBase
{
    var _numDigs, _digs2Del, invalidate, __get__numDigs, _showBkgnd, __get__showBkgnd, digsOn, __get__display, _decPl, __get__decPl, _leadZero, __get__leadZero, _digTint, __get__digTint, pval, __get__val, digs, _width, origW, _height, origH, evtOverflow, _yscale, _xscale, oneCharWidth, oneCharHeight, digPBkgndID, attachMovie, digCols, digEx, eventObj, dispatchEvent, __set__decPl, __set__digTint, __set__display, __set__leadZero, __set__numDigs, __set__showBkgnd, __set__val;
    function FMXISDigits()
    {
        super();
        this.update();
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
    function set showBkgnd(v)
    {
        this.dispBkgnd(_showBkgnd = v);
        //return (this.showBkgnd());
        null;
    } // End of the function
    function get showBkgnd()
    {
        return (_showBkgnd);
    } // End of the function
    function set display(v)
    {
        this.displayDigs(digsOn = v);
        //return (this.display());
        null;
    } // End of the function
    function get display()
    {
        return (digsOn);
    } // End of the function
    function set decPl(v)
    {
        _decPl = v;
        this.invalidate();
        //return (this.decPl());
        null;
    } // End of the function
    function get decPl()
    {
        return (_decPl);
    } // End of the function
    function set leadZero(v)
    {
        this.chgLeadZero(_leadZero = v);
        //return (this.leadZero());
        null;
    } // End of the function
    function get leadZero()
    {
        return (_leadZero);
    } // End of the function
    function set digTint(v)
    {
        this.setDigColor(_digTint = v);
        //return (this.digTint());
        null;
    } // End of the function
    function get digTint()
    {
        return (_digTint);
    } // End of the function
    function set val(v)
    {
        this.setVal(pval = v);
        //return (this.val());
        null;
    } // End of the function
    function get val()
    {
        return (pval);
    } // End of the function
    function dispBkgnd(f)
    {
        for (var _loc2 = 0; _loc2 < _numDigs; ++_loc2)
        {
            digs[_loc2].bkgnd._visible = f == true;
        } // end of for
    } // End of the function
    function init(evts)
    {
        origW = _width;
        origH = _height;
        if (myEvents[0] != evtOverflow || evts != null)
        {
            myEvents = new Array(evtOverflow);
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
        _xscale = _yscale = 100;
        oneCharWidth = _width;
        oneCharHeight = _height;
        this.arrangeDigits(_numDigs);
        this.setSize(origW, origH);
    } // End of the function
    function attachChildren()
    {
        var _loc2 = "defDigPlusBkgnd";
        if (digPBkgndID != "" && digPBkgndID != undefined)
        {
            _loc2 = digPBkgndID;
        } // end if
        this.attachMovie(_loc2, "digEx", 0);
    } // End of the function
    function draw()
    {
        this.arrangeDigits(_numDigs);
        this.setVal(pval);
        this.chgDecPlaces(_decPl);
        this.chgLeadZero(_leadZero);
        this.setDigColor(_digTint);
        this.setSize(origW, origH);
        this.dispBkgnd(_showBkgnd);
        this.displayDigs(digsOn);
    } // End of the function
    function arrangeDigits(nNum)
    {
        var _loc2;
        var _loc3;
        var _loc4 = _digs2Del;
        if (_loc4 == undefined)
        {
            _loc4 = _numDigs;
        } // end if
        if (nNum != _loc4)
        {
            for (var _loc2 = 1; _loc2 < _loc4; ++_loc2)
            {
                digs[_loc2].removeMovieClip();
                delete digCols[_loc2];
            } // end of for
            delete this.digCols;
            delete this.digs;
        } // end if
        _numDigs = nNum;
        digCols = new Array(_numDigs);
        digs = new Array(_numDigs);
        digs[0] = digEx;
        for (var _loc2 = 0; _loc2 < _numDigs; ++_loc2)
        {
            if (_loc2 == 0)
            {
                digs[0]._x = digs[0]._y = 0;
            }
            else
            {
                _loc3 = "d" + _loc2;
                digs[_loc2] = digEx.duplicateMovieClip(_loc3, _loc2);
                digs[_loc2]._x = digs[_loc2 - 1]._x + digs[0]._width;
            } // end else if
            digCols[_loc2] = new Color(digs[_loc2].dig);
            digCols[_loc2].setRGB(Number(_digTint));
        } // end of for
    } // End of the function
    function setVal(v)
    {
        pval = v;
        this.update();
    } // End of the function
    function setDigColor(c)
    {
        for (var _loc2 = 0; _loc2 < _numDigs; ++_loc2)
        {
            digCols[_loc2].setRGB(c);
        } // end of for
        _digTint = c;
    } // End of the function
    function chgDecPlaces(dp)
    {
        _decPl = dp;
        this.update();
    } // End of the function
    function chgLeadZero(f)
    {
        _leadZero = f;
        this.update();
    } // End of the function
    function displayDigs(f)
    {
        digsOn = f;
        this.update();
    } // End of the function
    function update()
    {
        var _loc2;
        var _loc11;
        var _loc9 = _numDigs;
        var _loc10 = false;
        var _loc5;
        var _loc12;
        var _loc4;
        var _loc3;
        var _loc7;
        var _loc6;
        var _loc8;
        if (digsOn)
        {
            _loc4 = Math.pow(10, _numDigs - 1);
            _loc5 = Math.round(pval * Math.pow(10, _decPl));
            if (pval < 0)
            {
                _loc10 = true;
                _loc5 = -_loc5;
            } // end if
            _loc8 = _leadZero;
            if (int(_loc5 / _loc4) >= 10)
            {
                eventObj.type = evtOverflow;
                eventObj.val = pval;
                this.dispatchEvent(eventObj);
                return;
            } // end if
            _loc6 = !_loc10;
            _loc7 = _loc9 - _decPl - 1;
            for (var _loc2 = 0; _loc2 < _loc9; ++_loc2)
            {
                _loc3 = int(_loc5 / _loc4);
                if (_loc3 != 0 || _loc2 >= _loc7)
                {
                    _loc8 = true;
                    if (!_loc6)
                    {
                        if (_loc2 == 0)
                        {
                            eventObj.type = evtOverflow;
                            eventObj.val = pval;
                            this.dispatchEvent(eventObj);
                            return;
                        } // end if
                        _loc6 = true;
                        if (_leadZero)
                        {
                            digs[0].dig.gotoAndStop(11);
                            digs[0].dig._visible = true;
                        }
                        else
                        {
                            digs[_loc2 - 1].dig.gotoAndStop(11);
                            digs[_loc2 - 1].dig._visible = true;
                        } // end if
                    } // end if
                } // end else if
                digs[_loc2].dig._visible = _loc3 != 0 || _loc8;
                digs[_loc2].dig.gotoAndStop(_loc3 + 1);
                _loc5 = _loc5 - _loc3 * _loc4;
                digs[_loc2].dig.dpt._visible = _decPl != 0 && _loc2 == _loc7;
                if (digs[_loc2].dig.dpt._visible && !digs[_loc2].dig._visible)
                {
                    digs[_loc2].dig._visible = true;
                } // end if
                _loc4 = _loc4 / 10;
            } // end of for
        }
        else if (!isNaN(_numDigs))
        {
            for (var _loc2 = 0; _loc2 <= _numDigs; ++_loc2)
            {
                digs[_loc2].dig._visible = false;
            } // end of for
        } // end else if
    } // End of the function
    function setSize(nW, nH)
    {
        var _loc2;
        var _loc4;
        var _loc3;
        if (oneCharWidth == undefined)
        {
            return;
        } // end if
        _loc4 = 100 * nW / oneCharWidth / _numDigs;
        _loc3 = 100 * nH / oneCharHeight;
        for (var _loc2 = 0; _loc2 < _numDigs; ++_loc2)
        {
            digs[_loc2]._xscale = _loc4;
            digs[_loc2]._yscale = _loc3;
            if (_loc2 != 0)
            {
                digs[_loc2]._x = digs[_loc2 - 1]._x + digs[0]._width;
            } // end if
        } // end of for
        origW = nW;
        origH = nH;
    } // End of the function
    var className = "FMXISDigits";
    static var symbolOwner = mx.fmxis.FMXISDigits;
    static var symbolName = "FMXISDigits";
    var clipParameters = {listener: 1, evtOverflow: 1, numDigs: 1, val: 1, digPBkgndID: 1, leadZero: 1, decPl: 1, digTint: 1, showBkgnd: 1, display: 1};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISDigits.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
    static var digEvents = new Array("onOverflow");
    var myEvents = mx.fmxis.FMXISDigits.digEvents;
} // End of Class
