global with sharing class AccountMapHandler {
	WebService static void setMapPosition(Decimal latitude, Decimal longitude, ID id) {
		
        System.debug('position: ' + latitude + ',' + longitude + ' id:' + id);
       
                   //Position__c[] pos = [SELECT Latitude__c,Longitude__c FROM Position__c
                   //WHERE ID=:id LIMIT 1];
                   Account[] accs = [SELECT LatitudeAccount__c,LongitudeAccount__c FROM Account
                   WHERE ID=:id LIMIT 1];
        
       			   //pos[0].Latitude__c = latitude;
                   //pos[0].Longitude__c = longitude;
        		   accs[0].LatitudeAccount__c = latitude;
                   accs[0].LongitudeAccount__c = longitude;
         
       			   //update pos;
        		   update accs;
        		   
        }
    
    WebService static void setBillingStreetNCity(ID id,String xJSON) {   
        System.debug('Debug: JSON data ok ' + xJSON);
      
        try{  
        	String[] parts = xJSON.split('"formatted_address" : "');
        	String part = parts[0];
        	String part2 = parts[1]; // 173-175 Main St, Burlington, VT 05401, USA and rest of string
        
      		String[] secondParts = part2.split('",');
        	String BillingAddress = secondParts[0]; // 173-175 Main St, Burlington, VT 05401, USA
        	System.debug('parser result' + BillingAddress);
        
       		// "formatted_address" : "173-175 Main St, Burlington, VT 05401, USA",
        	// "geometry" : {
        
        	String[] addressParts = BillingAddress.split(',');
        	String streetAddress = addressParts[0];  //173-175 Main St
        	String cityAddress = addressParts[1];    //Burlington
       
        	Account[] accs = [SELECT BillingCity, BillingStreet FROM Account WHERE ID=:id LIMIT 1];
        	accs[0].BillingStreet = streetAddress;
        	accs[0].BillingCity = cityAddress;       			     		  
        	update accs;
              
        	System.debug('update ok ' );  
          
           }
        
       catch(Exception e) {
       //Generic exception handling code here.
       }
     }
}