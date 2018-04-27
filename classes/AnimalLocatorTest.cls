@isTest 
public class AnimalLocatorTest {
@isTest 
	static void testgetAnimalNameById() {
   
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
    String response = AnimalLocator.getAnimalNameById(2);
    System.assertEquals(response, 'bear');
  
}
}