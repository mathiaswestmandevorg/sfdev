trigger MatchTriggerOutcomes on Match__c (before insert, before update) {
    
    ProfitGenerator.showPossibleOutcomes(Trigger.new);
}