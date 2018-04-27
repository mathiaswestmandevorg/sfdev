trigger PrognosTrigger on Prognos__c (before insert, before update) {


  List<Opportunity> oppList = new List<Opportunity>();

  oppList = [SELECT Amount FROM Opportunity
  WHERE SSI_user__c = 'Mathias'];
   
   Decimal sum = 0;
   for(Opportunity opp : oppList){
      sum += opp.Amount;
   }
   
 for (Prognos__c prognos : Trigger.new) 
     prognos.Budget_Jan__c = sum; 

}