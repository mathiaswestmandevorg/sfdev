@isTest
global class ParkServiceMock implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
               
       /* calculatorServices.doAddResponse response_x =
            new calculatorServices.doAddResponse();
        response_x.return_x = 3.0;
        response.put('response_x', response_x);*/
        ParkService.byCountryResponse response_x = new ParkService.byCountryResponse();
        response_x.return_x = new String[]{'Hamburg Wadden Sea National Park', 'Hainich National Park', 'Bavarian Forest National Park'}; 
        response.put('response_x', response_x);
   }
}