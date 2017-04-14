//USEUNIT ImportFiles

function addAssestEntry()

{
    var functionName, username,currentPage
    var DataQry =LoadDataSet("addAssetEntry");
    username = DataQry.FieldByName("username").Value;
    assetID = randInt();
    assetDescription = DataQry.FieldByName("assetDescription").Value;
     assetClass = DataQry.FieldByName("assetClass").Value;
    
    division = DataQry.FieldByName("division").Value;
    site=DataQry.FieldByName("site").Value;
    
    location=DataQry.FieldByName("location").Value;
    notifyEmail=notes=DataQry.FieldByName("notifyEmail").Value;

    notes=DataQry.FieldByName("notes").Value;
    
    datePurchased=DataQry.FieldByName("datePurchased").Value;
    parent=DataQry.FieldByName("parent").Value;
   
    accID=DataQry.FieldByName("accID").Value;
    serialNumber=DataQry.FieldByName("serialNumber").Value;
    
    modelNumber=DataQry.FieldByName("modelNumber").Value;
    
    manufacturer=DataQry.FieldByName("manufacturer").Value;
   size=DataQry.FieldByName("size").Value;
   rpm=DataQry.FieldByName("rpm").Value;
   hp=DataQry.FieldByName("hp").Value;
   electData=DataQry.FieldByName("electData").Value;

    
    
    
    
    
        
    Log.Message("Username:     "+username);
    navigates();
    loginUser(username);
    Sys.Process(ConfigFile.browserType).Page("*").Wait();
    
    var flag=clickObject(["contentText", "ObjectType"], ["Assets", "TextNode"],true);
    logStep(flag,"Click on Assets Menu");
    
    
    flag=clickObject(["contentText", "ObjectType"], ["Asset Entry", "Link"]); 
    logStep(flag,"Click on Assets Entry Menu");
    
    
    flag=clickObjectInWindows(["Caption", "Value"], ["AssetType", "HVAC"],3);
    logStep(flag,"Select HVAC Assets Type");
    
    flag=clickObjectInWindows(["ObjectIdentifier", "WndCaption"], ["Select", "Select"],3);
   logStep(flag,"Click on Select button.");
   
    var asset_id_input= waitForObject(["ObjectIdentifier", "ObjectType"], ["Date Entered", "Edit"]);
    asset_id_input.Keys(assetID);
    
    
    var desc_input= waitForObject(["Name", "ObjectType"], ["WinFormsObject('txtDescr')", "Edit"]);
    desc_input.Keys(assetDescription);
    
    var assetClassCB= waitForObject(["Name", "ObjectType"], ["WinFormsObject('cboAssetClass')", "ComboBox"]);
    flag=selectItem(assetClassCB,assetClass);
    
    var divisionCB= waitForObject(["Name", "ObjectType"], ["WinFormsObject('cboDivision')", "ComboBox"]);
    flag=selectItem(divisionCB,division);
    
    var location_input= waitForObject(["Name", "ObjectType"], ["WinFormsObject('txtLocation')", "Edit"]);
    location_input.Keys(location);
    
    var parent_input= waitForObject(["Name", "ObjectType"], ["WinFormsObject('txtParent')", "Edit"]);
    parent_input.Keys(parent);
    
    
     var notifyEmail_input= waitForObject(["Name", "ObjectType"], ["WinFormsObject('NotifyEMailAddr')", "Edit"]);
     notifyEmail_input.Keys(notifyEmail);
  
    
    
     var notes_input= waitForObject(["Name", "ObjectType"], ["WinFormsObject('txtNotes')", "Edit"]);
     notes_input.Keys(notes);
  
     Log.Message(getCurrentDate());
      
     
     
     
      var accID_input= waitForObject(["Name", "ObjectType"], ["WinFormsObject('txtEquipId')", "Edit"]);
      accID_input.Keys(accID);
      

      
      var serialNumber_input= waitForObject(["Name", "ObjectType"], ["WinFormsObject('txtSerialNbr')", "Edit"]);
      serialNumber_input.Keys(serialNumber);
      
      var modelNumber_input= waitForObject(["Name", "ObjectType"], ["WinFormsObject('txtModelNbr')", "Edit"]);
      modelNumber_input.Keys(modelNumber);
      
      
 
      
      var manufacturer_input= waitForObject(["Name", "ObjectType"], ["Edit('Description')", "Edit"]);
      manufacturer_input.Keys(manufacturer);
          
      var sizeCB= waitForObject(["Name", "ObjectType"], ["WinFormsObject('cboUser1')", "ComboBox"]); 
      sizeCB.Keys(size);
      
      var rpmCB= waitForObject(["Name", "ObjectType"], ["WinFormsObject('cboUser2')", "ComboBox"]); 
      rpmCB.Keys(rpm)
      
      var hpCB= waitForObject(["Name", "ObjectType"], ["WinFormsObject('cboUser3')", "ComboBox"]); 
      hpCB.Keys(hp)
      
      var electricityDataCB= waitForObject(["Name", "ObjectType"], ["WinFormsObject('cboUser4')", "ComboBox"]); 
      electricityDataCB.Keys(electData)
      
      
       flag=clickObject(["ObjectIdentifier", "ObjectType"], ["Save", "Button"]); 
logStep(flag,"Click on Save button");
      
      flag= clickObject(["ObjectIdentifier", "ObjectType"], ["OK", "Button"]); 
      logStep(flag,"Click on OK button");
      
      flag=clickObject(["ObjectIdentifier", "ObjectType"], ["OK", "Button"]); 
      logStep(flag,"Click on Yes button");
      
     //  Delay(15000);
      // var browser;
      // browser = Aliases.browser;
      for(var i=0;i<5;i++)
     {
     //browser.pageAssetEntry2.formAssedet.objectAssetentry.tablistSetup.spinbox.buttonLess.ClickButton();
//browser.Form("AsseDet").Object("AssetEntry").TabList("Setup").UIAObject("Spin").Button("Less").ClickButton();
     clickObjectInWindows(["Name", "ObjectType"], ["Button('Less')", "Button"],1); 
     }
   Delay(3000);
     flag=clickObjectInWindows(["Name", "ObjectType"], ["PageTab('Activity ')", "PageTab"],1); 
     logStep(flag,"Click on Activity tab");
      
      
      var description_createAsset=waitForObjectInWindows(["Name", "Value"], ["Cell('Description')", "Create Asset"],1); 

      if(description_createAsset.Exists)
       Log.Checkpoint("Record in the grid with a Description of 'Create Asset' is present.");
      else
       Log.Error("Record in the grid with a Description of 'Create Asset' is not present.");   

      var return_btn= clickObjectInWindows(["ObjectIdentifier", "ObjectType","VisibleOnScreen"], ["Return", "Button",true],1); 
     logStep(flag,"Click on Return button");
      
    
      
        flag= clickObjectInWindows(["Name", "ObjectType"], ["Button('OK')", "Button"],1); 
      logStep(flag,"Click on No button");

      


}