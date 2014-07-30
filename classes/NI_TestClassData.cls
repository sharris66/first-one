/****************************************************************************************
Name            : NI_TestClassData Class
Author          : 
Created Date    : 11/21/2012
Last Mod Date   : 5/7/2014 
Last Mod By     : 
NICC Reference  : 
Description     : Test Class for other test classes to point to when creating test data
                : 
                : 
******************************************************************************************/
public class NI_TestClassData 
{
     
      public static Id getRecordTypeId(String sObjTypeName, String RecordTypeName)
    {
        RecordType rt = [SELECT Name, Id FROM RecordType WHERE sObjectType =: sObjTypeName AND Name =: RecordTypeName AND isActive = true];
        return rt.Id;
    }
    
// ==============================================================================================================================================
//     STANDARD OBJECT RECORD CREATE FUNCTIONS
// ==============================================================================================================================================

    /* Returns a valid mock Account.
    *  Update to pass all validation rules and field requirements.
    *  iRecountNumber: an integer to make each mock Account unique. 
    */
    public static Account createTestAccount(Integer iRecordNumber)     //, Id testUserId) 
    {
        Account a = new Account();
        a.Name = 'Apex Test Account - ' + String.valueOf(iRecordNumber);        
        a.BillingPostalCode = '03801';
        a.BillingCountry = 'US';
        a.BillingState = 'NH';
        a.BillingStreet = '75 NH Ave';
        a.BillingCity = 'Portsmouth';
        a.Type = 'Customer';
        return a;     
    }
    
    /* Returns a valid mock Asset (Deployment Instance).
    *  Update to pass all validation rules and field requirements.
    *  iRecountNumber: an integer to make each mock Asset unique. 
    */
    public static Asset createTestasset(Integer iRecordNumber, Id testAccountId, Id testProduct2Id)
    {
        Asset asset = new Asset();
        asset.Name = 'Apex Test Asset' + iRecordNumber;        
        asset.AccountId = testAccountId;
        asset.Product2Id = testProduct2Id;
        return asset;     
    }

    /* Returns a valid mock Attachment.
    *  Update to pass all validation rules and field requirements.
    *  iRecountNumber: an integer to make each mock Asset unique. 
    */    
    public static Attachment createTestAttachment(Id testParentId)
    {    
        Attachment attach = new Attachment();     
        attach.Name = 'Unit Test Attachment';
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        attach.body = bodyBlob;
        attach.parentId = testParentId;
        return attach;    
    }   
    
    /* Returns a valid mock Case.
    *  Update to pass all validation rules and field requirements.
    *  iRecountNumber: an integer to make each mock Case unique. 
    */
    public static Case createTestCase(Integer iRecordNumber, Id testAccountId)    //, Id testUserId) 
    {
        Case c = new Case();
        //c.OwnerId = testUserId;     
        c.Description = 'Test Description';
        c.AccountId = testAccountId;
        c.Subject = 'Test Case' + iRecordNumber;
        c.Origin = 'Phone';
        c.Status = 'New';
        c.Has_No_DI__c = true;
        return c;      
    } 
    
    /* Returns a valid mock Contact.
    *  Update to pass all validation rules and field requirements.
    *  iRecountNumber: an integer to make each mock Contact unique. 
    */
    public static Contact createTestContact(Integer iRecordNumber, Id testAccountId)     //, Id testUserId) 
    {
        Contact c = new Contact();
        c.LastName = 'Smith' + iRecordNumber;
        c.AccountId = testAccountId;
        c.Status__c = 'Active';
        c.MailingStreet = '75 NH Ave';
        c.MailingCity = 'Portsmouth';
        c.MailingState = 'NH';
        c.MailingCountry = 'US';
        c.MailingPostalCode = '03801';
        return c;      
    } 
    
    /* Returns a valid mock CaseComment.
    *  iRecountNumber: an integer to make each mock CaseComment unique. 
    */
    public static CaseComment createTestCaseComment
    (
        Integer iRecordNumber,
        Id testParentId
    )
    {    

        CaseComment cc = new CaseComment();
        cc.ParentId = testParentId;
        cc.CommentBody = 'Apex Test Comment Body ' + iRecordNumber;
        return cc; 
        
    }

