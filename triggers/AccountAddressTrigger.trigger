trigger AccountAddressTrigger on Account (before insert, before update) {
 
    for(Account a : Trigger.New) {
        if(a.BillingPostalCode!='') 
            if(a.Match_Billing_Address__c == TRUE)
                  a.ShippingPostalCode = a.BillingPostalCode;
      
    }  
}

//if an Account has a Billing Postal Code and 'Match_Billing_Address__c' is true, 
//the record should have the Shipping Postal Code set to match