public class ProfitGenerator {	
public static void showPossibleOutcomes(Match__c[] match){
    for (Match__c m:match){	
          m  = generatePossibleOutcomes(match[0]);       
        }
    }  

  public static Match__c generatePossibleOutcomes(Match__c match){
  	
  		//make sure odds > 1
  		Double odds1 = match.OddsFor1__c.DoubleValue();
    	Double oddsX = match.OddsForX__c.DoubleValue();
    	Double odds2 = match.OddsFor2__c.DoubleValue();
    	if(odds1<=1 || oddsX<=1 || odds2<=1)
    		return match;
  	
  	    List<Bet> betListObjects = new List<Bet>();
  	    
    	Double money = 250;
        Double betOn1;Double betOnX;Double betOn2;Double liveOn1;Double liveOnX;Double liveOn2; Double calc;Double minDiff=100000; Double newDiff;  
        Integer result1; Integer resultX; Integer result2; Integer result1X2=0; Integer highestResult1X2=0;Integer highStake1 = 0; Integer highStakeX = 0;Integer highStake2 = 0;   
        String mostEvenBet = ''; String calc1 = '';String calcX = '';String calc2 = ''; String possibleOutcomes = ''; String highestCombinedValue1X2 = '';    
    	List<String> betList = new List<String>(); List<String> liveList = new List<String>();
    	Integer safeBet1 = 0; Integer safeBetX = 0;Integer safeBet2 = 0;
    	 
    	betList  = initList(betList);
    	liveList = initList(liveList);
    	
    	//set mode
    	String mode = match.View__c;
    	 	
    	for(String bet: betList)
    	{    	     
            for(String liveBet: liveList)
            {
               betOn1 = Double.valueof(bet.substring(0,1));betOnX = Double.valueof(bet.substring(2,3));betOn2 = Double.valueof(bet.substring(4,5));
               liveOn1 = Double.valueof(liveBet.substring(0,1));liveOnX = Double.valueof(liveBet.substring(2,3));liveOn2 = Double.valueof(liveBet.substring(4,5));
               
               //1 
               calc = betOn1*odds1*money + liveOn1*odds1*money - money*6 + liveOnX*money + liveOn2*money;
               result1 = calc.intValue();    
               //X
               calc = betOnX*oddsX*money + liveOnX*oddsX*money - money*6 + liveOn1*money + liveOn2*money;
               resultX = calc.intValue();
               //2    
               calc = betOn2*odds2*money + liveOn2*odds2*money - (money*6) + (liveOn1*money) + (liveOnX*money);
               result2 = calc.intValue();
               
               //create a Bet here and init
              betListObjects.add(new Bet('Bet(' + bet + ') LiveBet(' +  livebet + ')', betOn1, betOnX, betOn2, liveOn1, liveOnX, liveOn2, result1, resultX, result2, odds1, oddsX, odds2));
              
               //Keep track of Safest bet        
               newDiff = calcDiff(result1,resultX,result2);
               if(newDiff<minDiff)
               {
               	    //save safe bet
                    safeBet1 = result1;
                    safeBetX = resultX; 
                    safeBet2 = result2;
                    
               		minDiff = newDiff;
                    mostEvenBet =  'Bet(' + bet + ') LiveBet(' +  livebet + ')' + '\n1. ' + result1 + '\nX.'+  resultX + '\n2.' + result2;
                    
               }
               
               //Keep track of highest combined profit        
               result1X2 = add_Profit_1X2_together(result1, resultX, result2);
               if(result1X2 > highestResult1X2)
               {
               	    //save high stake values
               	    highStake1 = result1;
               	    highStakeX = resultX;
               	    highStake2 = result2;
               	    
               	    //save combined high stake value 
                    highestResult1X2 = result1X2;
               		highestCombinedValue1X2 = '\nBet(' + bet + ') LiveBet(' +  livebet + ')' + saveResultForMostProfitCombined1X2(result1, resultX, result2);
               }
                            
               
            }
          } 
         
          match.Safest_bet__c  = mostEvenBet;
          match.High_Stake_bet__c = highestCombinedValue1X2;
               
          /*save highest Tot Values depending on result*/        
          match.Highest_TotValue_1_3_Risk__c=0;match.Highest_TotValue_2_3_Risk__c=0;match.Highest_totValue__c=0;
          if(match.Result__c!=null)
          		match = saveHighestTotValues(betListObjects,match);
          
          /*set ResultSafeBet and ResultHighStake*/
          match = setResultSafeBetNHighStake(match,highStake1,highStakeX,highStake2,safeBet1,safeBetX,safeBet2);
          
          	  //Filter
               List<Bet> newBetList = new List<Bet>();
               for(Bet bet: betListObjects)
               {
             
   		    	if(mode.equals('No Risk') && bet.getRisk()==0)
   		    		newBetList.add(bet);
   		    	if(mode.equals('1/3 Risk') && bet.getRisk()==1)
   		    		newBetList.add(bet);
   			  	if(mode.equals('2/3 Risk') && bet.getRisk()==2)
            		newBetList.add(bet);  
            if(mode.equals('All Outcomes'))
            		newBetList.add(bet); 
            if(mode.equals('Open Game'))
            {
                bet.setOpenGame();
                newBetList.add(bet);
            }
            	               	 
               }
            //save result depending on view
            betListObjects = newBetList; 
                  
            //sort
            betListObjects.sort();
            String str = '';
            for(Bet bet: betListObjects)
            {
            	 str =  str + bet.getInformation();
            }
            match.Possible_outcomes__c = str;
          
           
            //End of Class
            return match;
              
        }  
        
        
        public static Match__c saveHighestTotValues(List<Bet> betListObjects, Match__c match)
        {      
        	double value;Integer recordRisk0=0;Integer recordRisk1=0;Integer recordRisk2=0;
            Bet betRecordRisk0 = betListObjects[0];Bet betRecordRisk1 = betRecordRisk0;Bet betRecordRisk2 = betRecordRisk0;
        	
        	for(Bet bet: betListObjects)
            {
            	if(bet.getRisk()==0 && bet.getTotProfitWithPercentageCalc()>recordRisk0){value = bet.getTotProfitWithPercentageCalc();recordRisk0 = value.intValue();betRecordRisk0 = bet;}
                if(bet.getRisk()==1 && bet.getTotProfitWithPercentageCalc()>recordRisk1){value = bet.getTotProfitWithPercentageCalc();recordRisk1 = value.intValue();betRecordRisk1 = bet;}          
                if(bet.getRisk()==2 && bet.getTotProfitWithPercentageCalc()>recordRisk2){value = bet.getTotProfitWithPercentageCalc();recordRisk2 = value.intValue();betRecordRisk2 = bet;}
            }
           
            //check Outcome in match and set values accordingly
            if(match.Result__c.equals('1')){match.Highest_totValue__c = betRecordRisk0.getResult1();match.Highest_TotValue_1_3_Risk__c = betRecordRisk1.getResult1();match.Highest_TotValue_2_3_Risk__c = betRecordRisk2.getResult1();}         	
            if(match.Result__c.equals('X')){match.Highest_totValue__c = betRecordRisk0.getResultX();match.Highest_TotValue_1_3_Risk__c = betRecordRisk1.getResultX();match.Highest_TotValue_2_3_Risk__c = betRecordRisk2.getResultX();}
            if(match.Result__c.equals('2')){match.Highest_totValue__c = betRecordRisk0.getResult2();match.Highest_TotValue_1_3_Risk__c = betRecordRisk1.getResult2();match.Highest_TotValue_2_3_Risk__c = betRecordRisk2.getResult2();}
            	
            return match;
            
        }
       
        
   
