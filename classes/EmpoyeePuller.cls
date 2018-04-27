global class EmpoyeePuller implements Schedulable {
	global void execute(SchedulableContext sc) {
		
		String query = 'SELECT Employee__c FROM Save_License__c WHERE Last_day_working__c = TODAY';
		Inactivator inactivator = new Inactivator(query);
		database.executebatch(inactivator,100);
//add comment again
	}
}