global with sharing class Position {

    WebService static void setMapPosition(Decimal latitude, Decimal longitude, ID id) {
		
        System.debug('position: ' + latitude + ',' + longitude + ' id:' + id);
       
                   Position__c[] pos = [SELECT Latitude__c,Longitude__c FROM Position__c
                   WHERE ID=:id LIMIT 1];
        
       			   pos[0].Latitude__c = latitude;
                   pos[0].Longitude__c = longitude;
         
       			   update pos;
        		   
        }
    
}