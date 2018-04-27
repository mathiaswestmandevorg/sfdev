global class Inactivator implements Database.Batchable<sObject> {
	
	String query;
	
	global Inactivator(String query) {
		this.query = query;
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

//test
   	global void execute(Database.BatchableContext BC, List<Save_License__c> scope) {

   		system.debug('mw scope size = ' + scope.size());
   		List<User> users = new List<User>();
	
		Set<Id> userIds = new Set<Id>();
		for(Save_License__c license : scope){
			userIds.add(license.Employee__c);
		}


		users = [SELECT IsActive FROM User WHERE Id in :userIds];
		system.debug('mw userlist size = ' + users.size());
		for(User user : users){
			if(user.IsActive){
				user.IsActive = false;
			}
        }

        try{
        update users;
        }
        catch(Exception e){
        system.debug(e.getMessage());
        }
        


	}
	
	global void finish(Database.BatchableContext BC) {

		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
 		mail.setToAddresses(new String[] {'mathiaswestman87@gmail.com'});
		mail.setSenderDisplayName('Batch Processing');
		mail.setSubject('Batch Process Completed');
		mail.setPlainTextBody('Batch Process has completed');

		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

		
	}
	
}