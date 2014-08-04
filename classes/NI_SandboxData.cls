/****************************************************************************************
Name            : NI_SandboxData Class
Author          : Sean Harris
Created Date    : 5/9/2012
Last Mod Date   : 2/14/2014
Last Mod By     : Stuart Emery
NICC Reference  : NICC-007105: Creation of class to populate new dev sandboxes
Description     : Intended use: After creation or refresh of a Sandbox run the following  
                : code to create some test data: 
                :       NI_SandboxData.CreateData()
******************************************************************************************/
public class NI_SandboxData 
{
    
 
    public static void CreateData()
    {
 
        List<Account> lstAllAccounts = new List<Account>(); 
        CreateChildAccounts();
        List<Contact> lstAllContacts = new List<Contact>();
        List<Case> lstAllCases = new List<Case>(); 
        List<Opportunity> lstAllOpportunities = new List<Opportunity>(); 
        List<Asset> lstAllAssets = new List<Asset>(); 
        
        lstAllAccounts = CreateAccounts();
        lstAllContacts = CreateContacts(lstAllAccounts);
        lstAllCases = CreateCases(lstAllContacts);
        lstAllOpportunities = CreateOpportunities(lstAllAccounts);
        lstAllAssets = CreateAssets(lstAllAccounts);
        
    }
 
    private static List<Account> CreateAccounts()
    {
 
        // ============================================================
        // CREATE ACCOUNTS (5)
        // ============================================================
        List<Account> lstNewAccounts = new List<Account>();
        List<Account> lstAccInsert = new List<Account>();
        List<String> accNames = new List<String> 
        { 
            'Newmarket Hotels & Resorts, Customer, 75 New Hampshire Ave, Portsmouth, NH, 03801, US', 
            'Newmarket Suites - Boston, Customer, 99 Boyleston St., Boston, MA, 02199, US',   
            'Newmarket Suites - Orlando, Customer, 105 Ocean Ave, Orlando, FL, 32819, US',  
            'Newmarket Suites - San Francisco, Customer, 8935 Tenderloin Way, San Francisco, CA, 94102, US',
            'Newmarket Suites - Denver, Customer, 1 International Drive, Denver, CO, 80207, US'
        };
        
        for (integer i = 0; i < accNames.Size(); i++)
        {
            string[] accAttributes = accNames[i].split(',');
            Account a = NI_TestClassData.createTestAccount(i);
            
            a.Name = accAttributes[0].trim();
            a.Type = accAttributes[1].trim();
            a.BillingStreet = accAttributes[2].trim();
            a.BillingCity= accAttributes[3].trim(); 
            a.BillingState = accAttributes[4].trim();          
            a.BillingPostalCode = accAttributes[5].trim(); 
            a.BillingCountry = accAttributes[6].trim();
            a.Phone = '(603)430-6738'; 
            a.AccountNumber = 'NI00' + String.ValueOf(i);
            
            lstAccInsert.add(a);
        }
        
        Database.insert(lstAccInsert);
 
        lstNewAccounts = [SELECT Id, Name 
                            FROM Account 
                            WHERE Name LIKE 'Newmarket%' 
                            AND Phone = '(603)430-6738'
                            AND AccountNumber LIKE 'NI00%'
                            LIMIT 10];
        
        return lstNewAccounts;
 
    }
    
    private static void CreateChildAccounts()
    {
        
        List<Account> accParent = [SELECT Id FROM Account WHERE Name = 'Newmarket Hotels & Resorts' LIMIT 1];
        List<Account> lstAccUpdate = new List<Account>();
        
        for (Account acc : [SELECT Id FROM Account WHERE Name LIKE 'Newmarket Suites%'])
        {
            acc.ParentId = accParent[0].Id;
            lstAccUpdate.add(acc);
        }
        
        Database.update(lstAccUpdate);
        
    }
    
