class mx.fmxis.FStEng.OneFive.hStateC extends mx.fmxis.FStEng.OneFive.state
{
    var stMgrs, numStMgrs, substates, name, transitions, myStMgr;
    function hStateC(nm, id, msm)
    {
        super(nm, id, msm);
        stMgrs = null;
        numStMgrs = 0;
        substates = null;
    } // End of the function
    function addSubSt(st, id)
    {
        if (typeof(substates[id]) == "object")
        {
            trace ("ERR013: Error in hStateC addSubSt! Trying to add a sub-state of \'" + name + "\' with the same id (" + id + ")");
            return (false);
        } // end if
        if (stMgrs[st.myStMgr.id] != st.myStMgr)
        {
            trace ("ERR014: Error in hStateC addSubSt!  State " + st.name + "\'s manager not found in container hStateC " + name + "\'s state managers.");
            return (false);
        } // end if
        if (substates == null)
        {
            substates = new Object();
        } // end if
        substates[id] = st;
        return (true);
    } // End of the function
    function addStMgr(sm)
    {
        var _loc2 = sm.id;
        if (stMgrs == null)
        {
            stMgrs = new Object();
        } // end if
        if (stMgrs[_loc2] == undefined)
        {
            stMgrs[_loc2] = sm;
        }
        else
        {
            trace ("ERR015: Add State Manager Error: duplicate ID (" + _loc2 + ") for state \'" + name + "\'");
        } // end else if
        ++numStMgrs;
    } // End of the function
    function enter(hist, specIDs)
    {
        var _loc4;
        var _loc5 = null;
        var _loc3;
        super.enter();
        if (specIDs != null)
        {
            _loc5 = substates[specIDs[0]];
            _loc5 = _loc5.myStMgr;
        } // end if
        if (stMgrs != null)
        {
            for (var _loc4 in stMgrs)
            {
                _loc3 = stMgrs[_loc4];
                if (_loc3 != null)
                {
                    if (specIDs == null)
                    {
                        _loc3.activate(hist, null);
                        continue;
                    } // end if
                    if (_loc5 != _loc3)
                    {
                        _loc3.activate(false, null);
                    } // end if
                } // end if
            } // end of for...in
            if (specIDs != null)
            {
                _loc5.activate(hist, specIDs);
            } // end if
        } // end if
    } // End of the function
    function leave()
    {
        var _loc4;
        var _loc3;
        if (stMgrs != null)
        {
            for (var _loc4 in stMgrs)
            {
                _loc3 = stMgrs[_loc4];
                if (_loc3 instanceof mx.fmxis.FStEng.OneFive.stateMgr)
                {
                    _loc3.deactivate();
                } // end if
            } // end of for...in
        } // end if
        super.leave();
    } // End of the function
    function remState()
    {
        var _loc3;
        var _loc2 = this;
        delete _loc2.stMgr;
        for (var _loc3 in _loc2.substates)
        {
            _loc2.remState();
        } // end of for...in
        delete _loc2.substates;
        false;
    } // End of the function
    function chgSt(transID, val)
    {
        if (transitions[transID] instanceof mx.fmxis.FStEng.OneFive.transLvl && transitions[transID].upLvls == -1)
        {
            if (transitions[transID].stPath != null)
            {
                substates[transitions[transID].stPath[0]].myStMgr.chgSt(transID, true, val);
            }
            else
            {
                for (var _loc4 in stMgrs)
                {
                    if (stMgrs[_loc4].id != undefined)
                    {
                        stMgrs[_loc4].chgSt(transID, true, val);
                    } // end if
                } // end of for...in
            } // end else if
        }
        else
        {
            myStMgr.chgSt(transID, false, val);
        } // end else if
    } // End of the function
    function resetHistory()
    {
        for (var _loc2 in stMgrs)
        {
            stMgrs[_loc2].resetHistory();
        } // end of for...in
    } // End of the function
    function registerSubStates(se, stEng)
    {
        for (var _loc4 in substates)
        {
            se.setSubState2SE(stEng, substates[_loc4]);
        } // end of for...in
    } // End of the function
} // End of Class
