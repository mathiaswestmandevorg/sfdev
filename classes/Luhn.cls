public class Luhn {
    
    public Integer addNumbers(Integer value){      
        value *= 2;
        try{
        if(value>=10){
        	String productStr = String.valueOf(value);
            Integer productInt = Integer.valueOf(String.fromCharArray(new List<Integer>{productStr.charAt(0)})) + Integer.valueOf(String.fromCharArray(new List<Integer>{productStr.charAt(1)}));
            return productInt;
        }
        }
        catch(Exception e){}      
        return value;
    }
    
    //12 digit numbers
    public Integer[] initList(String ssn){           
        //convert characters to Integer and add to List
        Integer[] intList = new Integer[]{};
        if(ssn.length()==12){
        	for(Integer i = 2;i<ssn.length();i++)
            intList.add(Integer.valueOf(String.fromCharArray(new List<Integer>{ssn.charAt(i)})));
        }
        if(ssn.length()==10){
            for(Integer i = 0;i<ssn.length();i++)
            intList.add(Integer.valueOf(String.fromCharArray(new List<Integer>{ssn.charAt(i)})));
        }
        
        return intList;
    }
	
    //Only 10 & 12 digit SSN
    public boolean is_SSK_Valid(String ssn){
        
         try{
         Integer[] intList = initList(ssn);                                                                                                   
         Integer result = 0;
        
   		 for (Integer i=0;i<intList.size()-1;i++) {
             if(math.mod(i,2)==0){
                 result += addNumbers(intList.get(i));
             }
             else{
                 result += intList.get(i);
             }
         }
        
        return (30-result)==intList.get(intList.size()-1);
        }
        
        catch(Exception e){
            system.debug(e.getMessage());
        }
        return false;
   }
      
}
/*
 * 800101-812X 
Detta ger om man använder Luhn-algoritmen: 
8*2=16 
0*1=0  
0*2=0  
1*1=1  
0*2=0  
1*1=1  
8*2=16 
1*1=1  
2*2=2  
       
Denna sekvens ger dig siffersumman 21. 1+6+0+0+1+0+1+1+6+1+4=21 

Sen tar du 30-21=9 vilket ger dig din checksiffra eller kontrollsiffra som den ibland också kallas för. 
21+9=30 vilket är jämnt delbart med 10. 800101-8129 blir det kompletta personnumret.
*/