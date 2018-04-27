@isTest	

private class ProfitGeneratorTest {

    @isTest static void testCalcDiff() {
    	Double result = ProfitGenerator.calcDiff(10,1,3); 	
    	System.assertEquals(9, result);
    }
    
  }