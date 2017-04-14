//USEUNIT ConfigFile


/*****************************************************************************
  Purpose: Naviagtes to Application URL.
  Parameter(s): None.
  Remarks: None.
  Return type: None

/*****************************************************************************/

 function navigates()
 {
 var browserProcess = Sys.FindChild("Name", "Process(" + ConfigFile.browserType + "\")", 1);
 if (browserProcess.Exists ==  false)
    {
        Log.Message("Browser is not launched.")
        run_browser();
        Sys.Process(browserType).toURL(appURL, 7000);
    }
    
 }
    


/*****************************************************************************
  Purpose: Launches new browser instance.
  Parameter(s): None.
  Remarks: None.
  Return type: None

/*****************************************************************************/
function run_browser()
{
    //Enables testing of web pages that use cross-origin framesets.
    if (aqString.Compare(browserType, "chrome", false) == 0) 
        //Browsers.Item(browserType).RunOptions = "--disable-hang-monitor --allow-file-access-from-files --disable-web-security";
        Browsers.Item(browserType).RunOptions = "--disable-hang-monitor --allow-file-access-from-files";
    //Launches the specified browser.
   Browsers.Item(browserType).Run("");
   
   

    //Maximizes the browser window.
    if (aqString.Compare(browserType, "iexplore", false) == 0)
    {
        waitForPage();
        Sys.Browser().BrowserWindow(0).Maximize();
    }
}


/*****************************************************************************
  Purpose: Logs user in with the specified credentials.
  Parameter(s): emailID
  Return type: None.
  Created By: Vikas Bhadwal
/*****************************************************************************/
function loginUser(emailID)
{
    waitForPage();
    var loginPage = Sys.Browser(ConfigFile.browserType).Page("*");
    var emailIDField = waitForObject(["ObjectIdentifier", "ObjectType"], ["UserId", "Textbox"]);
    emailIDField.Keys("^a[Del]"+emailID);
    clickObject(["ObjectIdentifier", "ObjectType"], ["cmdSubmit", "SubmitButton"]);
    
   
}

/*****************************************************************************
  Purpose: Loads test data from xls
  Parameter(s): dataSetFile(Path of xls file)
  Return type: None.
  Created By: Vikas Bhadwal
/*****************************************************************************/

function LoadDataSet(dataSetFile)
{
    var location = ConfigFile.configPath + "\TestData\\";
    Log.Message("location:  "+location);
    var DataQry = ADO.CreateADOQuery();
    DataQry.ConnectionString = "Provider = Microsoft.ACE.OLEDB.12.0; Data Source = " + location + dataSetFile + ".xls ; Extended Properties ='Excel 12.0 Xml;HDR=YES'";
    DataQry.SQL = "Select * From [Sheet1$]";
    DataQry.Open();
    DataQry.First();
    return DataQry;
}


/*****************************************************************************
  Purpose:      This method delays script execution until the specified object appears or the specified time limit is reached.
  Parameter(s): @propNames = An array of strings containing the names of properties or a single property name
                @propValues = An array containing the values of the specified properties or a single property value
                @timeout = Sets how long to wait (in milliseconds) for object to appear on the screen (Optional - default: defaultTimeout)
                @pollInterval = The frequency (in milliseconds) with which to check the condition (Optional - default: defaultPollInterval)
  Return type:  Boolean
  Remarks:      If the user specifies a pollInterval > 0, then the interval may be greater as the cost of FindChild is not factored in.
  
/*****************************************************************************/

function waitForObject(propNames, propValues, timeout, pollInterval)
{
    if (timeout == null) timeout = defaultTimeout;
    if (pollInterval == null) pollInterval = defaultPollInterval;
    var start = aqDateTime.Now();
    var elapsed = aqDateTime.Now() - start;
    while (elapsed <= timeout)
    {
        if (pollInterval > 0) aqUtils.Delay(pollInterval);

        var object = Sys.Process(browserType).Page("*").FindChild(propNames, propValues, 50);
        if (object.Exists && object.Enabled) return object;

        elapsed = aqDateTime.Now() - start;
    }
    Log.Message("Object Not Found: " + propNames + "       " + propValues + ".");
    return false;
}

/*****************************************************************************
  Purpose: Simulate a mouse-click on an element located by property names and values.
  Parameter(s): Properties and values to search for object by, scroll to object (boolean - optional)
  Remarks: None.
  Return type: Boolean
  

/*****************************************************************************/

function clickObject(propNames, propValues, scroll, timeout)
{
    
    var object = waitForObject(propNames, propValues, timeout);
    if (!object)
    {
        Log.Message("Object Not Found: " + propNames + "     " + propValues + ".");
        return false;
    }
    if (scroll) scrollDownToObject(object);
    object.HoverMouse();
    object.Click();
    return true;
}


/*****************************************************************************
  Purpose: Wait untill page gets loaded completly
  Parameter(s): None
  Remarks: None.
  Return type: Boolean
  

/*****************************************************************************/

function waitForPage()
{
    Sys.Process(browserType).Page("*").Wait();
}




/*****************************************************************************
  Purpose: Add Execution Delay
  Parameter(s): time in milliseconds
  Remarks: None.
  Return type: None
/*****************************************************************************/

