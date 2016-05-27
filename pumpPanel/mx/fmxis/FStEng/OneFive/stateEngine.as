class mx.fmxis.FStEng.OneFive.stateEngine
{
    var name, id, stNet, oracle, listeners, active, timeline, broadcasting, evTrigTbl, activeStates, uniqueStateIDs, _concEvCt;
    function stateEngine(n, id, tl, eventTriggerTable)
    {
        name = n;
        this.id = id;
        listeners = oracle = stNet = null;
        active = false;
        timeline = tl;
        broadcasting = false;
        evTrigTbl = eventTriggerTable == undefined ? ({}) : (eventTriggerTable);
        activeStates = new Object();
        uniqueStateIDs = 0;
    } // End of the function
    function setStateNetwork(sn)
    {
        stNet = sn;
    } // End of the function
    function remStateEngine(Void)
    {
        var _loc2;
        stNet.remState();
        if (listeners != null)
        {
            for (var _loc2 = 0; _loc2 < listeners.length; ++_loc2)
            {
                delete listeners[_loc2];
            } // end of for
            delete this.listeners;
        } // end if
        false;
    } // End of the function
    function activate(noHistReset)
    {
        var _loc4;
        var _loc3;
        active = true;
        if (noHistReset == undefined || noHistReset == false)
        {
            stNet.resetHistory();
        } // end if
        this.setSubState2SE(this, stNet);
        this.onActivate();
        stNet.enter();
    } // End of the function
    function setSubState2SE(stEng, stPtr)
    {
        var _loc3;
        var _loc5;
        var _loc4;
        if (stPtr._se != undefined)
        {
            return;
        } // end if
        stPtr._se = stEng;
        stPtr._seID = stEng.uniqueStateIDs++;
        for (var _loc3 in stPtr.transitions)
        {
            if (typeof(stPtr.transitions[_loc3].trigFn) == "string")
            {
                _loc5 = evTrigTbl[stPtr.transitions[_loc3].trigFn];
                if (_loc5 != undefined)
                {
                    stPtr.transitions[_loc3].trigFn = _loc5;
                    continue;
                } // end if
                trace ("UNRECOGNIZED TRANSITION TRIGGER, " + stPtr.transitions[_loc3].trigFn);
            } // end if
        } // end of for...in
        for (var _loc3 in stPtr)
        {
            if (evTrigTbl[_loc3] != undefined)
            {
                for (var _loc4 = 0; stPtr.intActs["_aia" + _loc4] != undefined; ++_loc4)
                {
                } // end of for
                stPtr.addIntAct("_aia" + _loc4, stPtr[_loc3], evTrigTbl[_loc3]);
            } // end if
        } // end of for...in
        stPtr.registerSubStates(this, stEng);
    } // End of the function
    function deactivate()
    {
        stNet.leave();
        this.onDeactivate();
        active = false;
    } // End of the function
    function onActivate()
    {
        trace ("< State Engine \'" + name + "\' is being ACTIVATED >");
    } // End of the function
    function onDeactivate()
    {
        trace ("< State Engine \'" + name + "\' has been DEACTIVATED >");
    } // End of the function
    function addListener(fn)
    {
        var _loc3;
        if (listeners == null)
        {
            listeners = new Array();
        } // end if
        if (!(fn instanceof Function) && fn.ieh == undefined)
        {
            trace ("ERR002: addListener Error!  listener fn passed in is invalid");
            return;
        } // end if
        listeners.push(fn);
    } // End of the function
    function removeListener(fn)
    {
        var _loc2;
        var _loc3 = listeners.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (listeners[_loc2] == fn)
            {
                if (broadcasting)
                {
                    listeners[_loc2] = undefined;
                }
                else
                {
                    listeners.splice(_loc2, 1);
                } // end else if
                return (true);
            } // end if
        } // end of for
        trace ("ERR103: Method removeListener called to remove listener, but not found on state engine " + name);
        return (false);
    } // End of the function
    function setOracle(fn)
    {
        var _loc2 = oracle == null;
        if (!(fn instanceof Function) && fn.irh == undefined)
        {
            trace ("ERR016: setOracle Error!  oracle fn passed in is invalid");
            return;
        } // end if
        oracle = fn;
        if (!_loc2)
        {
            trace ("WARN002: Oracle for state engine " + name + " is being reset.");
        } // end if
        return (_loc2);
    } // End of the function
    function notifyListeners(eid, val)
    {
        var _loc3;
        var _loc4;
        var _loc6 = listeners;
        var _loc5 = listeners.length;
        broadcasting = true;
        for (var _loc3 = 0; _loc3 < _loc5; ++_loc3)
        {
            _loc4 = _loc6[_loc3];
            if (_loc4 instanceof Function)
            {
                _loc4.apply(this, arguments);
                continue;
            } // end if
            _loc4.ieh.apply(_loc4, arguments);
        } // end of for
        broadcasting = false;
        _loc4 = listeners;
        for (var _loc3 = 0; _loc3 < listeners.length; ++_loc3)
        {
            if (_loc4[_loc3] == undefined)
            {
                _loc4.splice(_loc3, 1);
                --_loc3;
            } // end if
        } // end of for
    } // End of the function
    function askOracle(rid, val, target)
    {
        var _loc3;
        if (oracle == undefined)
        {
            trace ("ERR102: State Engine " + name + " made oracle request but no oracle set");
            return;
        }
        else
        {
            _loc3 = oracle;
            if (_loc3 instanceof Function)
            {
                return (_loc3.apply(this, arguments));
            }
            else
            {
                return (_loc3.irh.apply(_loc3, arguments));
            } // end else if
        } // end else if
    } // End of the function
    function ieh(eid, val, target)
    {
        var _loc3 = activeStates;
        var _loc4;
        var _loc2 = false;
        _concEvCt = new Object();
        for (var _loc4 in _loc3)
        {
            _loc2 = _loc3[_loc4].onEvent(eid, val, false, target) || _loc2;
        } // end of for...in
        if (!_loc2)
        {
            this.onUncaughtEvent(eid, val, target);
        } // end if
        delete this._concEvCt;
    } // End of the function
    function onUncaughtEvent(eid, val, target)
    {
        trace ("UNCAUGHT EVENT: \"" + eid + "\", val = " + val + " from " + target);
    } // End of the function
    function xeh(eid, val, target)
    {
        trace ("Default State Engine XEH called with <" + eid + ", " + val + ">");
    } // End of the function
    function irh(rid, val, target)
    {
        trace ("Default State Engine IRH called with <" + rid + ", " + val + "> from " + target);
        return (oracle == null ? (undefined) : (this.askOracle(rid, val, target)));
    } // End of the function
    function xrh(rid, val, target)
    {
        trace ("Default State Engine XRH called with <" + rid + ", " + val + "> from " + target);
        return;
    } // End of the function
    function setEventTrigger(trigName, trigFn)
    {
        evTrigTbl[trigName] = trigFn;
    } // End of the function
    function getEventTrigger(trigName)
    {
        return (evTrigTbl[trigName]);
    } // End of the function
} // End of Class