    private static List<Contact> CreateContacts(List<Account> accs)
    {
 
        // ============================================================
        // CREATE CONTACTS (15)
        // ============================================================
        List<Contact> lstNewContacts = new List<Contact>();
        List<Contact> lstContactInsert = new List<Contact>();
        List<String> contactNames = new List<String> 
        { 
            'Erika, Tate, sharris@newmarketinc.com, (603)430-6738, 75 New Hampshire Ave, Portsmouth, NH, 03801, US',  
            'Jillian, Tanner, semery@newmarketinc.com, (603)427-5885, 75 New Hampshire Ave, Portsmouth, NH, 03801, US',  
            'Felicia, Gump, pdixon@newmarketinc.com, (603)427-5890, 75 New Hampshire Ave, Portsmouth, NH, 03801, US',  
 
            'Frederick, Stover, sharris@newmarketinc.com, (603)430-6738, 99 Boyleston St., Boston, MA, 02199, US', 
            'Gerik, Koen, semery@newmarketinc.com, (603)430-6738, 99 Boyleston St., Boston, MA, 02199, US', 
            'Theresa, Moulaine, pdixon@newmarketinc.com, (603)427-5890, 99 Boyleston St., Boston, MA, 02199, US', 
 
            'Gunther, Weller, sharris@newmarketinc.com, (603)430-6738, 105 Ocean Ave, Orlando, FL, 32819, US', 
            'Jalane, Ayrole, semery@newmarketinc.com, (603)427-5885, 105 Ocean Ave, Orlando, FL, 32819, US', 
            'Lara, Moore, pdixon@newmarketinc.com, (603)427-5890, 105 Ocean Ave, Orlando, FL, 32819, US', 
 
            'Jessara, Cordell, sharris@newmarketinc.com, (603)430-6738, 8935 Tenderloin Way, San Francisco, CA, 94102, US',
            'Evan, Larson, semery@newmarketinc.com, (603)427-5885, 8935 Tenderloin Way, San Francisco, CA, 94102, US',
            'Joachim, Brenlow, pdixon@newmarketinc.com, (603)427-5890, 8935 Tenderloin Way, San Francisco, CA, 94102, US',
 
            'Julia, Gallina, sharris@newmarketinc.com, (603)430-6738, 1 International Drive, Denver, CO, 80207, US',
            'Rebecca, Laughlin, semery@newmarketinc.com, (603)427-5885, 1 International Drive, Denver, CO, 80207, US',
            'Keldric, Boucher, pdixon@newmarketinc.com, (603)427-5890, 1 International Drive, Denver, CO, 80207, US'
            
        };
        
        integer iCounter = 1;
        integer iAccountIndex = 0;
        
        for (integer i = 0; i < contactNames.Size(); i++)
        {
            string[] accAttributes = contactNames[i].split(',');
            Contact c = NI_TestClassData.createTestContact(i, accs[iAccountIndex].Id);
            
            c.FirstName = accAttributes[0].trim();
            c.LastName = accAttributes[1].trim();
            c.email = accAttributes[2].trim();   
            c.phone = accAttributes[3].trim();         
            c.MailingStreet = accAttributes[4].trim();  
            c.MailingCity = accAttributes[5].trim();    
            c.MailingState = accAttributes[6].trim();   
            c.MailingPostalCode = accAttributes[7].trim();  
            c.MailingCountry = accAttributes[8].trim(); 
            
            lstContactInsert.add(c);
            
            if (iCounter == 3)
            {
                iCounter = 1;
                iAccountIndex += 1;
            }
            else
            {
                iCounter += 1;
            }
            
        }
        
        Database.insert(lstContactInsert);
 
        lstNewContacts = [SELECT Id, AccountId FROM Contact LIMIT 30];
        
        return lstNewContacts;
 
    }       
    
    private static List<Case> CreateCases(List<Contact> cntcts)
    {
 
        // ============================================================
        // CREATE CASES (45)
        // ============================================================
        List<Case> lstNewCases = new List<Case>();
        List<Case> lstCaseInsert = new List<Case>();
 
        for (integer i = 0; i < cntcts.Size(); i++)
        {           
            for (integer j = 0; j < 3; j++)
            {               
 
                Case c = NI_TestClassData.createTestCase(j, cntcts[i].AccountId);
                
                c.ContactId = cntcts[i].Id; 
                c.Subject = 'Test Case #' + String.ValueOf(j);      
                c.Description = 'Details here...';
                c.Status = 'Working';
                
                lstCaseInsert.add(c);           
            }           
        }
        
        Database.insert(lstCaseInsert);
 
        lstNewCases = [SELECT Id FROM Case LIMIT 60];
        
        return lstNewCases;
 
    }   
 
    private static List<Opportunity> CreateOpportunities(List<Account> accs)
    {
 
        // ============================================================
        // CREATE OPPORTUNITIES (15)
        // ============================================================
        List<Opportunity> lstNewOpportunities = new List<Opportunity>();
        List<Opportunity> lstOpportunityInsert = new List<Opportunity>();
 
        for (integer i = 0; i < accs.Size(); i++)
        {           
            for (integer j = 0; j < 3; j++)
            {               
 
                Opportunity o = NI_TestClassData.createTestOpportunity(j, accs[i].Id);
                
                o.Name = accs[i].Name + ' Opportunity #' + String.ValueOf(accs[i].Name);
                o.StageName = 'Prospecting';
                o.Order_Status__c = 'Prospect';
                o.Amount = 25000 * j;
                o.CloseDate = Date.Today().addMonths(6);
                o.Effective_Date__c = Date.Today().addMonths(6);
                
                lstOpportunityInsert.add(o);
                        
            }           
        }
        
        Database.insert(lstOpportunityInsert);
 
        lstNewOpportunities = [SELECT Id FROM Opportunity LIMIT 60];
        
        return lstNewOpportunities;
 
    }
 
