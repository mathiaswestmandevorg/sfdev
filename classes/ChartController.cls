global with sharing class ChartController {

private static Post_Decision_Interview__c currentRecord { get; set;}

public ChartController(ApexPages.StandardController controller) {
   
   currentRecord = [SELECT Id,Region__c, Agile__c, Agile_Competitor_rating__c, Bus_model__c,Bus_model_Competitor_rating__c, Customized_solution__c, Customized_solution_Competitor_rating__c, E2E__c,E2E_Competitor_rating__c, GSM__c, Competitor__c,
   Service_Mgmt__c, Service_Mgmt_Competitor_rating__c, Trusted__c,Trusted_Competitor_rating__c FROM Post_Decision_Interview__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
  
    }

    
    // Return a list of data points for a chart
     public List<Data> getData() {
        return ChartController.getChartData();
    }
    // Make the chart data available via JavaScript remoting
    @RemoteAction
    global static List<Data> getRemoteData() {
        return ChartController.getChartData();
    }
    // The actual chart data; needs to be static to be
    // called by a @RemoteAction method
    global static List<Data> getChartData() {
      

          List<Data> data = new List<Data>();
          if(currentRecord.Region__c.equals('Nordics - CC'))
          {
                      
             List<Germany_MC_Custom_Setting__c> mcs = Germany_MC_Custom_Setting__c.getall().values();  
             data.add(new Data(mcs[0].Category_1__c,3,4,5));
             data.add(new Data(mcs[0].Category_2__c,3,4,5));
             data.add(new Data(mcs[0].Category_3__c,3,4,5));
             data.add(new Data(mcs[0].Category_4__c,3,4,5));
             data.add(new Data(mcs[0].Category_5__c,3,4,5));
             data.add(new Data(mcs[0].Category_6__c,3,4,5));
             data.add(new Data(mcs[0].Category_7__c,3,4,5));
             data.add(new Data(mcs[0].Category_8__c,3,4,5));
          }
          
          if(currentRecord.Region__c.equals('Nordics - MC'))
          {
             List<Nordics_MC_Custom_Setting__c> m = Nordics_MC_Custom_Setting__c.getall().values();  
             data.add(new Data(m[0].Nordics_MC_Category_1_Quality__c,3,4,5));
             data.add(new Data(m[0].Nordics_MC_Category_2__c,3,4,5));
         
          }
     /*   
        data.add(new Data('GSM',integer.valueof(currentRecord.GSM__c),integer.valueof(currentRecord.Competitor__c), 5));
        data.add(new Data('Trusted',integer.valueof(currentRecord.Trusted__c),integer.valueof(currentRecord.Trusted_Competitor_rating__c),3));
        data.add(new Data('Service',integer.valueof(currentRecord.Service_Mgmt__c),integer.valueof(currentRecord.Service_Mgmt_Competitor_rating__c), 4));
        data.add(new Data('Bus', integer.valueof(currentRecord.Bus_model__c),integer.valueof(currentRecord.Bus_model_Competitor_rating__c), 3));
        data.add(new Data('E2E', integer.valueof(currentRecord.E2E__c),integer.valueof(currentRecord.E2E_Competitor_rating__c), 3));
        data.add(new Data('Agile',integer.valueof(currentRecord.Agile__c),integer.valueof(currentRecord.Agile_Competitor_rating__c), 2));
        data.add(new Data('Customized',integer.valueof(currentRecord.Customized_solution__c),integer.valueof(currentRecord.Customized_solution_Competitor_rating__c), 3));
        */
        return data;
    }
    // Wrapper class
    global class Data {
        public String name { get; set; }
        public Integer data1 { get; set; }
        public Integer data2 { get; set; }
        public Integer data3 { get; set; }
        
        public Data(String name, Integer data1, Integer data2, Integer data3) {
            this.name = name;
            this.data1 = data1;
            this.data2 = data2;
            this.data3 = data3;
        }
    }
    
   

}