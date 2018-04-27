public class ContactSearch {

    public static List<Contact> searchForContacts(string lastName, string mailingPostalCode)
    {
        Contact[] Contacts = [SELECT Id,FirstName,LastName
        FROM Contact WHERE Lastname=:lastName AND mailingPostalCode=:mailingPostalCode];
        
        return Contacts;
    }
}