    private static List<Asset> CreateAssets(List<Account> accs)
    {
 
        // ============================================================
        // CREATE ASSETS (15)
        // ============================================================
        List<Asset> lstNewAssets = new List<Asset>();
        List<Asset> lstAssetInsert = new List<Asset>();
        
        List<Product_Group__c> lstPGInsert = new List<Product_Group__c>();
        List<SFDC_CSP_Version__c> lstVersionInsert = new List<SFDC_CSP_Version__c>();
 
        Product_Group__c pg1 = new Product_Group__c(Name = 'Delphi Multi Property', IsCoreProduct__c = true, TFS_Collection__c = 'http://vas066:8080/tfs/newmarket');
        Product_Group__c pg2 = new Product_Group__c(Name = 'Meetingbroker', IsCoreProduct__c = true, TFS_Collection__c = 'http://vas066:8080/tfs/newmarket');
        Product_Group__c pg3 = new Product_Group__c(Name = 'Cendyn', IsCoreProduct__c = false, TFS_Collection__c = 'http://vas066:8080/tfs/newmarket');
        
        insert pg1;
        insert pg2;
        insert pg3;         
        
        SFDC_CSP_Version__c v1 = new SFDC_CSP_Version__c(Name = 'Delphi v9.5.3 AP5', Inactive__c = false, Product_Group__c = pg1.Id);
        SFDC_CSP_Version__c v2 = new SFDC_CSP_Version__c(Name = 'MeetingBroker v3.0', Inactive__c = false, Product_Group__c = pg2.Id);
        //SFDC_CSP_Version__c v3 = new SFDC_CSP_Version__c(Name = 'Delphi v9.5.3 AP5', Inactive__c = false, Product_Group__c = pg3.Id);
 
        insert v1;
        insert v2;
        
        //CREATE A TEST PRODUCT GROUP FOR THE TEST PRODUCT RECORD
//        Product_Group__c pgp = NI_TestClassData.createProductGroup(1, 'Apex Test Group');
//        insert pgp;
        
        List<Product2> lstProds = new List<Product2>();
        
        //CREATE TEST PRODUCTS TO BE USED WHEN CREATING A TEST DEPLOYMENT INSTANCE
        //UPDATED ON 2/14/2014 BASED ON CONTRAINT RULE THAT MAKES DEPLOYMENT INSTANCES UNIQUE FOR EACH ACCOUNT
        Product2 prd01 = NI_TestClassData.createProduct2(1, pg1.Id, 'HRM-DFDCQS-01-TEST', 'Subscription');
        lstProds.add(prd01);
        
        Product2 prd02 = NI_TestClassData.createProduct2(2, pg2.Id, 'HRM-DFDCQS-01-TEST2', 'Subscription');
        lstProds.add(prd02);
        
        Product2 prd03 = NI_TestClassData.createProduct2(3, pg3.Id, 'HRM-DFDCQS-01-TEST3', 'Subscription');
        lstProds.add(prd03);
        
        Database.Insert(lstProds);
 
        for (integer i = 0; i < accs.Size(); i++)
        {
            
            Asset a1 = NI_TestClassData.createTestasset(1, accs[i].Id, prd01.Id);
            a1.Name = 'Delphi Multi Property 9.5.3';
            a1.Product_Group__c = pg1.Id;
            a1.Version__c = v1.Id;
            a1.Product2Id = prd01.Id;
            a1.Status = 'Installed';
            lstAssetInsert.add(a1);
            
            Asset a2 = NI_TestClassData.createTestasset(2, accs[i].Id, prd02.Id);
            a2.Name = 'MeetingBroker';
            a2.Product_Group__c = pg2.Id;
            a2.Version__c = v2.Id;
            a2.Product2Id = prd02.Id;
            a2.Status = 'Installed';  
            lstAssetInsert.add(a2);
            
            Asset a3 = NI_TestClassData.createTestasset(3, accs[i].Id, prd03.Id);
            a3.Name = 'Cendyn';
            a3.Product_Group__c = pg3.Id;
            a3.Product2Id = prd03.Id;
            //a3.Version__c = v3.Id;            
            a3.Status = 'Installed';
            lstAssetInsert.add(a3);                     
        
        }
        
        Database.insert(lstAssetInsert);
 
        lstNewAssets = [SELECT Id FROM Asset LIMIT 60];
        
        return lstNewAssets;
 
    }
    
    
    
    
 
}