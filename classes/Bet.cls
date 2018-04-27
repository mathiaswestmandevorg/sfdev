global class Bet implements Comparable{
	
	private String betString; 
	
	private double nrOfBet1;
	private double nrOfBetX;
	private double nrOfBet2;
	
	private double nrOfLive1;
	private double nrOfLiveX;
	private double nrOfLive2;
	
	private Integer result1;
	private Integer resultX;
	private Integer result2;
	
	private double money = 250;
	private double odds1;
	private double oddsX;
	private double odds2;
	private double totResult;
	private Integer risk;
	
	
	public Bet(String betString, double nrOfBet1, double nrOfBetX, double nrOfBet2, double nrOfLive1, double nrOfLiveX, double nrOfLive2, 
	Integer result1, Integer resultX, Integer result2, double odds1, double oddsX, double odds2)
	{
		this.betString = betString;
		
		this.nrOfBet1 =  nrOfBet1;
		this.nrOfBetX =  nrOfBetX;
		this.nrOfBet2 =  nrOfBet2;
		
		this.nrOfLive1 = nrOfLive1;
		this.nrOfLiveX = nrOfLiveX;
		this.nrOfLive2 = nrOfLive2;
		
		this.result1 = result1;
		this.resultX = resultX;
		this.result2 = result2;
		
		this.odds1 = odds1;
		this.oddsX = oddsX;
		this.odds2 = odds2;
		
		this.totResult = ((result1/odds1) + (resultX/oddsX) + (result2/odds2));
	    this.risk = calcRisk(result1, resultX, result2);
		
		
	}
	
	
	global Integer compareTo(Object compareTo) {
  
     Integer compareBetTot;
     Integer betTot;
    
     Bet bet = (Bet) compareTo;
     compareBetTot = bet.totResult.intValue();
     betTot = totResult.intValue();
     
     return (compareBetTot - betTot);
     
    
     }
    
    public Integer getRisk()
    {
    	return risk;
    }

    public Integer calcRisk(Integer result1, Integer resultX, Integer result2)
    {
        Integer countNegativeValues = 0;
   	    if(result1<0)
   			countNegativeValues++;
   		if(resultX<0)
   			countNegativeValues++;
   		if(result2<0)
   			countNegativeValues++;
   		
   		return countNegativeValues;
    }
	
	public double getTotProfitWithPercentageCalc()
	{
		return totResult;
	}
	
	
	public Integer getResult1()
	{
		return result1;
	}
	
	public Integer getResultX()
	{
		return resultX;
	}
	
	public Integer getResult2()
	{
		return result2;
	}
	
	public String getInformation()
	{
		
		return  betString + '\n1.' + result1 + '\nX.'+  resultX + '\n2.' + result2 + '\nTot Value: ' + totResult.intValue() + '\n\n';
	}




	/*test*/
	public void setOpenGame()
	{
		this.totResult = (result1/3 + resultX/3 + result2/3);
	}
	

}