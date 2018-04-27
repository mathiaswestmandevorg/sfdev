public class controllerMap {
   
  public decimal latt { get; set; }       
  public decimal longt { get; set; }

    public void saveRec() {
    Position__c pos = new Position__c();
    /*intialize your object if already done not needed, then assign as follows*/
    pos.Latitude__c = latt;
    pos.Longitude__c = longt;
        
    
    insert pos; //insert/update/upsert which ever suits you
  }

    
}