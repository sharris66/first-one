/****************************************************************************************
Name            : NI_TestClassData_Test Test Class
Author          : 
Created Date    : 11/21/2012
Last Mod Date   : 02/14/2014
Last Mod By     : 
NICC Reference  : 
Description     : test Class for NI_TestClassData Class
                : 
                : 
******************************************************************************************/
@isTest (SeeAllData=true)
private class NI_TestClassData_Test
{

    static testMethod void myUnitTest() 
    {
      //ADDED PER FINANCIALFORCE SUPPORT TO PREVENT WEB SERVICES CALL OUT MESSAGE WHEN RUNNING TEST CLASSES THAT INVOLVE THE CONTACT OBJECT  
        pse__Triggers__c pt = [SELECT Id, pse__Resource_Geolocation_Trigger_Disabled__c FROM pse__Triggers__c]; 
        pt.pse__Resource_Geolocation_Trigger_Disabled__c = true;
        update(pt); 
        
        Id rtId = NI_TestClassData.getRecordTypeId('Account', 'Parent Account');

// ==============================================================================================================================================
//     TEST STANDARD OBJECT RECORD CREATE FUNCTIONS
// ==============================================================================================================================================
        
        User u = NI_TestClassData.createTestUser(1, 'NI Administrator'); 
        insert u;
        
        Account a = NI_TestClassData.createTestAccount(1);
        insert a;
        
        Product_Group__c pgp = NI_TestClassData.createProductGroup(1, 'Apex Test Group');
        insert pgp;

        Product2 prd = NI_TestClassData.createProduct2(1, pgp.Id, 'ZZZFULFILL-APEX-001', 'Subscription');
        insert prd;
        
        Asset asset = NI_TestClassData.createTestAsset(1, a.Id, prd.Id);
        asset.Product_Group__c = pgp.Id;
        insert asset;

        Attachment attach = NI_TestClassData.createTestAttachment(a.Id);
        insert attach;
        
        Case c = NI_TestClassData.createTestCase(1, a.Id);
        insert c;
        
        Solution sol = NI_TestClassData.createSolution(1); 
        insert sol;

        CaseSolution csol = NI_TestClassData.createCaseSolution(c.Id, sol.Id);
        insert csol;

        Contact cnt = NI_TestClassData.createTestContact(1, a.Id);
        insert cnt;

        Id rtIdOpp = NI_TestClassData.getRecordTypeId('Opportunity', 'Small Deal Opportunity');
        Opportunity o = NI_TestClassData.createTestOpportunity(1, a.Id); 
        o.RecordTypeId = rtIdOpp;
        insert o;

        CaseComment cc = NI_TestClassData.createTestCaseComment(1, c.Id);
        
        EmailMessage em = NI_TestClassData.createTestEmailMessage(1, c.Id, 'Joe Doe', 'jdoe@newsoft.com', 'jdoe@newsoft.com', 'jdoe@newsoft.com', 'jdoe@newsoft.com', 'Apex Test Email', 'Apex Test Email Body', '1');

        Id rtId2 = NI_TestClassData.getRecordTypeId('Task', 'NI Support');
        Task tsk = NI_TestClassData.createTestTask(1, u.Id, c.Id, rtId2, 'Call', 'Completed', 'Low');

        OpportunityContactRole ocr = NI_TestClassData.createTestOpportunityContactRole(o.Id, cnt.Id, 'Bill To'); 
        
        //Pricebook2 pb2 = NI_TestClassData.createTestPricebook('Apex Test');
        //insert pb2;

        Pricebook2 pb2 = [SELECT id FROM Pricebook2 WHERE isStandard = true];
    
        PricebookEntry pbe = NI_TestClassData.createTestPricebookEntry(pb2.Id, prd.Id, 1000);
        insert pbe;
        
        OpportunityLineItem oli = NI_TestClassData.createTestOpportunityLineItem(1, o.Id, pbe.Id, 1);

        Group grp = NI_TestClassData.createGroup('PUBLIC TEST GRP 1', 'PUBLICTESTGRP1', 'Regular'); 

        GroupMember grpM = NI_TestClassData.createGroupMember(grp.Id, u.Id);


// ==============================================================================================================================================
//     TEST CUSTOM OBJECT RECORD CREATE FUNCTIONS
// ==============================================================================================================================================
        
        NI_Change_Control__c nicc1 = NI_TestClassData.createNIChangeControl(1, 'APEX TEST');
        insert nicc1;
        
        NICC_Artifact__c art1 = NI_TestClassData.createArtifact(1, 'APEX TEST', nicc1.Id, 'Communication Plan');

        NI_Customization_Service__c hrms1 = NI_TestClassData.createTestHRMService(1, a.Id, 'Active', 4, 10, 6);

        NI_Customization_Detail__c hrmd1 = NI_TestClassData.createTestHRMCustomization (1, a.Id, c.Id);

        NI_CustomizationDetailToService__c wha1 = NI_TestClassData.createTestWorkHourAllocation(a.Id, c.Id, hrmd1.Id, hrms1.Id);     

        NI_DI_Reference__c dir = NI_TestClassData.createTestNI_DI_Reference(1, pgp.Id, prd.Id);
        
        Id rtInit = NI_TestClassData.getRecordTypeId('NI_Org_Details__c', 'HRM Support Admin');       
        NI_Org_Details__c od = NI_TestClassData.createTestNiOrgDetails(rtInit, 1, 'Salesforce Production');
        
        Marketing_Qualified_Lead__c mql = NI_TestClassData.createTestMarketingQualifiedLead(cnt.Id);
        insert mql;
                
        newmarketsvcs__Location__c nwsl = NI_TestClassData.createTestNewmarketsvcsLocation(1);
        
        newmarketsvcs__Notification__c nwsn = NI_TestClassData.createTestNewmarketsvcsNotification(1,nwsl.id,'Error');
        
        NI_Trust__c objT1 =  NI_TestClassData.createTestNITrust('Delphi as a Service (DaaS)', 1);
        
        NI_Trust_Outage__c objTO1 = NI_TestClassData.createTestNITrustOutage(objT1.Id, DateTime.Now(), DateTime.Now(), 1);
        
        Expense_Report__c er = NI_TestClassData.createTestSalesExpenseReport(1);

        SFDC_CSP_Version__c vrs01 = NI_TestClassData.createVersion('v1.', pgp.Id, 1);
        insert vrs01;
        
        SFDC_CSP_Part__c prt01 = NI_TestClassData.createPart(prd.Id, vrs01.Id, 1);
        insert prt01;
        
        SFDC_CSP_Development_Request__c cr01 = NI_TestClassData.createChangeRequest(pgp.Id, vrs01.Id, prt01.Id, 1);

    }