    /* Returns a valid mock EmailMessage.
    *  iRecountNumber: an integer to make each mock EmailMessage unique. 
    */
    public static EmailMessage createTestEmailMessage
    (
        Integer iRecordNumber,
        Id testParentId,
        String testFromName,
        String testFromAddress,
        String testToAddress,
        String testCcAddress,
        String testBccAddress,
        String testSubject,
        String testTextBody,
        String testStatus
    )
    {             
        EmailMessage em = new EmailMessage();
        em.ParentId = testParentId;
        em.FromName = testFromName;
        em.FromAddress = testFromAddress;
        em.ToAddress = testToAddress;
        em.CcAddress = testCcAddress;
        em.BccAddress = testBccAddress; 
        em.Subject = 'Apex Test Email # ' + iRecordNumber;
        em.TextBody = 'Apex Test Email # ' + iRecordNumber;
        em.Status = testStatus;
        return em;
    }         
             
    /* Returns a valid mock Activity/Task.
    *  iRecountNumber: an integer to make each mock Activity/Task unique. 
    */
    public static Task createTestTask
    (
        Integer iRecordNumber, 
        Id testWhoId, 
        Id testWhatId, 
        Id testRecordTypeId, 
        String testTaskType,
        String testTaskStatus,
        String testTaskPriority
    ) 
    {
    
        Task tsk = new Task();
        tsk.WhoId = testWhoId;
        tsk.WhatId = testWhatId;
        tsk.RecordTypeId = testRecordTypeId;
        tsk.Type = testTaskType;
        tsk.Description = 'Test Description ' + iRecordNumber;
        tsk.Priority = testTaskPriority;
        tsk.Status = testTaskStatus;
        tsk.Subject = 'Test Description ' + iRecordNumber;
        // OwnerId = u.Id;
        return tsk; 
        
    }    
    
    /* Returns a valid mock Opportunity.
    *  Update to pass all validation rules and field requirements.
    *  iRecountNumber: an integer to make each mock Opportunity unique. 
    */
    public static Opportunity createTestOpportunity(Integer iRecordNumber, Id testAccountId)     //, Id testUserId 
    {
        Opportunity o = new Opportunity();
        o.AccountId = testAccountId;
        o.Name = 'Apex Test Opportunity Name';
        o.StageName = 'Prospecting';
        o.Order_Status__c = 'Prospect';
        o.Amount = 25000;
        o.CloseDate = Date.Today();
        o.Effective_Date__c = Date.Today();
        return o;        
    } 
    
    /* 
    *  Returns a valid mock Opportunity Contact Role.
    *  Update to pass all validation rules and field requirements.
    */    
    public static OpportunityContactRole createTestOpportunityContactRole(Id testOpportunityId, Id testContactId, String testRole)     // Id testUserId, 
    {
        OpportunityContactRole ocr = new OpportunityContactRole();
        ocr.OpportunityId = testOpportunityId;
        ocr.ContactId = testContactId;
        ocr.Role = testRole;         
        return ocr;        
    }    
    
    /* 
    *  Returns a valid mock Opportunity Line Item.
    */    
    public static OpportunityLineItem createTestOpportunityLineItem
    (
        Integer iRecordNumber, 
        Id testOpportunityId, 
        Id testPricebookEntryId, 
        Integer testQuantity
    ) 
    {
    
        OpportunityLineItem oli = new OpportunityLineItem();
        oli.OpportunityId = testOpportunityId;
        oli.Description = 'Apex Test Line Item ' + iRecordNumber;
        oli.PricebookEntryId = testPricebookEntryId;
        oli.Quantity = testQuantity;  
        oli.TotalPrice = 1000;          
        return oli;
         
    }
        
