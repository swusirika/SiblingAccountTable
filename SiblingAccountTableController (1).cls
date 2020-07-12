/***********************
 * @Description: Controller class for SiblingAccountTable VF Page used to show sibling account records &
 * 				 edit primary contact info in a table
 * @Author: Sai Wusirika
 * @Date: 7/11/2020
 ***********************/ 

public class SiblingAccountTableController {
    
    private List<Contact> siblingPrimaryContactList{get;set;}
    private Map<Id, Account> siblingMap{get;set;}
    public String searchKey{get;set;}
    public List<contactWrapper> contactWrapperList {get;set;}
    private List<Contact> updateStatusContacts{get;set;}
    
    public SiblingAccountTableController(){
        contactWrapperList = new List<contactWrapper>();
        updateStatusContacts = new List<Contact>();
    }
    
    /***********************
     * @Description: Function to get all sibling accounts & primary contacts for each to create contactWrapper records
     * 				 Added Error handling when account doesn't exist or doesn't have a parent Id
     ***********************/ 
    public void getSiblingAccounts(){
        clear();
        // need to combine these SOQL queries into one
        try{
            Account acc = [Select Id, ParentId FROM Account WHERE Name=: searchKey OR Id=:searchKey];
            if(acc != null && acc.ParentId != null){
            	siblingMap = new Map<Id, Account>([Select Id, Name FROM Account WHERE ParentId=: acc.ParentId AND Id !=: acc.Id]);
            	siblingPrimaryContactList = [Select Id, Account.Name, AccountId, Name, FirstName, LastName, Email, MobilePhone, Level__c, Status__c, Tax_Id__c FROM Contact WHERE AccountId=: siblingMap.keySet() AND Level__c = 'Primary'];
            	for(Contact siblingContact: siblingPrimaryContactList){
                	contactWrapperList.add(new contactWrapper(siblingContact));
            	}
            }else if(acc == null){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'This Account does not exist.'));
            } else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'This Account does not have a parent account.'));
            }

        } catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter an existing Account Name or Id'));
        }
    }
    
     /***********************
     * @Description: Function to save the primary contacts edited by the user in the table
     * 				 Error handling included for the update dml call 
     ***********************/ 
    public void save(){
        try{
            update siblingPrimaryContactList;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Primary Contacts saved successfully.'));
        } catch(DmlException ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Save Error:' + ex.getMessage()));
        }
    }
    
     /***********************
     * @Description: Function to set the primary contact's status to Contacted if the user
     * 				 selects the record in the table and clicks "Mark as Contacted"
     * 				 Error handling included
     ***********************/ 
    public void markContacted(){
        updateStatusContacts.clear();
        for(contactWrapper cw: contactWrapperList){
            if(cw.selected == true){
                cw.primaryContact.Status__c = 'Contacted';
                updateStatusContacts.add(cw.primaryContact);
            }
        }
        try{
            update updateStatusContacts;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Selected Primary Contacts marked as contacted.'));
        } catch(DmlException ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Unable to Mark Contact status as Contacted'));
        }
    }

     /***********************
     * @Description: Function to clear the contactWrapper class
     *    			 Used whenever the Get Sibling Accounts button is clicked
     ***********************/ 
    public void clear(){
        contactWrapperList.clear();
    }

     /***********************
     * @Description: Function to clear messages on the Visualforce page when message block is clicked on
     ***********************/ 
    public void clearMessage(){
        ApexPages.getMessages().clear();
    }

     /***********************
     * @Description: Function to select all rows in the table when the header "select all" checkbox is clicked
     ***********************/ 
    public void selectAll(){
        for(contactWrapper cw: contactWrapperList){
            if(cw.selected == false){
                cw.selected = true;
            }
        }
    }
    
     /***********************
     * @Description: Wrapper subclass used to keep track of which contact rows have been selected in the table 
     ***********************/ 
    public class contactWrapper{
        public Contact primaryContact {get;set;}
        public Boolean selected {get;set;}
        
        public contactWrapper(Contact c){
			primaryContact = c;	
            selected = false;
        }
    }
}