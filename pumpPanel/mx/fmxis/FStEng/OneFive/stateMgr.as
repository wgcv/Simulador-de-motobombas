class mx.fmxis.FStEng.OneFive.stateMgr
{
    var name, id, defSt, contSt, cs, lastSt;
    function stateMgr(n, id, defaultState, containerState)
    {
        name = n;
        this.id = id;
        defSt = defaultState;
        contSt = containerState;
        cs = undefined;
        lastSt = undefined;
        if (id == null || defaultState == null || containerState == null)
        {
            trace ("ERR003: State Manager Constructor Error!  " + n + "\'s id, default state, and container state must be non-null");
            return;
        } // end if
        if (containerState instanceof mx.fmxis.FStEng.OneFive.hStateC)
        {
            containerState.addStMgr(this);
        }
        else
        {
            containerState.setStMgr(this);
        } // end else if
    } // End of the function
    function activate(hist, specIDs)
    {
        var _loc4;
        trace ("State Manager " + name + " ACTIVATING" + (hist ? (" (history == true)") : ("")));
        if (specIDs != null)
        {
            cs = specIDs[0];
            specIDs.splice(0, 1);
            if (specIDs.length == 0)
            {
                false;
                specIDs = null;
            } // end if
        }
        else
        {
            cs = hist && lastSt != undefined ? (lastSt) : (defSt);
            hist = false;
        } // end else if
        if (lastSt == undefined)
        {
            lastSt = cs;
        } // end if
        _loc4 = contSt.substates[cs];
        _loc4.enter(hist, specIDs);
    } // End of the function
    function deactivate()
    {
        var _loc2;
        trace ("State Manager " + name + " DEACTIVATING");
        if (cs != undefined)
        {
            _loc2 = contSt.substates[cs];
            _loc2.leave();
            lastSt = cs;
            cs = undefined;
        } // end if
    } // End of the function
    function resetHistory()
    {
        var _loc4;
        var _loc3;
        var _loc2;
        if (lastSt == undefined)
        {
            return;
        } // end if
        lastSt = undefined;
        for (var _loc4 in contSt.substates)
        {
            _loc2 = contSt.substates[_loc4];
            if (_loc2 instanceof mx.fmxis.FStEng.OneFive.hState)
            {
                _loc2.stMgr.resetHistory();
                continue;
            } // end if
            if (_loc2 instanceof mx.fmxis.FStEng.OneFive.hStateC)
            {
                for (var _loc3 in _loc2.stMgrs)
                {
                    if (_loc2.stMgrs[_loc3] instanceof mx.fmxis.FStEng.OneFive.stateMgr)
                    {
                        _loc2.stMgrs[_loc3].resetHistory();
                    } // end if
                } // end of for...in
            } // end if
        } // end of for...in
    } // End of the function
    function chgSt(transID, netLvl, val)
    {
        var _loc3;
        var _loc4;
        var _loc8;
        var _loc5;
        var _loc7;
        var _loc2;
        var _loc6;
        _loc3 = contSt.substates[cs];
        if (netLvl)
        {
            trace ("chgSt: Changing from state #" + contSt.id + " along transition #" + transID);
            _loc8 = contSt;
        }
        else
        {
            trace ("chgSt: Changing from state #" + cs + " along transition #" + transID);
            _loc8 = _loc3;
        } // end else if
        _loc4 = _loc8.transitions[transID];
        if (_loc4 == undefined)
        {
            trace ("ERR104: Error in chgSt!  Change cancelled.  No transition #" + transID + " for current state " + _loc8.name);
        }
        else if (!(_loc4 instanceof mx.fmxis.FStEng.OneFive.transLvl))
        {
            if (_loc4.hist && _loc3.myStMgr.contSt.stMgrs != undefined)
            {
                _loc3 = _loc3.myStMgr.contSt;
                for (var _loc2 in _loc3.stMgrs)
                {
                    _loc3.substates[_loc3.stMgrs[_loc2].cs].leave();
                    _loc6 = _loc3.stMgrs[_loc2].cs;
                    _loc3.stMgrs[_loc2].cs = _loc3.stMgrs[_loc2].lastSt;
                    _loc3.stMgrs[_loc2].lastSt = _loc6;
                } // end of for...in
                if (_loc4.xfn instanceof Function)
                {
                    _loc4.xfn(val);
                } // end if
                for (var _loc2 in _loc3.stMgrs)
                {
                    _loc3.substates[_loc3.stMgrs[_loc2].cs].enter(true, null);
                } // end of for...in
            }
            else
            {
                _loc3.leave();
                if (_loc4.xfn instanceof Function)
                {
                    _loc4.xfn(val);
                } // end if
                if (_loc4.hist == true)
                {
                    cs = lastSt;
                }
                else
                {
                    if (cs != undefined)
                    {
                        lastSt = cs;
                    } // end if
                    cs = _loc4.toSt;
                } // end else if
                _loc3 = contSt.substates[cs];
                _loc3.enter(_loc4.hist, null);
            } // end else if
        }
        else
        {
            if (_loc4 instanceof mx.fmxis.FStEng.OneFive.transLvl)
            {
                _loc5 = new Array();
                for (var _loc2 = 0; _loc2 < _loc4.stPath.length; ++_loc2)
                {
                    _loc5.push(_loc4.stPath[_loc2]);
                } // end of for
            }
            else
            {
                _loc5 = null;
            } // end else if
            if (_loc4.upLvls > 0)
            {
                _loc7 = this.passUp(_loc4.upLvls);
            }
            else
            {
                _loc7 = this;
                _loc3.leave();
                if (_loc5 != null)
                {
                    _loc7.lastSt = _loc3.id;
                } // end if
            } // end else if
            if (_loc4.xfn instanceof Function)
            {
                _loc4.xfn(val);
            } // end if
            if (_loc5 != null)
            {
                _loc7.cs = _loc5[0];
            } // end if
            _loc7.passDown(_loc5, _loc4.hist);
        } // end else if
    } // End of the function
    function passUp(upLvls)
    {
        var _loc2 = this;
        while (upLvls > 0)
        {
            _loc2.contSt.leave();
            --upLvls;
            _loc2.contSt.myStMgr.lastSt = _loc2.contSt.myStMgr.cs;
            _loc2.contSt.myStMgr.cs = undefined;
            _loc2 = _loc2.contSt.myStMgr;
            if (_loc2 == null)
            {
                trace ("ERR101: passUp reached top of state network.  Check up levels in transtion.");
            } // end if
        } // end while
        return (_loc2);
    } // End of the function
    function passDown(stPath, hist)
    {
        var _loc2;
        if (stPath == null || stPath.length < 1)
        {
            false;
            if (hist == false)
            {
                if (lastSt != undefined)
                {
                    trace ("WARN100: Warning from passDown!  did you mean to pass a null state path and no history set?  Entering default start state");
                    lastSt = defSt;
                }
                else
                {
                    trace ("ERR100: Error from passDown! Received a null state path, history false, and no last state to enter.");
                    return;
                } // end if
            } // end else if
            _loc2 = contSt.substates[lastSt];
            _loc2.enter(hist, null);
            _loc2.myStMgr.cs = _loc2.id;
        }
        else
        {
            _loc2 = contSt.substates[stPath[0]];
            stPath.splice(0, 1);
            if (stPath.length == 0)
            {
                _loc2.enter(hist, null);
                false;
            }
            else
            {
                _loc2.enter(hist, stPath);
            } // end else if
        } // end else if
    } // End of the function
} // End of Class