    /* 
    *  Returns a valid mock Pricebook2.
    */    
//    public static Pricebook2 createTestPricebook
//    (
//        String testPricebookName
//    ) 
//    {
    
//        Pricebook2 pb2 = new Pricebook2();
//        pb2.Name = testPricebookName;   
//        pb2.Description = 'Apex Test Pricebook';
//        pb2.IsActive = true;
//        return pb2;
         
//    }
    
    /* 
    *  Returns a valid mock PricebookEntry.
    */    
    public static PricebookEntry createTestPricebookEntry
    (
        Id testPricebook2Id,
        Id testProduct2Id,
        Decimal testUnitPrice
    ) 
    {
    
        PricebookEntry pbe = new PricebookEntry();
        pbe.Pricebook2Id = testPricebook2Id;  
        pbe.Product2Id = testProduct2Id;
        pbe.UnitPrice = testUnitPrice;
        pbe.UseStandardPrice = false;
        pbe.IsActive = true;
        return pbe;
         
    }        
    
     /* Returns a valid mock Solution.

    */
    public static Solution createSolution(Integer iRecordNumber) 
    {
        Solution sol = new Solution(SolutionName = 'APEX TEST ' + iRecordNumber);
        return sol;
    }
    
    /* Returns a valid mock CaseSolution.

    */
    public static CaseSolution createCaseSolution(Id idCaseId, Id idSolutionId) 
    {
        CaseSolution csol = new CaseSolution(CaseId = idCaseId, SolutionId = idSolutionId);
        return csol;
    }
        
    /* Returns a valid mock User.
    *  Update to pass all validation rule and field requirements.
    *  iRecountNumber: an integer to make each mock User unique. 
    *  profilename: the name of the profile to assign the user, required.
    */
    public static User createTestUser(Integer iRecordNumber, String profilename) 
    {
        User newuser = new User();
        newuser.LastName = profilename + iRecordNumber;
        newuser.Alias = 'user' + iRecordNumber;
        newuser.Email = 'XXXXtestzzz831@newmarketinc.com';
        newuser.Username = 'XXXXtestzzz831_' + iRecordNumber + '@newmarketinc.com';
        newuser.CommunityNickname = 'test_' + iRecordNumber + '@newmarketinc.com';
        newuser.ProfileId = [SELECT id FROM Profile WHERE name = :profilename].id;
        newuser.TimeZoneSidKey = 'America/New_York';
        newuser.LocaleSidKey = 'en_US';
        newuser.EmailEncodingKey = 'UTF-8';
        newuser.LanguageLocaleKey = 'en_US';
        newuser.isActive = true;
        newuser.Division = 'Support';
        newuser.ADUserName__c = 'ADNAME' + String.valueOf(iRecordNumber); 
        return newuser;
    }

    /* Returns a valid mock Product2.

    */
    public static Product2 createProduct2(Integer iRecordNumber, Id ProductGroupId, String strSKU, String strFamily) 
    {
        Product2 p2 = new Product2();
        p2.Product_Group__c = ProductGroupId;
        p2.Product_Line__c = 'Delphi Single Property';
        p2.Revenue_Category__c = 'Services';
        p2.Unit__c = 'Subscription';
        p2.IsActive = true;
        p2.ProductCode = strSKU;
        p2.Description = 'APEX Test Class';
        p2.Family = strFamily;
        p2.Name = 'Embrace';
        // ADDED 7/16/2014
        p2.Line__c = 'Delphi';
        p2.Edition__c = 'Enterprise';
        p2.Classification__c = 'TEST DATA';
        p2.Support_Classification__c = 'Gold';
        p2.Interface_Classification__c = 'PMS';
        return p2;
    }


    /* Returns a valid mock Group.
        Possible Group Types Include:
        AllCustomerPortal
        Organization
        PRMOrganization
        Queue
        Regular
        Role
        RoleAndSubordinates
        RoleAndSubordinatesInternal
        SharingRuleGroup        
    */
    public static Group createGroup(String GroupName, String GroupDevName, String GroupType) 
    {
        Group grp = new Group();
        grp.Name = GroupName;
        grp.DeveloperName = GroupDevName;
        grp.Type = GroupType;
        return grp;
    }    
    
