/***********************
 * @Description: Class used to create test data to be used in all test classes
 * @Author: Sai Wusirika
 * @Date: 7/11/2020
 ***********************/ 

public class TestDataFactory {
    
    public static Account createAccount(String accountNumber, String AccountName, Id ParentId, String active){
        Account newAccount = new Account();
        newAccount.AccountNumber = accountNumber;
        newAccount.Name = AccountName;
        newAccount.Active__c = active;
        newAccount.ParentId = ParentId;
        insert newAccount;
        return newAccount;
    }
    
    public static Contact createContact(Id AccountId, String FirstName, String LastName, String Email, String level, String MobilePhone, String Status, String TaxId){
        Contact newContact = new Contact();
        newContact.AccountId = AccountId;
        newContact.FirstName = FirstName;
        newContact.LastName = LastName;
        newContact.Email = Email;
        newContact.Level__c = level;
        newContact.MobilePhone = MobilePhone;
        newContact.Status__c = Status;
        newContact.Tax_Id__c = TaxId;
        insert newContact;
        return newContact;
    }

}