class mx.simtracker.Lib
{
    function Lib()
    {
    } // End of the function
    static function getNodeByName(nodo, nodeName)
    {
        var _loc4 = nodo.childNodes.length;
        for (var _loc3 in nodo.childNodes)
        {
            if (nodo.childNodes[_loc3].nodeName == nodeName)
            {
                return (nodo.childNodes[_loc3]);
            } // end if
        } // end of for...in
        return (null);
    } // End of the function
} // End of Class
