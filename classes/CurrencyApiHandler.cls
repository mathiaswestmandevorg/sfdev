public class CurrencyApiHandler {

	private static final String USD = 'USD'; 
	private static final String SEK = 'SEK'; 

	@future(callout=true)
	public static void getCurrencies(){

		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('http://api.fixer.io/' + Date.today() );
		request.setMethod('GET');
		HttpResponse response = http.send(request);

		// If the request is successful, parse the JSON response.
		if (response.getStatusCode() == 200) {

			Map<String,Decimal> rateMap = new Map<String,Decimal>();
			rateMap = parseReponse( response );
			insertNewRate(rateMap);

		}
	}
	
	

	public static Map<String,Decimal> parseReponse( HttpResponse response ){

			Map<String,Decimal> rateMap = new Map<String,Decimal>();
			JSONParser parser = JSON.createParser(response.getBody());
	 
	   
			while (parser.nextToken() != null) {
	            if ( (parser.getCurrentToken() == JSONToken.FIELD_NAME) ) {

	                if(parser.getText() == SEK){

	                	parser.nextToken();               
	                	rateMap.put(SEK, decimal.valueOf ( parser.getText() ));

	                }
	            	else if(parser.getText() == USD){

	                	parser.nextToken();
	                	rateMap.put(USD, decimal.valueOf ( parser.getText() ));

	                }
	                
	               
	  	            
				}
	  	            
			}

			return rateMap;

	}

	//create new USD/SEK rate
    public static void insertNewRate(Map<String,Decimal> rateMap){

    	if(rateMap != null){
		
			try{
			USD_SEK__c rateInstance = new USD_SEK__c ( Date__c = Date.today() , USD__c = rateMap.get(USD), SEK__c = rateMap.get(SEK) );
			insert rateInstance;
			}
			catch(Exception e){
			System.debug(e.getMessage());
			}

	    }
		
	}
}