    /* Returns a valid mock GroupMember.
      
    */
    public static GroupMember createGroupMember(Id idGroupId, Id idUserOrGroupId) 
    {
        GroupMember grpM = new GroupMember();
        grpM.GroupId= idGroupId;
        grpM.UserOrGroupId = idUserOrGroupId;
        return grpM;
    }      
    
    
    
    
// ==============================================================================================================================================
//     CUSTOM OBJECT RECORD CREATE FUNCTIONS
// ==============================================================================================================================================

    /* Returns a valid mock NI_Change_Control__c.

    */
    public static NI_Change_Control__c createNIChangeControl(Integer iRecordNumber, String strNIChangeControlName) 
    {   
        NI_Change_Control__c nicc = new NI_Change_Control__c();
        nicc.Request_Summary__c = strNIChangeControlName + ' ' + String.ValueOf(iRecordNumber);
        nicc.Date_Required__c = Date.Today();
        return nicc;
    }
    
    /* Returns a valid mock NICC_Artifact__c.

    */
    public static NICC_Artifact__c createArtifact(Integer iRecordNumber, String strArtifactName, Id NIChangeControlId, String strType) 
    {
        NICC_Artifact__c art = new NICC_Artifact__c();
        art.Artifact_Name__c = strArtifactName + ' ' + String.ValueOf(iRecordNumber);
        art.NI_Change_Control__c = NIChangeControlId;
        art.Type__c = strType;
        return art;
    }

    /* Returns a valid mock Product Group.

    */
    public static Product_Group__c createProductGroup(Integer iRecordNumber, String strProductGroupName) 
    {
        Product_Group__c pg = new Product_Group__c();
        pg.Name = strProductGroupName;
        pg.IsActive__c = true;
        pg.IsCoreProduct__c = true;
        return pg;
    }
    
    /* Returns a valid mock NI_Customization_Service__c (HRM Service).

    */ 
    public static NI_Customization_Service__c createTestHRMService(
        Integer iRecordNumber, 
        Id testAccountId,
        String strStatus,
        Integer iTimeUnitsBalance,
        Integer iTimeUnitsPerPeriod,
        Integer iTimeUnitsUsed
    ) 
    {   
    
        Date tmpDate1 = Date.Today();
        Date tmpDate2 = tmpDate1.addDays(30);
        
        NI_Customization_Service__c cs = new NI_Customization_Service__c(); 
        cs.Account__c = testAccountId;
        cs.Expiration_Date__c = tmpDate1;
        cs.Period_Starting__c = tmpDate2; 
        cs.Period_Ending__c = tmpDate2; 
        cs.Period_Number__c = 1; 
        cs.Service_Name__c = 'Embrace';
        cs.Status__c = strStatus;
        cs.Time_Units_Balance__c = iTimeUnitsBalance;
        cs.Time_Units_Per_Period__c = iTimeUnitsPerPeriod;
        cs.Time_Units_Used__c = iTimeUnitsUsed;
        //cs.OpportunityLineItemId__c = ;
        //cs.Product__c = ;        
        return cs;        
    }
    
    /* Returns a valid mock NI_Customization_Detail (HRM Customization).

    */ 
    public static NI_Customization_Detail__c createTestHRMCustomization(Integer iRecordNumber, Id testAccountId, Id testCaseId) 
    {      
        NI_Customization_Detail__c cd = new NI_Customization_Detail__c(); 
        cd.Account__c = testAccountId; 
        cd.Case__c = testCaseId; 
        cd.State__c = 'Incomplete';
        cd.Category__c = 'Reporting';
        cd.Type__c = 'Creating Reports';
        cd.Subject__c = 'Record Subject ' + iRecordNumber;
        cd.Description__c = 'Record Description ' + iRecordNumber;
        cd.Estimated_Hours__c = 1;
        return cd;
    }

