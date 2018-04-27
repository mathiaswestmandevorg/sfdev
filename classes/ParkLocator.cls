public class ParkLocator {

    public static String[] country(String countryName)
    {
        ParkService.ParksImplPort p = new ParkService.ParksImplPort();
        return p.byCountry(countryName);
        
    }
}