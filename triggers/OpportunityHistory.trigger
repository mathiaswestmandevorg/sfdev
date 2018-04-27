trigger OpportunityHistory on Opportunity (before update) {
    

      //Opportunity opp = [SELECT Id, Name, StageName, OpportunityHistory (Select OldValue, createdDate, NewValue From Histories LIMIT 1) 
      //FROM Opportunity WHERE Id IN :Trigger.new LIMIT 1];

    //  Opportunity opp =    [SELECT Id, Name, StageName, OpportunityHistories
    //  FROM Opportunity WHERE Id IN :Trigger.new LIMIT 1];

   //  List<OpportunityHistory> histories = opp.OpportunityHistories; 
     

    //system.debug('history debug created date:' +  opp.Histories[0].createdDate  + ' ' +   opp.Histories[0].NewValue + ' OldValue:' + opp.Histories[0].OldValue);
   // system.debug('opp debug:' +  opp.);
   //system.debug('history test debug NewValue:' + histories[0].NewValue + ' OldValue:' + histories[0].OldValue);

/*
   List<Opportunity> opps = [SELECT id, Probability, LastModifiedDate, OwnerId,
            (SELECT StageName,Probability,SystemModstamp FROM OpportunityHistories order by SystemModstamp desc) 
            FROM Opportunity 
            where LastModifiedDate = LAST_N_DAYS:7];

   List<OpportunityHistory> histories = opp.OpportunityHistories; 
 */
}