    /* Returns a valid mock NI_CustomizationDetailToService (Work Hour Allocation).

    */ 
    public static NI_CustomizationDetailToService__c createTestWorkHourAllocation
    (
        //Integer iRecordNumber, 
        Id testAccountId,
        Id testCaseId,
        Id testNI_Customization_DetailId, 
        Id testNI_Customization_ServiceId
    ) 
    {   
           
        NI_CustomizationDetailToService__c d2s = new NI_CustomizationDetailToService__c(); 
        d2s.Account__c = testAccountId;
        d2s.Detail__c = testNI_Customization_DetailId; 
        d2s.Service__c = testNI_Customization_ServiceId;   
        d2s.Case__c = testCaseId;
        d2s.Actual_Hours__c = 1; 
        d2s.CompletedDate__c = Date.Today();
        d2s.IsRunningTest__c = true;    
        return d2s;
        
    }
    
    /* NI DI REFERENCE
       Returns a valid mock NI_DI_Reference__c record.

    */ 
    public static NI_DI_Reference__c createTestNI_DI_Reference
    (
        Integer iRecordNumber, 
        Id testProductGroupId,
        Id testProductId
        
    ) 
    {   
           
        NI_DI_Reference__c dir = new NI_DI_Reference__c(); 
        dir.Active__c = true;
        dir.Deployment_Instance_Name__c = 'Test DI'; 
        dir.HRM_Apps_Value__c = 'Test App1';   
        dir.Product__c = testProductId;
        dir.Product_Group__c = testProductGroupId;
        dir.Product_Line__c = 'Test Product Line';        
        return dir;
        
    }
    
    /* MARKETING QUALIFIED LEAD
       Returns a valid mock Marketing_Qualified_Lead__c record.
    */ 
    public static Marketing_Qualified_Lead__c createTestMarketingQualifiedLead
    (
         Id testContactId
    ) 
     {              
        Marketing_Qualified_Lead__c mql = new Marketing_Qualified_Lead__c();
        mql.Contact_Name__c = testContactId;
        return mql;        
     }   
         
     // Returns a valid mock Newmarket Web Services (NWS) Location record (newmarketsvcs__Location__c) record.

    public static newmarketsvcs__Location__c createTestNewmarketsvcsLocation
    (
        Integer iRecordNumber
    ) 
    {         
        newmarketsvcs__Location__c l = new newmarketsvcs__Location__c(); 
        l.newmarketsvcs__Name__c = 'TEST LOCATION' + iRecordNumber; 
        return l;
        
    } 
    
    // Returns a valid mock Newmarket Web Services (NWS) Notification record (newmarketsvcs__Notification__c) record.
    public static newmarketsvcs__Notification__c createTestNewmarketsvcsNotification
    (
        Integer iRecordNumber, 
        Id testLocationId,
        String testSubject
    ) 
    {   
           
        newmarketsvcs__Notification__c n = new newmarketsvcs__Notification__c(); 
        n.newmarketsvcs__Subject__c = testSubject;
        n.newmarketsvcs__Entity_ID__c = 'TEST ENDTITY ID'; 
        n.newmarketsvcs__Tracking_Entry_ID__c = 'TEST TRACKING ENTRY ID';   
        n.newmarketsvcs__Message_Type__c = 'TEST MESSAGE TYPE';
        n.newmarketsvcs__Notification_GUID__c = String.ValueOf(iRecordNumber);
        n.newmarketsvcs__Location__c = testLocationId;        
        return n;
        
    }
    
     /* NI ORG DETAILS
       Returns a valid mock NI_Org_Details__c record.
    */ 
    public static NI_Org_Details__c createTestNiOrgDetails
    (
        Id idRt, 
        Integer iRecordNumber,         
        String orgType
    ) 
    {              
        NI_Org_Details__c od = new NI_Org_Details__c(); 
        od.RecordTypeId = idRt;
        od.Org_Name__c = 'TEST'+ iRecordNumber;
        od.AdminLoginName__c = 'test@test.com';
        od.AdminPassword__c = '123456789';
        od.Org_Type__c = orgType;      
        return od;        
    }   
   