   		public static Match__c setResultSafeBetNHighStake(Match__c match, Integer highStake1, Integer highStakeX, Integer highStake2, Integer safeBet1, Integer safeBetX, Integer safeBet2 )
   		{
   			if(match.Result__c==null){match.HighStakeResult__c=0;match.ResultSafeBet__c=0;}
   			else if(match.Result__c.equals('1')){    match.HighStakeResult__c = highStake1;match.ResultSafeBet__c = safeBet1;}
   			else if(match.Result__c.equals('X')){match.HighStakeResult__c = highStakeX;match.ResultSafeBet__c = safeBetX;}
   			else{match.HighStakeResult__c = highStake2;match.ResultSafeBet__c = safeBet2;}
   				
   			return match;
   		}
   		
        public static Double calcDiff(Double result1,Double resultX,Double result2){
            Double lowest = result1;Double highest =result1;
            //find lowest
            if(resultX<lowest){lowest = resultX;}
            if(result2<lowest){lowest = result2;}
               
            //find highest
            if(resultX>highest){highest = resultX;}              
            if(result2>highest){ highest = result2;}       
            
            //calc diff
            return (highest-lowest);
            
            }
            
        public static Integer add_Profit_1X2_together(Integer result1, Integer resultX, Integer result2){return result1 + resultX + result2;}
        
        public static String saveResultForMostProfitCombined1X2(Integer result1, Integer resultX, Integer result2){   	return '\n1. ' + result1 + '\nX. ' + resultX + '\n2. ' +  result2 + '\n';}
            
        
        public static List<String> initList(List<String> Lista){
        	 Lista.add('3,0,0');Lista.add('0,0,3');Lista.add('0,3,0');Lista.add('1,1,1');Lista.add('2,1,0');
             Lista.add('2,0,1');Lista.add('1,2,0');Lista.add('0,2,1');Lista.add('0,1,2');Lista.add('1,0,2');
             return Lista;
        }
      
    
}