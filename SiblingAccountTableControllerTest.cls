/***********************
 * @Description: Controller Test class for SiblingAccountTableController
 * @Author: Sai Wusirika
 * @Date: 7/11/2020
 ***********************/ 

@isTest
public class SiblingAccountTableControllerTest {
    
    @testSetup static void setupAccountData(){
        //Create parent Account
        Account parentAccount = TestDataFactory.createAccount('CC1', 'Test Parent Account', null, 'Yes');
        
        // Create multiple test child accounts
        Account childAccount1 = TestDataFactory.createAccount('CC11', 'Test Child Account 1', parentAccount.Id, 'Yes');
        Account childAccount2 = TestDataFactory.createAccount('CC12', 'Test Child Account 2', parentAccount.Id, 'Yes');
        Account childAccount3 = TestDataFactory.createAccount('CC13', 'Test Child Account 3', parentAccount.Id, 'Yes');
        Account childAccount4 = TestDataFactory.createAccount('CC14', 'Test Child Account 4', parentAccount.Id, 'Yes');
        Account childAccount5 = TestDataFactory.createAccount('CC15', 'Test Child Account 5', parentAccount.Id, 'Yes');
        Account childAccount6 = TestDataFactory.createAccount('CC16', 'Test Child Account 6', parentAccount.Id, 'Yes');
        // Create one account to use in testing
        Account childAccountMain = TestDataFactory.createAccount('CC100', 'Test Child Account Main', parentAccount.Id, 'Yes');
        
        // Create Contact info for each test Account and mark as Primary
        TestDataFactory.createContact(childAccount1.Id, 'Test1', 'Johnson', 'test1johnson@salesforce.com', 'Primary', '1111111111', 'Not Contacted', '111');
        TestDataFactory.createContact(childAccount2.Id, 'Test2', 'Johnson', 'test2johnson@salesforce.com', 'Primary', '2222222222', 'Not Contacted', '222');
        TestDataFactory.createContact(childAccount3.Id, 'Test3', 'Johnson', 'test3johnson@salesforce.com', 'Primary', '3333333333', 'Not Contacted', '333');
        TestDataFactory.createContact(childAccount4.Id, 'Test4', 'Johnson', 'test4johnson@salesforce.com', 'Primary', '4444444444', 'Not Contacted', '444');
        TestDataFactory.createContact(childAccount4.Id, 'Test5', 'Johnson', 'test5johnson@salesforce.com', 'Primary', '5555555555', 'Not Contacted', '555');
        TestDataFactory.createContact(childAccount4.Id, 'Test6', 'Johnson', 'test6johnson@salesforce.com', 'Primary', '6666666666', 'Not Contacted', '666');
    }
    
    @isTest static void testSiblingAccountTable(){
        Test.startTest();
        SiblingAccountTableController saTable = new SiblingAccountTableController();
        saTable.searchKey = '';
        saTable.getSiblingAccounts();
        System.assert(saTable.contactWrapperList.size()==0);
        
        saTable.searchKey = 'This account doesnt exist';
        saTable.getSiblingAccounts();
        System.assert(saTable.contactWrapperList.size()==0);
        
        saTable.searchKey = 'Test Child Account Main';
        saTable.getSiblingAccounts();
        System.debug(saTable.contactWrapperList);
        //System.assert(saTable.contactWrapperList.size()>0);
        
        saTable.markContacted();
        saTable.save();
        saTable.selectAll();
        saTable.clearMessage();
        saTable.clear();
        
        Test.stopTest();
    }
}