    /* SALES EXPENSE REPORT
       Returns a valid mock Expense_Report__c record.
    */ 
    public static Expense_Report__c createTestSalesExpenseReport
    (
     Integer iRecordNumber
    ) 
    {              
        Expense_Report__c e = new Expense_Report__c(); 
        e.Name = 'TEST' + iRecordNumber;
        return e;        
    }   
                      

     /* NI TRUST
       Returns a valid mock NI_Trust__c record.
    */ 
    public static NI_Trust__c createTestNITrust
    (
        String strPlatformName, 
        Integer iRecordNumber      
    ) 
    {              
        NI_Trust__c trust = new NI_Trust__c(); 
        trust.IsActive__c = true;
        trust.Platform_Name_External__c = strPlatformName;
        trust.Platform_Name_Internal__c = strPlatformName;
        trust.IsActive__c = true;
        trust.Sort_Order__c = 1;
        return trust;        
    }   

    /* NI TRUST OUTAGE
       Returns a valid mock NI_Trust_Outage__c record.
    */ 
    public static NI_Trust_Outage__c createTestNITrustOutage
    (
        Id idTrust, 
        Datetime dtOutageStart,         
        Datetime dtOutageEnd,
        Integer iRecordNumber 
    ) 
    {              
        NI_Trust_Outage__c trustOutage = new NI_Trust_Outage__c(); 
        trustOutage.NI_Trust__c = idTrust;
        trustOutage.Make_Public__c = true;
        trustOutage.Public_Details__c = 'APEX TEST DETAILS TEXT';
        trustOutage.Outage_Start_Date_Time__c = dtOutageStart;
        trustOutage.Outage_End_Date_Time__c = dtOutageEnd;      
        return trustOutage;        
    }   
   
    /* CHANGE REQUEST
        Returns a valid mock SFDC_CSP_Development_Request__c record.
    */ 
    public static SFDC_CSP_Development_Request__c createChangeRequest
    (
        Id testProductGroupId, 
        Id testVersionId, 
        Id testPartId, 
        Integer iRecordNumber
    ) 
    {
        SFDC_CSP_Development_Request__c chngReq = new SFDC_CSP_Development_Request__c(); 
        chngReq.Type__c = 'Defect';
        chngReq.Title__c = 'NI CHANGE REQUEST RECORD ' + String.valueOf(iRecordNumber);
        chngReq.Description__c = 'NI CHANGE REQUEST RECORD';
        chngReq.Product_Group__c = testProductGroupId;
        chngReq.Version__c = testVersionId;
        chngReq.Part__c = testPartId;
        chngReq.Support_Priority__c = '4 - Low';
        return chngReq;        
    }      
   
    /* PART
        Returns a valid mock SFDC_CSP_Part__c record.
    */ 
    public static SFDC_CSP_Part__c createPart
    (
        Id testProduct2Id, 
        Id testVersionId,
        Integer iRecordNumber
    ) 
    {
        SFDC_CSP_Part__c niPrt = new SFDC_CSP_Part__c(); 
        niPrt.Name = 'TEST PART NAME ' + String.valueOf(iRecordNumber);
        niPrt.Product__c = testProduct2Id;
        niPrt.Version__c = testVersionId;
        return niPrt;        
    }    
   
    /* VERSION
        Returns a valid mock SFDC_CSP_Version__c record.
    */ 
    public static SFDC_CSP_Version__c createVersion
    (
        String strVersionName, 
        Id strProductGroupId,
        Integer iRecordNumber
    ) 
    {
        SFDC_CSP_Version__c niVrs = new SFDC_CSP_Version__c (); 
        niVrs.Name = strVersionName + ' ' + String.valueOf(iRecordNumber);
        niVrs.Product_Group__c = strProductGroupId;
        return niVrs;        
    } 
   