    // ADDED 02/14/2014 
    static testMethod void TestClassData2() 
    {

        NI_Change_Control__c nicc = NI_TestClassData.createNIChangeControl(1, 'APEX TEST - ' + String.ValueOf(DateTime.Now()));
        insert nicc;
        
        NICC_Risk_Setup__c niccRskSU = NI_TestClassData.createNICCRiskSetup('RISK DESC', 'HRM', 1, 1); 
        insert niccRskSU;
        
        System.assertNotEquals(nicc.Id, null);
        
        NICC_Risk__c niccRsk = NI_TestClassData.createNICCRisk('RISK DESC', 'HRM', true, false, false, false, nicc.Id, 1, 1);     
        insert niccRsk;
        
        Account iceAcct = NI_TestClassData.createTestAccount(1);
        insert iceAcct; 
        
        ICESubscription__c iceSub = NI_TestClassData.createICESubscription(1, 1000000000);
        insert iceSub; 
        
        ICEProperty__c icePrp = NI_TestClassData.createICEProperty(1, 1000000000, 1000000001);
        insert icePrp; 

        ICEUser__c iceUsr = NI_TestClassData.createICEUser(1, 1000000000, 1000000001, 1000000002);
        insert iceUsr; 

    }
    
//================================================================================================================    
       // ADDED 05/08/2014 
          static testMethod void TestClassData3()
          { 
             //CREATE A TEST PSA REGION  
               pse__Region__c defaultRegion =  NI_TestClassData.createTestRegion(1, 'psaTestRegion');
               insert defaultRegion; 
       
             //CREATE A TEST PSA PRACTICE  
               pse__Practice__c defaultPractice = NI_TestClassData.createTestPractice(1, 'psaTestPractice');
               insert defaultPractice;  
          
             //CREATE A PROJECT
               pse__Proj__c tp = NI_TestClassData.createTestProject(1,'Assignment/Milestone Date Test Project', defaultRegion, defaultPractice, 'Draft', null);
               insert tp;
        
             //CREATE A TEST MILESTONE  
               pse__Milestone__c milestone = NI_TestClassData.createTestMilestone('PSA Test Milestone', tp, false, false, 'Billable Milestone');
               insert milestone;  
               
             //  
               
          }
          
          
    // ADDED 06/08/2014 
    static testMethod void TestClassData4()
    {        
        // ================================================================================================
        // BASE DEPENDECY RECORDS (START) =================================================================
        // ================================================================================================

//        User u = NI_TestClassData.createTestUser(1, 'NI Administrator'); 
//        insert u;
        
        Account a = NI_TestClassData.createTestAccount(1);
        insert a;
        
        Contact cnt = NI_TestClassData.createTestContact(1, a.Id);
        insert cnt;
                
        Product_Group__c pgp = NI_TestClassData.createProductGroup(1, 'Apex Test Group');
        insert pgp;

        Product2 prd = NI_TestClassData.createProduct2(1, pgp.Id, 'ZZZFULFILL-APEX-001', 'Subscription');
        insert prd;
        
        Asset asset = NI_TestClassData.createTestAsset(1, a.Id, prd.Id);
        asset.Product_Group__c = pgp.Id;
        insert asset;

//        Attachment attach = NI_TestClassData.createTestAttachment(a.Id);
//        insert attach;
        
//        Case c = NI_TestClassData.createTestCase(1, a.Id);
//       insert c;
        
//        Solution sol = NI_TestClassData.createSolution(1); 
//        insert sol;

//        CaseSolution csol = NI_TestClassData.createCaseSolution(c.Id, sol.Id);
//        insert csol;

        // ================================================================================================
        // BASE DEPENDECY RECORDS (END) ===================================================================
        // ================================================================================================
        
             
        NI_Customer_Relations_Engagement__c ni_cr_engagemnt = NI_TestClassData.createCustomerRelationsEngagement(1, a.Id, cnt.Id);
        insert ni_cr_engagemnt;
    
    }
                  
          
          
}