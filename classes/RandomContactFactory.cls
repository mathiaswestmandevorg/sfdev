public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer nrOfContacts, String lastName)
    {
        List<Contact> contacts = new List<contact>();

        for (Integer i=0;i<nrOfContacts;i++) {    
                contacts.add(new Contact(firstName=lastname + i, lastname = lastname));
        }
                                         
		return contacts;
    }
}