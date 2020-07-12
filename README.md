# SiblingAccountTable
Visualforce Page on which user can input an account name or ID to get list of Sibling Accounts &amp; related primary contacts
The User can then edit contact fields or mark those primary contacts as contacted

## Project Scope

### Requirements:

- Must include a Visualforce page that includes a search field for an account Id and the corresponding table of sibling accounts (which have the same parent account). 
- Must also include the primary contact for each sibling account in the same row in the table
- Primary contact information must be editable with a save feature and rows in table must be selectable so primary contact’s status can be changed to Contacted on a button click
- Must have error handling for all the above features
- Must include test classes for all features

### Installation Process:
- Create Contact.Status__c picklist field with "Contacted","Not Contacted" as possible values
- Create Contact.Tax_Id__c string field 
- Create Branch from master branch (if not already done)
- Add all files except ReadMe & Design PDF
- commit changes to current branch (run pipeline if available & create Pull request to master/main branch)
- Create permission set "Sibling Account Permissions"
- Make sure permission set has read/write access to Contact object/fields & read access to Account object/fields
- Add SiblingAccountTable Visualforce page to permission set
- Add required profiles to permission set
- Create a Visualforce Tab on Service App for "Sibling Account Table"
