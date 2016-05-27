class mx.fmxis.FStEng.OneFive.trans
{
    var toSt, hist, xfn;
    function trans(xfn, toState, hist)
    {
        toSt = toState;
        this.hist = hist == true;
        this.xfn = xfn;
    } // End of the function
    function remTrans()
    {
        false;
    } // End of the function
} // End of Class
