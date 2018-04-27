public class ArticleController {

   
    private Article_Folder__c folder;
    private Article_Page__c page; 

    public ArticleController(ApexPages.StandardController controller) {
    

        folder = [SELECT Id, Name FROM Article_Folder__c
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];

        
      //  page = [SELECT Id, Name FROM Article_Page__c
       //           WHERE Parent_Folder__c = :ApexPages.currentPage().getParameters().get('id')];           
    }


    public id getId() {
    
     return folder.id;

     }
    
     public void setId(id Id) {
    
     folder.id = Id;

     }

    /* public id getPageId() {
    
     return page.id;

     }*/

   
}