function addDelay1(time)
{
Delay(time);
}

/*****************************************************************************
  Purpose: Scroll to the element
  Parameter(s): reference of element
  Remarks: None.
  Return type: Boolean
/*****************************************************************************/
function scrollDownToObject(object)
{
    var i = 0;
    while (object.Exists == false)
    {
        Log.Message("object.Exists:   "+object.Exists)
        Sys.Process(browserType).Page("*").MouseWheel(-1);
        aqUtils.Delay(2000);
        i++;
        if (object.Exists) break;
        else if(i > 20) break;
    }
    var j = 0;
    while (!object.VisibleOnScreen)
    {
        Log.Message("object.VisibleOnScreen:   "+object.VisibleOnScreen);
        Sys.Process(browserType).Page("*").MouseWheel(-1);
        aqUtils.Delay(2000);
        j++;
        if (object.VisibleOnScreen) return true;
        else if(j > 20) break;
    }
    return false;
}

/*****************************************************************************
  Purpose:      This method delays script execution until the specified object appears or the specified time limit is reached.
  Parameter(s): @propNames = An array of strings containing the names of properties or a single property name
                @propValues = An array containing the values of the specified properties or a single property value
                @windows= Browser window index.[i.e 1,2,3]
                @timeout = Sets how long to wait (in milliseconds) for object to appear on the screen (Optional - default: defaultTimeout)
                @pollInterval = The frequency (in milliseconds) with which to check the condition (Optional - default: defaultPollInterval)
  Return type:  Boolean
  Remarks:      If the user specifies a pollInterval > 0, then the interval may be greater as the cost of FindChild is not factored in.
  
/*****************************************************************************/


function waitForObjectInWindows(propNames, propValues,windows, timeout, pollInterval)
{
//Sys.Process(browserType).Page("*").Wait();
  if (timeout == null) timeout = defaultTimeout;
    if (pollInterval == null) pollInterval = defaultPollInterval;
    var start = aqDateTime.Now();
    var elapsed = aqDateTime.Now() - start;
    while (elapsed <= timeout)
    {
        if (pollInterval > 0) aqUtils.Delay(pollInterval);

        var object = Sys.Process("iexplore", windows).FindChild(propNames, propValues, 50);
        if (object.Exists && object.Enabled) return object;

        elapsed = aqDateTime.Now() - start;
    }
    Log.Message("Object Not Found: " + propNames + "       " + propValues + ".");
    return false;
}



/*****************************************************************************
  Purpose: Select any particular Element from combobox
  Parameter(s): reference of element
  Remarks: None.
  Return type: Boolean
/*****************************************************************************/

function selectItem(select,value)

{

 select.ClickItem(value);

 return true;

}

/*****************************************************************************
  Purpose: Get current system date
  Parameter(s): None
  Remarks: None.
  Return type: Current date on dd-mm-yyyy format
/*****************************************************************************/

function getCurrentDate()
{
var today = new Date(); var dd = today.getDate(); 
var mm = today.getMonth()+1; 
//January is 0! 
var yyyy = today.getFullYear(); 
if(dd<10)
{ dd='0'+dd; 
} if(mm<10)
{ mm='0'+mm; }
 var today = dd+'-'+mm+'-'+yyyy; 

return today

}



/*****************************************************************************
  Purpose: to generate random number
  Parameter(s): none
  Remarks: None.
  Return type: Random Number
/*****************************************************************************/

function randInt()
{
  return Math.round(Math.random() * 1000000);
}


/*****************************************************************************
  Purpose: Simulate a mouse-click on an element located by property names and values.
  Parameter(s): Properties and values to search for object by, scroll to object (boolean - optional)
  Parameter(s): @propNames = An array of strings containing the names of properties or a single property name
                @propValues = An array containing the values of the specified properties or a single property value
                @windows= Browser window index.[i.e 1,2,3]
  Remarks: None.
  Return type: Boolean
/*****************************************************************************/

function clickObjectInWindows(propNames, propValues, windows,scroll, timeout)
{       
    
    var object = waitForObjectInWindows(propNames, propValues, windows,timeout);
    if (!object)
    {
        Log.Message("Object Not Found: " + propNames + "     " + propValues + ".");
        return false;
    }
    if (scroll) scrollDownToObject(object);
    object.HoverMouse();
    object.Click();
    return true;
}


/*****************************************************************************
  Purpose: Logging of steps performed using test execution
  Parameter(s): none
  Remarks: None.
  Return type: None
/*****************************************************************************/


function logStep(flag,desc)
{

if(flag)
        Log.Checkpoint(desc);
    else
        Log.Error(desc);
}


/*****************************************************************************
  Purpose: To Logout currently logged in user
  Parameter(s): none
  Remarks: None.
  Return type: none.
/*****************************************************************************/

function resetApp()
{  addDelay1(5000);
   var logo=waitForObject(["Name", "ObjectType"], ["Image('logo_png')", "Image"],true);

   if(logo.Exists)
   {
   var username=clickObject(["contentText", "ObjectType"], ["regexp:^Hello", "TextNode"],true);
   var username=clickObject(["contentText", "ObjectType"], ["Logout", "Link"],true);
   
   }
   
}











