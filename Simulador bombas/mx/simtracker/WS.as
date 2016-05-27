class mx.simtracker.WS
{
    var daemon, my_ws;
    function WS(obj)
    {
        trace ("WS Instantiated");
        daemon = obj.daemon;
        this.init();
    } // End of the function
    function init()
    {
    } // End of the function
    function getWSDL(o, method)
    {
        trace ("WS.getWSDL");
        my_ws = new mx.services.WebService(wsdlURI);
        my_ws.onLoad = function (wsdlDocument)
        {
            trace ("getWSDL success ");
            o[method]();
        };
        my_ws.onFault = function (fault)
        {
        };
    } // End of the function
    function GetLogin(o, method, query)
    {
        trace ("WS.GetLogin");
        var owner = this;
        var _loc2 = my_ws.GetLogin2(query.sLogin, query.sPass, query.product);
        _loc2.onResult = function (result)
        {
            trace ("GetLogin success");
            var _loc1 = owner.parserLogin(result.results);
            o[method](_loc1);
        };
        _loc2.onFault = function (fault)
        {
            trace ("GetLogin error");
        };
    } // End of the function
    function parserLogin(my_xml)
    {
        var _loc1 = new Object();
        var _loc2 = my_xml;
        _loc1.sessionID = mx.simtracker.Lib.getNodeByName(_loc2, "sessionID").firstChild.nodeValue;
        _loc1.success = mx.simtracker.Lib.getNodeByName(_loc2, "success").firstChild.nodeValue == "true";
        _loc1.userID = mx.simtracker.Lib.getNodeByName(_loc2, "id_user").firstChild.nodeValue;
        return (_loc1);
    } // End of the function
    function GetManufacturers(o, method, query)
    {
        trace ("WS.GetManufacturers");
        var owner = this;
        var _loc2 = my_ws.GetManufacturers();
        _loc2.onResult = function (result)
        {
            trace ("GetManufacturers success");
            var _loc1 = owner.parserManufacturers(result.results);
            o[method](_loc1);
        };
        _loc2.onFault = function (fault)
        {
            trace ("GetManufacturers error");
        };
    } // End of the function
    function parserManufacturers(my_xml)
    {
        var _loc4 = new Array();
        var _loc5 = my_xml.childNodes.length;
        for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
        {
            var _loc1 = new Object();
            var _loc3 = my_xml.childNodes[_loc2];
            _loc1.id = _loc3.childNodes[0].firstChild.nodeValue;
            _loc1.name = _loc3.childNodes[1].firstChild.nodeValue;
            _loc1.description = _loc3.childNodes[2].firstChild.nodeValue;
            _loc4.push(_loc1);
        } // end of for
        return (_loc4);
    } // End of the function
    function GetProducts(o, method, query)
    {
        trace ("WS.GetProducts");
        var owner = this;
        var _loc2 = my_ws.GetProducts(query.id_manufacturer);
        _loc2.onResult = function (result)
        {
            trace ("GetProducts success");
            var _loc1 = owner.parserProducts(result.results);
            o[method](_loc1);
        };
        _loc2.onFault = function (fault)
        {
            trace ("GetProducts error");
        };
    } // End of the function
    function parserProducts(my_xml)
    {
        var _loc4 = new Array();
        var _loc5 = my_xml.childNodes.length;
        for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
        {
            var _loc1 = new Object();
            var _loc3 = my_xml.childNodes[_loc2];
            _loc1.id = _loc3.childNodes[0].firstChild.nodeValue;
            _loc1.name = _loc3.childNodes[1].firstChild.nodeValue;
            _loc1.description = _loc3.childNodes[2].firstChild.nodeValue;
            _loc4.push(_loc1);
        } // end of for
        return (_loc4);
    } // End of the function
    function GetEvents(o, method, query)
    {
        trace ("WS.GetEvents");
        var owner = this;
        var _loc2 = my_ws.GetEvents(query.id_product);
        _loc2.onResult = function (result)
        {
            trace ("GetEvents success");
            var _loc1 = owner.parserEvents(result.results);
            o[method](_loc1);
        };
        _loc2.onFault = function (fault)
        {
            trace ("GetEvents error");
        };
    } // End of the function
    function parserEvents(my_xml)
    {
        var _loc4 = new Array();
        var _loc5 = my_xml.childNodes.length;
        for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
        {
            var _loc1 = new Object();
            var _loc3 = my_xml.childNodes[_loc2];
            _loc1.id = _loc3.childNodes[0].firstChild.nodeValue;
            _loc1.name = _loc3.childNodes[1].firstChild.nodeValue;
            _loc1.description = _loc3.childNodes[2].firstChild.nodeValue;
            _loc4.push(_loc1);
        } // end of for
        return (_loc4);
    } // End of the function
    function SendEvent(o, method, query)
    {
        trace ("WS.SendEvent");
        var owner = this;
        var _loc2 = my_ws.SendEvent(query.id_session, query.id_user, query.id_evento, query.result);
        _loc2.onResult = function (result)
        {
            trace ("SendEvent success");
            var _loc1 = owner.parserSendEvent(result.results);
            o[method](_loc1);
        };
        _loc2.onFault = function (fault)
        {
            trace ("SendEvent error");
        };
    } // End of the function
    function parserSendEvent(my_xml)
    {
        return (my_xml.firstChild.firstChild.nodeValue == "true");
    } // End of the function
    function GetEventsByProduct(o, method, query)
    {
        trace ("WS.GetEventsByProduct");
        var owner = this;
        var _loc2 = my_ws.GetEventsByProduct(query.id_product, query.id_user, query.DateEventIni, query.DateEventFin);
        _loc2.onResult = function (result)
        {
            trace ("GetEventsByProduct success");
            var _loc1 = owner.parserEventsByProduct(result.results);
            o[method](_loc1);
        };
        _loc2.onFault = function (fault)
        {
            trace ("GetEventsByProduct error");
        };
    } // End of the function
    function parserEventsByProduct(my_xml)
    {
        var _loc4 = new Array();
        var _loc5 = my_xml.childNodes.length;
        for (var _loc3 = 0; _loc3 < _loc5; ++_loc3)
        {
            var _loc1 = new Object();
            var _loc2 = my_xml.childNodes[_loc3];
            _loc1.id = _loc2.childNodes[0].firstChild.nodeValue;
            _loc1.name = _loc2.childNodes[1].firstChild.nodeValue;
            _loc1.description = _loc2.childNodes[2].firstChild.nodeValue;
            _loc1.quantity = _loc2.childNodes[3].firstChild.nodeValue;
            _loc4.push(_loc1);
        } // end of for
        return (_loc4);
    } // End of the function
    function GetUsers(o, method, query)
    {
        trace ("WS.GetUsers");
        var owner = this;
        var _loc2 = my_ws.GetUsers(query.id_product);
        _loc2.onResult = function (result)
        {
            trace ("GetUsers success");
            var _loc1 = owner.parserUsers(result.results);
            o[method](_loc1);
        };
        _loc2.onFault = function (fault)
        {
            trace ("GetUsers error");
        };
    } // End of the function
    function parserUsers(my_xml)
    {
        var _loc4 = new Array();
        var _loc5 = my_xml.childNodes.length;
        for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
        {
            var _loc1 = new Object();
            var _loc3 = my_xml.childNodes[_loc2];
            _loc1.id = mx.simtracker.Lib.getNodeByName(_loc3, "id").firstChild.nodeValue;
            _loc1.userName = mx.simtracker.Lib.getNodeByName(_loc3, "userName").firstChild.nodeValue;
            _loc1.name = mx.simtracker.Lib.getNodeByName(_loc3, "name").firstChild.nodeValue;
            _loc4.push(_loc1);
        } // end of for
        return (_loc4);
    } // End of the function
    function SetInsertUser(o, method, query)
    {
        trace ("WS.SetInsertUser");
        var owner = this;
        var _loc3 = my_ws.setInsertUser("0", query.userName, query.password, query.firstName, query.lastName, query.country, query.phone, query.mail, query.custom);
        _loc3.onResult = function (result)
        {
            trace ("SetInsertUser success");
            var _loc1 = owner.parserSetInsertUser(result.results);
            o[method](_loc1);
        };
        _loc3.onFault = function (fault)
        {
            trace ("SetInsertUser error");
        };
    } // End of the function
    function parserSetInsertUser(my_xml)
    {
        return (my_xml.firstChild.firstChild.nodeValue == "true");
    } // End of the function
    var wsdlURI = "http://www.firetrainingsims.com/wsSimtracker.asmx?WSDL";
} // End of Class
