class mx.fmxis.FStEng.OneFive.state
{
    var name, id, myStMgr, cActvies, pActvies, intActs, transitions, _se, _seID, _eNotice, _lNotice, intActsTrig;
    function state(nm, id, msm)
    {
        var _loc5;
        if (nm == undefined && id == undefined && msm == undefined)
        {
            return;
        } // end if
        name = nm;
        this.id = id;
        myStMgr = msm;
        if (id == null)
        {
            trace ("ERR005: State Constructor Error: id for state " + nm + " passed in as null");
        }
        else if (msm != null)
        {
            _loc5 = msm.contSt.addSubSt(this, id);
            if (_loc5 != true)
            {
                trace ("ERR006: State Constructor Error: Failed to add " + nm + " to container state");
            } // end if
        } // end else if
        transitions = intActs = pActvies = cActvies = null;
    } // End of the function
    function remState()
    {
        var _loc3;
        var _loc2 = this;
        if (_loc2.transitions != null)
        {
            for (var _loc3 in _loc2.transitions)
            {
                if (_loc2.transitions[_loc3] instanceof mx.fmxis.FStEng.OneFive.trans)
                {
                    _loc2.transitions[_loc3].remTrans();
                } // end if
            } // end of for...in
            delete _loc2.transitions;
        } // end if
        if (_loc2.intActs != null)
        {
            delete _loc2.intActs;
        } // end if
        if (_loc2.pActvies != null)
        {
            for (var _loc3 in _loc2.pActvies)
            {
                delete _loc2.pActvies[_loc3];
            } // end of for...in
            delete _loc2.pActvies;
        } // end if
        if (_loc2.cActvies != null)
        {
            for (var _loc3 in _loc2.cActvies)
            {
                delete _loc2.cActvies[_loc3];
            } // end of for...in
            delete _loc2.cActvies;
        } // end if
        false;
    } // End of the function
    function enter()
    {
        if (!(this instanceof mx.fmxis.FStEng.OneFive.hState) && !(this instanceof mx.fmxis.FStEng.OneFive.hStateC))
        {
            _se.activeStates[_seID] = this;
        } // end if
        this.entActs();
        this.startStateActivities();
    } // End of the function
    function addEntryNotice(listener)
    {
        var oea = entActs;
        if (_eNotice == undefined)
        {
            _eNotice = {};
            AsBroadcaster.initialize(_eNotice);
            function entActs()
            {
                oea();
                _eNotice.broadcastMessage("onEnter", name, this);
            } // End of the function
        } // end if
        _eNotice.addListener(listener);
    } // End of the function
    function removeEntryNotice(listener)
    {
        _eNotice.removeListener(listener);
    } // End of the function
    function addLeaveNotice(listener)
    {
        var ola = lvActs;
        if (_lNotice == undefined)
        {
            _lNotice = {};
            AsBroadcaster.initialize(_lNotice);
            function lvActs()
            {
                ola();
                _lNotice.broadcastMessage("onLeave", name, this);
            } // End of the function
        } // end if
        _lNotice.addListener(listener);
    } // End of the function
    function removeLeaveNotice(listener)
    {
        _lNotice.removeListener(listener);
    } // End of the function
    function startStateActivities()
    {
        var _loc3;
        var _loc2;
        if (pActvies != null)
        {
            for (var _loc3 in pActvies)
            {
                _loc2 = pActvies[_loc3];
                if (_loc2.intvl != undefined)
                {
                    if (_loc2.fb)
                    {
                        mx.fmxis.FStEng.OneFive.timerMgr.addTimer(_loc2);
                        continue;
                    } // end if
                    if (_loc2.obj == undefined)
                    {
                        _loc2.intvlID = setInterval(_loc2.fn, _loc2.intvl);
                        continue;
                    } // end if
                    _loc2.intvlID = setInterval(_loc2.obj, _loc2.fn, _loc2.intvl);
                } // end if
            } // end of for...in
        } // end if
        if (cActvies != null)
        {
            for (var _loc3 in cActvies)
            {
                cActvies[_loc3].mc.gotoAndPlay(2);
                cActvies[_loc3].mc._visible = true;
            } // end of for...in
        } // end if
    } // End of the function
    function entActs()
    {
        trace (">>>> Default Enter Actions for State: " + name + " (" + id + ")");
    } // End of the function
    function leave()
    {
        var _loc2;
        if (!(this instanceof mx.fmxis.FStEng.OneFive.hState) && !(this instanceof mx.fmxis.FStEng.OneFive.hStateC))
        {
            delete _se.activeStates[_seID];
        } // end if
        this.stopStateActivities();
        this.lvActs();
    } // End of the function
    function stopStateActivities()
    {
        var _loc2;
        var _loc4;
        var _loc3;
        if (pActvies != null)
        {
            for (var _loc2 in pActvies)
            {
                _loc3 = pActvies[_loc2];
                if (_loc3.fb)
                {
                    mx.fmxis.FStEng.OneFive.timerMgr.remTimer(_loc3);
                    continue;
                } // end if
                clearInterval(_loc3.intvlID);
                _loc3.intvlID = undefined;
            } // end of for...in
        } // end if
        if (cActvies != null)
        {
            for (var _loc2 in cActvies)
            {
                cActvies[_loc2].mc.gotoAndStop(1);
                cActvies[_loc2].mc._visible = !cActvies[_loc2].hideClip;
            } // end of for...in
        } // end if
    } // End of the function
    function lvActs()
    {
        trace ("(default) Leave Actions for state: " + name);
    } // End of the function
    function chgSt(transID, val)
    {
        if (transitions[transID] instanceof mx.fmxis.FStEng.OneFive.transLvl && transitions[transID].upLvls == -1)
        {
            trace ("ERR017: Invalid chgSt for state " + name + " -- trying to jump within a simple state");
            return;
        }
        else
        {
            myStMgr.chgSt(transID, false, val);
        } // end else if
    } // End of the function
    function isActive()
    {
        return (myStMgr.cs == id);
    } // End of the function
    function addTrans(id, trans, tf)
    {
        if (transitions == null)
        {
            transitions = new Object();
        } // end if
        if (transitions[id] == undefined)
        {
            transitions[id] = trans;
        }
        else
        {
            trace ("ERR007: Add State Transition Error: duplicate ID (" + id + ") for state \'" + name + "\'");
        } // end else if
        trans.trigFn = tf;
    } // End of the function
    function addIntAct(id, actfn, actTrig)
    {
        if (intActs == null)
        {
            intActs = new Object();
            intActsTrig = new Object();
        } // end if
        if (intActs[id] == undefined)
        {
            intActs[id] = actfn;
            intActsTrig[id] = actTrig;
        }
        else
        {
            trace ("ERR008: Add State Internal Actions Error: duplicate ID (" + id + ")");
        } // end else if
    } // End of the function
    function execIntAct(id, val, target)
    {
        intActs[id].call(this, val, target);
    } // End of the function
    function addPulseActivity(id, intvl, fnOrMet, obj)
    {
        this.addActivity(id, intvl, fnOrMet, obj, false);
    } // End of the function
    function addFPulseActivity(id, intvl, fnOrMet, obj)
    {
        this.addActivity(id, intvl, fnOrMet, obj, true);
    } // End of the function
    function addActivity(id, intvl, fnOrMet, obj, fb)
    {
        var _loc3;
        if (pActvies == null)
        {
            pActvies = new Object();
        } // end if
        _loc3 = {intvl: intvl, obj: obj, fn: fnOrMet, fb: fb};
        if (pActvies[id] == undefined)
        {
            pActvies[id] = _loc3;
        }
        else
        {
            trace ("ERR009: Add (Pulse) State Activity Error: duplicate ID (" + id + ")");
        } // end else if
    } // End of the function
    function remPulseActivity(id)
    {
        if (pActvies[id].intvlID)
        {
            if (pActvies[id].fb)
            {
                mx.fmxis.FStEng.OneFive.timerMgr.remTimer(pActvies[id]);
            }
            else
            {
                clearInterval(pActvies[id].intvlID);
                pActvies[id].intvlID = undefined;
            } // end if
        } // end else if
        delete pActvies[id];
    } // End of the function
    function addContinActivity(id, mclip, hideClip)
    {
        var _loc2;
        if (cActvies == null)
        {
            cActvies = new Object();
        } // end if
        _loc2 = new Object();
        _loc2.mc = mclip;
        _loc2.hideClip = hideClip;
        if (cActvies[id] == undefined)
        {
            cActvies[id] = _loc2;
            mclip._visible = !hideClip;
        }
        else
        {
            trace ("ERR010: Add (Continuous) State Activity Error: duplicate ID (" + id + ")");
        } // end else if
    } // End of the function
    function remContinActivity(id)
    {
        delete cActvies[id];
    } // End of the function
    function onEvent(eid, val, handledYet, target)
    {
        var _loc2;
        var _loc6;
        var _loc7;
        var _loc5;
        var _loc10 = null;
        _loc7 = intActsTrig;
        for (var _loc2 in _loc7)
        {
            if (_loc7[_loc2](eid, val, target))
            {
                this.execIntAct(_loc2, val, target);
                return (true);
            } // end if
        } // end of for...in
        if (!handledYet)
        {
            _loc6 = transitions;
            for (var _loc2 in _loc6)
            {
                if (_loc6[_loc2].trigFn(eid, val, target))
                {
                    _loc10 = _loc2;
                    handledYet = true;
                    break;
                } // end if
            } // end of for...in
        } // end if
        _loc5 = myStMgr.contSt;
        if (_loc5 instanceof mx.fmxis.FStEng.OneFive.hStateC)
        {
            if (_se._concEvCt[_loc5._seID] == undefined)
            {
                _se._concEvCt[_loc5._seID] = 1;
                _loc5.handledEvYet = handledYet;
            }
            else
            {
                ++_se._concEvCt[_loc5._seID];
            } // end else if
            _loc5.handledEvYet = _loc5.handledEvYet || handledYet;
            if (_se._concEvCt[_loc5._seID] == _loc5.numStMgrs)
            {
                handledYet = _loc5.onEvent(eid, val, _loc5.handledEvYet, target);
            } // end if
        }
        else if (_loc5 != null)
        {
            handledYet = _loc5.onEvent(eid, val, handledYet, target);
        } // end else if
        if (_loc10 != null)
        {
            this.chgSt(_loc10, val);
        } // end if
        return (handledYet);
    } // End of the function
    function resetHistory()
    {
    } // End of the function
    function registerSubStates(se, stEng)
    {
    } // End of the function
} // End of Class
