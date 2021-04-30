public with sharing class ContactController {

    @AuraEnabled(cacheable = true)
    public static List<Contact> getContactList(){
        try {
            return [Select Id, Name from Contact LIMIT 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable = true)
    public static List<Contact> findContacts(String searchKey){
        try {
            String key = '%' + searchKey + '%';
            return [Select Id, Name from Contact where Name LIKE :key];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}