public with sharing class caseController {
    public caseController() {

    }

    @AuraEnabled(cacheable = true)
    public static List<Case> getAllCaseList(){

        List<Case> caseList = [Select Id, Subject, CaseNumber from Case LIMIT 10];
        return caseList;
    }

    @AuraEnabled(cacheable = true)
    public static List<Case> getCaseList(String subject){

        String key = '%' + subject + '%';
        List<Case> caseList = [Select Id, Subject, CaseNumber from Case where Subject Like : key];
        return caseList;
    }
}
