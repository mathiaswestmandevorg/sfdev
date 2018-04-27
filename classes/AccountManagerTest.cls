@isTest
public class AccountManagerTest {
    @isTest 
    static void testGetCaseById() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://na1.salesforce.com/services/apexrest/Accounts/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
}
    
    //Helper method
    static Id createTestRecord() {
       //Create test record
        Account accountTest = new Account(Name='Test record');
        insert accountTest;
        return accountTest.Id;
    }  
}