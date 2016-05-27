class mx.fmxis.FStEng.OneFive.timerMgr
{
    static var tasks, mmc, active, now;
    function timerMgr()
    {
        tasks = undefined;
        mmc = undefined;
        active = false;
    } // End of the function
    static function activate()
    {
        if (mx.fmxis.FStEng.OneFive.timerMgr.mmc == undefined)
        {
            mmc = _root.createEmptyMovieClip("_FStEngTM", 1000);
        } // end if
        if (mx.fmxis.FStEng.OneFive.timerMgr.active)
        {
            return;
        } // end if
        now = 0;
        for (var _loc2 in mx.fmxis.FStEng.OneFive.timerMgr.tasks)
        {
            mx.fmxis.FStEng.OneFive.timerMgr.tasks[_loc2].endTime = mx.fmxis.FStEng.OneFive.timerMgr.now + mx.fmxis.FStEng.OneFive.timerMgr.tasks[_loc2].intvl;
        } // end of for...in
        mx.fmxis.FStEng.OneFive.timerMgr.mmc.onEnterFrame = mx.fmxis.FStEng.OneFive.timerMgr.TCCounter;
    } // End of the function
    static function deactivate()
    {
        mx.fmxis.FStEng.OneFive.timerMgr.mmc.onEnterFrame = undefined;
        active = false;
    } // End of the function
    static function addTimer(tm)
    {
        if (mx.fmxis.FStEng.OneFive.timerMgr.tasks == undefined)
        {
            tasks = [tm];
        }
        else
        {
            mx.fmxis.FStEng.OneFive.timerMgr.tasks.push(tm);
        } // end else if
        mx.fmxis.FStEng.OneFive.timerMgr.tasks[mx.fmxis.FStEng.OneFive.timerMgr.tasks.length - 1].endTime = mx.fmxis.FStEng.OneFive.timerMgr.now + tm.intvl;
        mx.fmxis.FStEng.OneFive.timerMgr.activate();
    } // End of the function
    static function remTimer(tm)
    {
        var _loc1 = false;
        for (var _loc2 in mx.fmxis.FStEng.OneFive.timerMgr.tasks)
        {
            if (mx.fmxis.FStEng.OneFive.timerMgr.tasks[_loc2] == tm)
            {
                mx.fmxis.FStEng.OneFive.timerMgr.tasks.splice(_loc2, 1);
                _loc1 = true;
                break;
            } // end if
        } // end of for...in
        if (mx.fmxis.FStEng.OneFive.timerMgr.tasks.length == 0)
        {
            mx.fmxis.FStEng.OneFive.timerMgr.deactivate();
        } // end if
        return (_loc1);
    } // End of the function
    static function TCCounter()
    {
        var _loc2 = now = ++mx.fmxis.FStEng.OneFive.timerMgr.now;
        var _loc1;
        for (var _loc3 in mx.fmxis.FStEng.OneFive.timerMgr.tasks)
        {
            _loc1 = mx.fmxis.FStEng.OneFive.timerMgr.tasks[_loc3];
            if (_loc2 >= _loc1.endTime)
            {
                trace ("TASK: " + _loc1.fn + ", Count = " + _loc2);
                if (_loc1.obj == undefined)
                {
                    _loc1.fn();
                }
                else
                {
                    _loc1.obj[_loc1.fn]();
                } // end else if
                _loc1.endTime = _loc2 + _loc1.intvl;
            } // end if
        } // end of for...in
    } // End of the function
} // End of Class
