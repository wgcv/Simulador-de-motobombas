class mx.fmxis.FStEng.OneFive.hState extends mx.fmxis.FStEng.OneFive.state
{
    var stMgr, substates, name, transitions, myStMgr;
    function hState(nm, id, msm)
    {
        super(nm, id, msm);
        stMgr = null;
        substates = null;
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
    function addSubSt(st, id)
    {
        if (typeof(substates[id]) == "object")
        {
            trace ("ERR011: Error in hState addSubSt! Trying to add " + st.name + " to its container state " + name + " with the same id " + id);
            return (false);
        } // end if
        if (stMgr != st.myStMgr)
        {
            trace ("ERR012: Error in addSubSt!  State " + st.name + "\'s manager not found in hState " + name + "\'s state managers.");
            return (false);
        } // end if
        if (substates == null)
        {
            substates = new Object();
        } // end if
        substates[id] = st;
        return (true);
    } // End of the function
    function setStMgr(sm)
    {
        if (stMgr != null)
        {
            trace ("WARN001: Warning! Set State Manager (setStMgr) for " + name + " is overwriting existing State Manager " + stMgr + " with " + sm.name);
        } // end if
        stMgr = sm;
    } // End of the function
    function enter(hist, specIDs)
    {
        super.enter();
        if (stMgr != null)
        {
            stMgr.activate(hist, specIDs);
        } // end if
    } // End of the function
    function leave()
    {
        stMgr.deactivate();
        super.leave();
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
                stMgr.chgSt(transID, true, val);
            } // end else if
        }
        else
        {
            myStMgr.chgSt(transID, false, val);
        } // end else if
    } // End of the function
    function resetHistory()
    {
        stMgr.resetHistory();
    } // End of the function
    function registerSubStates(se, stEng)
    {
        for (var _loc4 in substates)
        {
            se.setSubState2SE(stEng, substates[_loc4]);
        } // end of for...in
    } // End of the function
} // End of Class