    /* NICC RISK SETUP
        Returns a valid mock NICC_Risk_Setup__c record.
    */ 
    public static NICC_Risk_Setup__c createNICCRiskSetup
    (
        String strRiskDesc,
        String strRiskType, 
        Integer iSortNumber, 
        Integer iRecordNumber
    ) 
    {
        NICC_Risk_Setup__c niccRS = new NICC_Risk_Setup__c(); 
        niccRS.Description__c = strRiskDesc + ' ' + String.valueOf(iRecordNumber);
        niccRS.Level1Desc__c = 'level 1'; 
        niccRS.Level2Desc__c = 'level 2';
        niccRS.Level3Desc__c = 'level 3'; 
        niccRS.Level4Desc__c = 'level 4'; 
        niccRS.Level1Weight__c = 1; 
        niccRS.Level2Weight__c = 2; 
        niccRS.Level3Weight__c = 3;
        niccRS.Level4Weight__c = 4;
        niccRS.Type__c = strRiskType;
        niccRS.SortOrder__c = iSortNumber;
        return niccRS;        
    }     
    
    /* NICC RISK
        Returns a valid mock NICC_Risk__c record.
    */ 
    public static NICC_Risk__c createNICCRisk
    (
        String strRiskDesc, 
        String strRiskType,
        Boolean bLvl1, 
        Boolean bLvl2, 
        Boolean bLvl3, 
        Boolean bLvl4, 
        String strNICC, 
        Integer iSortNumber, 
        Integer iRecordNumber
    ) 
    {
        NICC_Risk__c niccRsk = new NICC_Risk__c(); 
        niccRsk.Description__c = strRiskDesc + ' ' + String.valueOf(iRecordNumber);
        niccRsk.Level1Desc__c = 'level 1'; 
        niccRsk.Level1Value__c = bLvl1; 
        niccRsk.Level2Desc__c = 'level 2'; 
        niccRsk.Level2Value__c = bLvl2; 
        niccRsk.Level3Desc__c = 'level 3';  
        niccRsk.Level3Value__c = bLvl3; 
        niccRsk.Level4Desc__c = 'level 4'; 
        niccRsk.Level4Value__c = bLvl4; 
        niccRsk.Type__c = strRiskType;
        niccRsk.SortOrder__c = iSortNumber;
        niccRsk.NICC_ID__c = strNICC;
        return niccRsk;        
    }      

    /* ICESubscription
        Returns a valid mock ICESubscription__c record.
    */ 
    public static ICESubscription__c createICESubscription
    (
        Integer iRecordNumber,
        Decimal decSubscriptionID 
    )
    {
        ICESubscription__c iceSub = new ICESubscription__c(); 
        iceSub.SubscriptionName__c = 'Test ' + String.valueOf(iRecordNumber);
        iceSub.DelphiNetIsActive__c = true; 
        iceSub.SubscriptionID__c = decSubscriptionID;        
        return iceSub;             
    }
    
    /* ICEProperty
        Returns a valid mock ICEProperty__c record.
    */ 
    public static ICEProperty__c createICEProperty
    (
        Integer iRecordNumber,
        Decimal decSubscriptionID,
        Decimal decPropertyId 
    )
    {        
        ICEProperty__c icePrp = new ICEProperty__c();         
        icePrp.PropertyName__c = 'Test ' + String.valueOf(iRecordNumber);  
        icePrp.DelphiNetIsActive__c = true;         
        icePrp.SubscriptionID__c = decSubscriptionID;     
        icePrp.PropertyId__c = decPropertyId;
        return icePrp;   
    }    
       
