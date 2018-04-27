//
@RestResource(urlMapping='/Account/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        Id accountId = request.requestURI.substring(
        request.requestURI.lastIndexOf('/')+1);
      
        Account result =  [SELECT ID, Name 
                        FROM Account
                        WHERE Id = :accountId];
        
       // '0012400000UTxpC' 
        //use this SOQL for the contact query
		/*Account accountForQuery =  [SELECT Name 
                        FROM Account
                        WHERE Id = :accountId];
        */
      /*  Contact resultContact =  [SELECT ID, Name 
                        FROM Contact
                        WHERE Name = :accountForQuery.Name];
       */
        return result; 
    }
    
     //Helper methods
    static Id createTestRecord() {
       //Create test record
        Account accountTest = new Account(Name='Test record');
        insert accountTest;
        return accountTest.Id;
    } 
    //The method must return the ID and Name for the requested record and all associated contacts with their ID and Name
    
}