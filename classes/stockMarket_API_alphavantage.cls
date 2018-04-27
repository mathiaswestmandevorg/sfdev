public with sharing class stockMarket_API_alphavantage {

	public static Integer MAX_GRAPH_VALUES = 25;

	public static List<String> getStock(String period, String stock){

		List<String> strList = new List<String>();
		
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('http://www.alphavantage.co/query?function=TIME_SERIES_' + period + '&symbol=' + stock + '&apikey=7950');
		request.setMethod('GET');
		HttpResponse response = http.send(request);
	
		// If the request is successful, parse the JSON response.
		if (response.getStatusCode() == 200) {
	   		
	   		//System.debug(response.getBody());
	    	// Parse JSON response to get all the totalPrice field values.
	    	JSONParser parser = JSON.createParser(response.getBody());
	    	String close = '';
	    	Integer counter = 0;
	    	

			while (counter < MAX_GRAPH_VALUES && parser.nextToken() != null) {
				System.debug('mw ' + parser);
	            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == '4. close')) {
	                parser.nextToken();
	                close = parser.getText();
	                strList.add(close);
	                counter += 1;
	            
				}

			}
		}

		return strList; 
	}

	

}