    /* ICEUser
        Returns a valid mock ICEUser__c record.
    */ 
    public static ICEUser__c createICEUser
    (
        Integer iRecordNumber,
        Decimal decSubscriptionID,
        Decimal decPropertyId, 
        Decimal decUserId
    )
    {
        ICEUser__c iceUsr = new ICEUser__c(); 
        iceUsr.DelphiNetIsActive__c = true;
        iceUsr.SubscriptionID__c = decSubscriptionID;
        iceUsr.DefaultPropertyId__c = decPropertyId;
        iceUsr.UserID__c = decUserId;
        iceUsr.Email__c = 'TestUser' + String.valueOf(iRecordNumber) + '@newmarketinc.com'; 
        iceUsr.LoginName__c = 'TestUser' + String.valueOf(iRecordNumber) + '@newmarketinc.com'; 
        iceUsr.UserName__c = 'Test User ' + String.valueOf(iRecordNumber);         
        return iceUsr;         
    }

//============================================================================================================================================= 
  /*************************************************************
    * Creates a Project with parameters provided for:
    * - Name
    * - Region
    * - Practice
    * - Project Stage
    * - Opportunity (optional)
    * Automatically sets the project to Active, Billable,
    * Allow timecards and expenses without assignment 
    **************************************************************/
    public static pse__Proj__c createTestProject(Integer iRecordNumber, String projectName, pse__Region__c region, pse__Practice__c practice, String projectStage, Opportunity opp)
    {
       pse__Proj__c testProject = new pse__Proj__c(Name=projectName + iRecordNumber,
                                        pse__Is_Active__c=true,
                                        pse__Is_Billable__c=true,
                                        pse__Allow_Timecards_Without_Assignment__c=true,
                                        pse__Allow_Expenses_Without_Assignment__c=true);
        
        testProject.pse__Region__c = region.Id;
        testProject.pse__Practice__c = practice.Id;
        testProject.pse__Stage__c = projectStage;
        testProject.pse__Project_Type__c = 'Customer Project';
        testProject.pse__Project_Status__c = 'Green';  //ADDED PER SALESFORCE.COM CHANGE REQUEST: NICC-008249
        if(opp != null)
        {
            testProject.pse__Opportunity__c = opp.Id;
        }
        return testProject;
        
    }
               
//=========================================================================================================================================================
  //CREATE A TEST MILESTONE 
    public static pse__Milestone__c createTestMilestone(String milestoneName, pse__Proj__c project, boolean cfte, boolean cfee, String milestoneType)
    {
        pse__Milestone__c testMilestone = new pse__Milestone__c(Name=milestoneName);
        testMilestone.pse__Project__c = project.Id;
        testMilestone.pse__Closed_for_Expense_Entry__c = cfee;
        testMilestone.pse__Closed_for_Time_Entry__c = cfte;
        testMilestone.pse__Target_Date__c = date.newInstance(2011,12,31);
        testMilestone.pse__Status__c = 'Draft/Tentative';
        testMilestone.Milestone_Type__c = milestoneType;
       
        return testMilestone;
    }
    
//===========================================================================================================================================================
  //CREATE A TEST REGION
    public static pse__Region__c createTestRegion(Integer iRecordNumber, String regionName)
    {
        pse__Region__c testRegion = new pse__Region__c(Name=regionName + iRecordNumber);
        return testRegion;
    }
    
//========================================================================================================================================================
   //CREATE A TEST PRACTICE
    public static pse__Practice__c createTestPractice(Integer iRecordNumber, String practiceName)
    {
        pse__Practice__c testPractice = new pse__Practice__c(Name=practiceName + iRecordNumber);
        return testPractice;
    }
    
//=======================================================================================================================================================
//CREATE A MILESTONE FORECAST RECORD
  public static Milestone_Forecast__c createTestMilestoneForecast(pse__Milestone__c milestone)
      {  
         Milestone_Forecast__c mf = new Milestone_Forecast__c();
         mf.Milestone__c = milestone.Id;
         mf.Forecast_Date__c = date.newInstance(2015, 05, 15);
         return mf;
      }                                                              

//=======================================================================================================================================================
// CREATE A CUSTOMER RELATIONS ENGAGEMENT RECORD

    public static NI_Customer_Relations_Engagement__c createCustomerRelationsEngagement (Integer iRecordNumber, Id AccountId, Id EngagementContactId)
    {  
    
        NI_Customer_Relations_Engagement__c nicrengage = new NI_Customer_Relations_Engagement__c();
        
        nicrengage.Type__c = 'Reactive';
        nicrengage.Account__c = AccountId;
        nicrengage.Engagement_Contact__c = EngagementContactId;
        nicrengage.Summary__c = 'Apex Test #' + String.valueOf(iRecordNumber);  
        
        return nicrengage ;
        
    }



}