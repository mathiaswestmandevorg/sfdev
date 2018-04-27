global class ForexJobScheduler implements Schedulable {

	global void execute(SchedulableContext sc) {
		
		CurrencyApiHandler.getCurrencies();

	}

}