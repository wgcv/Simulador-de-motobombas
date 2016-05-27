class mx.fmxis.FMXISProxyListener
{
    var tline, lstner;
    function FMXISProxyListener(tl, l)
    {
        tline = tl;
        lstner = l;
    } // End of the function
    function handleEvent(ev)
    {
        var _loc2;
        _loc2 = tline[lstner];
        if (_loc2.handleEvent != undefined)
        {
            _loc2.handleEvent(ev);
        }
        else
        {
            _loc2[ev.type](ev);
        } // end else if
    } // End of the function
} // End of Class
