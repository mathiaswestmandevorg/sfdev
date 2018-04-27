public class NewCaseListController {
String queryFields = 'Id, CaseNumber, Status';
    	public List<Case> getNewCases()
        {
           List<Case> cases = Database.query('select '+ queryFields +' from Case');
           List<Case> results = new List<Case>();
           for(Case c: cases){
               if(c.Status == 'New')
                   results.add(c);
           }
           return cases;

            
        }
}