class mx.fmxis.FStEng.OneFive.transLvl extends mx.fmxis.FStEng.OneFive.trans
{
    var upLvls, stPath;
    function transLvl(xfn, levels_up, state_path, hist)
    {
        super(xfn, null, hist);
        upLvls = levels_up;
        stPath = state_path;
    } // End of the function
} // End of Class
