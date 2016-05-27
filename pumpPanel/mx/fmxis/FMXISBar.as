class mx.fmxis.FMXISBar extends mx.fmxis.FMXISBase
{
    var _nBars, invalidate, __get__nBars, _barSpace, __get__barSpace, _barColors, __get__barColors, _barColorRange, __get__barColorRange, _minVal, _oldMin, __get__minVal, _maxVal, _oldMax, __get__maxVal, _val, __get__val, boundingBox_mc, attachMovie, bcArray, bcOffArray, bcColorArray, bcOff, origChipHeight, origChipWidth, bcOn, barValCoeff, __get__height, _yscale, _xscale, __get__width, __set__barColorRange, __set__barColors, __set__barSpace, __set__maxVal, __set__minVal, __set__nBars, __set__val;
    function FMXISBar()
    {
        super();
        this.size();
    } // End of the function
    function set nBars(v)
    {
        if (v != undefined)
        {
            _nBars = v;
            this.resetChips();
            this.size();
            this.invalidate();
        } // end if
        //return (this.nBars());
        null;
    } // End of the function
    function get nBars()
    {
        return (_nBars);
    } // End of the function
    function set barSpace(v)
    {
        _barSpace = v;
        this.size();
        this.invalidate();
        //return (this.barSpace());
        null;
    } // End of the function
    function get barSpace()
    {
        return (_barSpace);
    } // End of the function
    function set barColors(p)
    {
        _barColors = p;
        this.resetChipColors();
        this.invalidate();
        //return (this.barColors());
        null;
    } // End of the function
    function get barColors()
    {
        return (_barColors);
    } // End of the function
    function set barColorRange(p)
    {
        _barColorRange = p;
        this.resetChipColors();
        this.invalidate();
        //return (this.barColorRange());
        null;
    } // End of the function
    function get barColorRange()
    {
        return (_barColorRange);
    } // End of the function
    function set minVal(v)
    {
        _oldMin = _minVal;
        _minVal = v;
        this.resetBarCoeff();
        this.invalidate();
        //return (this.minVal());
        null;
    } // End of the function
    function get minVal()
    {
        return (_minVal);
    } // End of the function
    function set maxVal(v)
    {
        _oldMax = _maxVal;
        _maxVal = v;
        this.resetBarCoeff();
        this.invalidate();
        //return (this.maxVal());
        null;
    } // End of the function
    function get maxVal()
    {
        return (_maxVal);
    } // End of the function
    function set val(v)
    {
        _val = v;
        this.invalidate();
        //return (this.val());
        null;
    } // End of the function
    function get val()
    {
        return (_val);
    } // End of the function
    function init(evts)
    {
        super.init(evts);
        boundingBox_mc._visible = false;
    } // End of the function
    function createChildren()
    {
        this.attachMovie("defBarChip", "bcOff", 1);
        bcArray = new Array();
        bcOffArray = new Array();
        bcColorArray = new Array();
        origChipHeight = bcOff._height;
        origChipWidth = bcOff._width;
        for (var _loc2 = 0; _loc2 < _nBars; ++_loc2)
        {
            if (_loc2 == 0)
            {
                bcOffArray[0] = bcOff;
                bcOff.duplicateMovieClip("bcOn", _loc2 + 2);
                bcArray[0] = bcOn;
                bcColorArray[0] = new Color(bcArray[0]);
                continue;
            } // end if
            bcOn.duplicateMovieClip("bn" + _loc2, 2 * _loc2 + 3);
            bcOff.duplicateMovieClip("bf" + _loc2, 2 * _loc2 + 2);
            bcArray[_loc2] = this["bn" + _loc2];
            bcOffArray[_loc2] = this["bf" + _loc2];
            bcColorArray[_loc2] = new Color(bcArray[_loc2]);
        } // end of for
        this.resetBarCoeff();
        this.resetChipColors();
    } // End of the function
    function resetChips()
    {
        if (_barColors.length == 0)
        {
            return;
        } // end if
        for (var _loc2 = 0; _loc2 < bcArray.length; ++_loc2)
        {
            bcArray[_loc2].removeMovieClip();
            delete bcColorArray[_loc2];
            if (_loc2 != 0)
            {
                bcOffArray[_loc2].removeMovieClip();
            } // end if
        } // end of for
        for (var _loc2 = 0; _loc2 < _nBars; ++_loc2)
        {
            if (_loc2 == 0)
            {
                bcOffArray[0] = bcOff;
                bcOff.duplicateMovieClip("bcOn", _loc2 + 2);
                bcArray[0] = bcOn;
                bcColorArray[0] = new Color(bcArray[0]);
                continue;
            } // end if
            bcOn.duplicateMovieClip("bn" + _loc2, 2 * _loc2 + 3);
            bcOff.duplicateMovieClip("bf" + _loc2, 2 * _loc2 + 2);
            bcArray[_loc2] = this["bn" + _loc2];
            bcOffArray[_loc2] = this["bf" + _loc2];
            bcColorArray[_loc2] = new Color(bcArray[_loc2]);
        } // end of for
    } // End of the function
    function resetChipColors()
    {
        var _loc4;
        if (_barColorRange.length == 0)
        {
            return;
        } // end if
        for (var _loc3 = 0; _loc3 < _nBars; ++_loc3)
        {
            _loc4 = _minVal + (_loc3 + 1) * barValCoeff;
            if (_barColorRange.length > 0)
            {
                for (var _loc2 = 0; _loc2 < _barColorRange.length && _loc4 > barColorRange[_loc2]; ++_loc2)
                {
                } // end of for
                bcColorArray[_loc3].setRGB(_barColors[_loc2]);
            } // end if
        } // end of for
    } // End of the function
    function resetBarCoeff()
    {
        barValCoeff = (_maxVal - _minVal) / _nBars;
    } // End of the function
    function draw()
    {
        var _loc3;
        for (var _loc2 = 0; _loc2 < _nBars; ++_loc2)
        {
            _loc3 = _minVal + (_loc2 + 1) * barValCoeff;
            bcArray[_loc2]._visible = _val >= _loc3;
        } // end of for
    } // End of the function
    function size()
    {
        if (this.__get__height() == undefined)
        {
            return;
        } // end if
        _yscale = 100;
        _xscale = 100;
        var _loc4 = _barSpace * (_nBars - 1);
        var _loc3 = (this.__get__height() - _loc4) / _nBars;
        for (var _loc2 = 0; _loc2 < _nBars; ++_loc2)
        {
            bcOffArray[_loc2]._yscale = bcArray[_loc2]._yscale = 100 * _loc3 / origChipHeight;
            bcOffArray[_loc2]._xscale = bcArray[_loc2]._xscale = 100 * this.__get__width() / origChipWidth;
            bcOffArray[_loc2]._x = bcArray[_loc2]._x = 0;
            bcOffArray[_loc2]._y = bcArray[_loc2]._y = this.__get__height() - (_loc2 + 1) * (_loc3 + _barSpace) + _barSpace;
        } // end of for
    } // End of the function
    var className = "FMXISBar";
    static var symbolOwner = mx.fmxis.FMXISBar;
    static var symbolName = "FMXISBar";
    var clipParameters = {nBars: 10, barSpace: 2, barColors: [65280], barColorRange: [100], minVal: 0, maxVal: 100, val: 0, listener: null};
    static var mergedClipParameters = mx.core.UIObject.mergeClipParameters(mx.fmxis.FMXISBar.prototype.clipParameters, mx.core.UIObject.prototype.clipParameters);
} // End of Class
