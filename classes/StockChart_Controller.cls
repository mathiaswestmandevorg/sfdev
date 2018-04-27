public class StockChart_Controller {


		public static String pair { get; set; }
		public static String stock { get; set; }
		public static String period { get; set; }

		public PageReference save(){

			return null;
		}

	    // Return a list of data points for a chart
	    public List<Data> getData() {
	        return StockChart_Controller.getChartData();
	    }

	    // Make the chart data available via JavaScript remoting
	    @RemoteAction
	    public static List<Data> getRemoteData() {
	        return StockChart_Controller.getChartData();

	    }



	    // The actual chart data; needs to be static to be
	    // called by a @RemoteAction method
	     public static List<Data> getChartData() {	

	     	if(pair == null || stock==null || period==null){
	     		return null;
	     	}
	     	
	     	List<String> stockData = new List<String>();
	     	stockData = stockMarket_API_alphavantage.getStock(period, stock);
	
	        List<Data> data = new List<Data>();

	        	if(stockData.size() > 0){
	        		Decimal start = Decimal.valueOf( stockData.get(stockData.size()-1));
	        		Date chartDate;
	        		for(Integer i=stockData.size()-1; i >= 0; i--){

	        			chartDate = system.today();
	        			chartDate = chartDate.addDays(-i);
	        			data.add(new Data(String.valueOf(chartDate).substring(2).remove('-'), percent ( start , Decimal.valueOf(stockData.get(i)) ), 90, 55));

	
	        		}
        			

	          }
		       
	    
	        return data;
	    }

	    public static Decimal percent(Decimal start, Decimal price){
	
	    	 Decimal percent = ( ( price/start ) * 100 ) - 100;
	    	 return percent;

	    }


	    // Wrapper class
	    public class Data {

	        public String name { get; set; }
	        public Decimal data1 { get; set; }
	        public Integer data2 { get; set; }
	        public Integer data3 { get; set; }

	        public Data(String name, Decimal data1, Integer data2, Integer data3) {
	            this.name = name;
	            this.data1 = data1;
	            this.data2 = data2;
	            this.data3 = data3;

	        }
	    }
	
}