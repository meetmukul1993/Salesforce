public with sharing class BusinessSearchController {
    

    @AuraEnabled(cacheable=true)
    public static CIF_SearchBusinessResults searchBusinesses(String restartToken, String name,String postalCode,String telephoneNum) 
     { 
         System.debug('mukul:: ' + restartToken + ' ' + name);
         CIF_API.CIF_SearchBusinessResults DisplayResult = new  CIF_API.CIF_SearchBusinessResults();
         DisplayResult=CIF_API.searchBusinesses(restartToken, name, postalCode, telephoneNum);
         System.debug('DisplayResult'+DisplayResult);
         String cif_result = JSON.serialize(DisplayResult);
         CIF_SearchBusinessResults result = (CIF_SearchBusinessResults)JSON.deserialize(cif_result,CIF_SearchBusinessResults.class);
         System.debug('Result in Controller class:'+ result);
         return result;
     }

     @AuraEnabled(cacheable=true)
     public static CIF_RetrieveResult_Mukul getRecords(String CifId) 
     { 
         CIF_API.CIF_RetrieveResult_Mukul RetrieveResult = new  CIF_API.CIF_RetrieveResult_Mukul();
         try
         {
             RetrieveResult=CIF_API.setAccountDetails_Mukul(CifId);
         }
         catch (ValidationException e)
         {
              throw new ValidationException('LABEL.BBCRM_Record');
         }
         catch(DMLException exp)
         {
             throw new ValidationException('LABEL.BBCRM_DML_Error_Message');
         }
         String retrieve_result = JSON.serialize(RetrieveResult);
         CIF_RetrieveResult_Mukul result = (CIF_RetrieveResult_Mukul)JSON.deserialize(retrieve_result,CIF_RetrieveResult_Mukul.class);
         return result;
     } 

     public class CIF_RetrieveResult  
     {
        @AuraEnabled public String status;   
        @AuraEnabled public List<CIF_Error> errors;
     }

     public class CIF_RetrieveResult_Mukul
     {
        @AuraEnabled public String status;   
        @AuraEnabled public List<CIF_Error> errors;
        @AuraEnabled public String fullName;
     }

     public class CIF_SearchBusinessResults 
     {
        @AuraEnabled public List<BusinessSearchResult> results;
        @AuraEnabled public String status;   
        @AuraEnabled public List<CIF_Error> errors;
        @AuraEnabled public String restartToken;
     }

     public class CIF_Error
     {
        @AuraEnabled public Integer statusCode;
        @AuraEnabled public String severity;
        @AuraEnabled public String statusDesc;
        
        public CIF_Error(Integer statusCode, String severity, String statusDesc)
        {
            this.statusCode = statusCode;
            this.severity = severity;
            this.statusDesc = statusDesc;
        }
     }

     public class BusinessSearchResult 
     {
        @AuraEnabled public String key;
        @AuraEnabled public String fullName;
        @AuraEnabled public String aliasName;
        @AuraEnabled public String addressLine2;
        @AuraEnabled public String city;
        @AuraEnabled public String territory;
        @AuraEnabled public String countryCd;
        @AuraEnabled public String postalCode;
    
        public BusinessSearchResult(String key, String fullName, String aliasName, String addressLine2, String city, String territory, String countryCd, String postalCode) 
        {
            this.key=key;
            this.fullName = fullName;
            this.aliasName = aliasName;
            this.addressLine2 = addressLine2;
            this.city = city;
            this.territory = territory;
            this.countryCd = countryCd;
            this.postalCode = postalCode;
     }
   }
   public class ValidationException extends Exception {}
}
