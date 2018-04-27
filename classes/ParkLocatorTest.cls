@isTest
public class ParkLocatorTest {
    @isTest 
    static void testCallout() {             
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String[] result = ParkLocator.country('Germany');
        String[] expectedResult = new String[]{'Hamburg Wadden Sea National Park', 'Hainich National Park', 'Bavarian Forest National Park'};
        /* Call the method that invokes a callout
        Double x = 1.0;
        Double y = 2.0;
        Double result = AwesomeCalculator.add(x, y);
        System.assertEquals(3.0, result);*/
        System.assertEquals(expectedResult,result);

    }     
}