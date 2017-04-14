//USEUNIT ImportFiles

function addWorkOrderEntry()

{
    var functionName, username,currentPage
    var DataQry =LoadDataSet("addWorkOrderEntry");
    username = DataQry.FieldByName("username").Value;
   
    Log.Message("Username:     "+username);
    navigates();
    loginUser(username);
    Sys.Process(ConfigFile.browserType).Page("*").Wait();
    
    var flag=clickObject(["contentText", "ObjectType"], ["Work Orders", "TextNode"],true);
    logStep(flag,"Click on Work Orders Menu");
    
    
    flag=clickObject(["contentText", "ObjectType"], ["WO Entry", "Link"]); 
    logStep(flag,"Click on WO Entry option");
    
    
    flag=clickObject(["Name", "ObjectType"], ["Button('User Defined Field 5')", "Button"]);
    logStep(flag,"click the binoculars next to Asset ID");
    
    
  // flag=clickObjectInWindows(["Caption", "Value"], ["Asset ID", "1-BLD-002"],1);
   // logStep(flag,"Select asset Windmill");
    
    flag=clickObjectInWindows(["Name", "ObjectType"], ["Button('Select')", "Button"],1);
   logStep(flag,"click on select button.");
    
    
      var flag=clickObject(["Name", "ObjectType"], ["WinFormsObject('cmdAddProc')", "Button"],true);
    logStep(flag,"Click on plus icon to add procedure");
   
    
     var work_requested_txtarea=waitForObject(["Name", "ObjectType"], ["WinFormsObject('txtComments')", "Edit"],true);
    
   work_requested_txtarea.Keys("This is a test");
    
   var flag=clickObject(["Name", "ObjectType"], ["Button('Save')", "Button"],true);
    logStep(flag,"Click on Save button.");
    
   
    var flag=clickObject(["Name", "ObjectType"], ["Button('OK')", "Button"],true);
    logStep(flag,"Click on OK button.");
    
     var flag=clickObject(["Name", "ObjectType"], ["Button('Cancel')", "Button"],true);
   logStep(flag,"Click on cANCEL button.");
    
    
   
     var flag=clickObject(["Name", "ObjectType"], ["Button('OK')", "Button"],true);
    logStep(flag,"Click on OK button.");
    
    var flag=clickObject(["Name", "ObjectType"], ["Button('OK')", "Button"],true);
    logStep(flag,"Click on OK button.");
    
       var flag=clickObject(["Name", "ObjectType"], ["Button('OK')", "Button"],true);
    logStep(flag,"Click on OK button.");
    
   
      var assignedToCb=waitForObject(["Name", "ObjectType"], ["WinFormsObject('cboAssignedTo')", "ComboBox"],true);
    
    assignedToCb.selectItem("Admin - Admin");
    var flag=clickObject(["Name", "ObjectType"], ["Button('Save')", "Button"],true);
    logStep(flag,"Click on Save button.");
    
     }