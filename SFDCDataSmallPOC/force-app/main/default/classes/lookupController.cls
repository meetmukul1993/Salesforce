public with sharing class lookupController {
    public lookupController() {

    }

    @AuraEnabled(cacheable = true)
    public static List<sObject> findRecord(String objectApiName, String fieldApiName, String searchTerm){
        try {
            String key = '%'+searchTerm + '%';
            String query = 'Select Id, '+ fieldApiName + ' from ' + objectApiName + ' where ' + fieldApiName + ' LIKE \'' + key + '\'';
            System.debug('Mukul Debug1 :: ' + query);
            List<sObject> objList= Database.query(query);
            System.debug('Mukul Debug2 :: ' + objList);
            return objList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
