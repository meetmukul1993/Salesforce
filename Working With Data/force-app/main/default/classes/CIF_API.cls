public with sharing class CIF_API {

    // Private static String token = Label.BBCRM_pingFedTokenForSIT;
    Private static String pageLimit = '20';
    Private static final String SUCCESS = 'SUCCESS';
    Private static final String ERROR = 'ERROR';
    Private static final String ENVIRONMENT_ID = '57';
    // Private static final String AUTHORIZATION = 'Bearer ' + token;
    Private static final String ENVIRONMENT_SYSTEM = 'T10T';
    Private static final String CONTENT_TYPE = 'application/json';

    private static HttpRequest getUpdatedHeader(String endPoint, String method) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod(method);
        // req.setHeader('Authorization', AUTHORIZATION);
        req.setHeader('Content-Type', CONTENT_TYPE);
        req.setHeader('X-environment-id', ENVIRONMENT_ID);
        req.setHeader('X-environment-system', ENVIRONMENT_SYSTEM );
        return req;
    }

    public static CIF_SearchBusinessResults searchBusinesses(String restartToken, String name,String postalCode,String telephoneNum) 
    {  
        // String endpoint = 'https://run.mocky.io/v3/3bb2eb27-b4b3-4a35-8f0b-933eae188b56';
        String endpoint = 'https://run.mocky.io/v3/b3ecd891-3c02-4a79-96ae-4216daa294ef';

        
        String searchString ='';
        CIF_BusinessWrapper busJson = new CIF_BusinessWrapper();
        CIF_SearchBusinessResults result = new CIF_SearchBusinessResults();   
        List<BusinessSearchResult> searchResult = new List<BusinessSearchResult>();
        
        //Validate the customer name as it is a mandatory field
        if( String.isBlank(name) ) 
        {
            result.status = ERROR;
            throw new ValidationException('LABEL.BBCRM_Business_Search_Validation_Message');
        }

        // else
        // {  
        //     //Create a searchString based on search criteria   
        //     searchString = CIF_createBusinessSearchString.createSearchString(restartToken, name, postalCode, telephoneNum);
        // }
       
        // endpoint = endpoint+searchString;
        System.debug(endpoint);
        
        //Call the endpoint
        Http http = new Http();
        HttpRequest req = getUpdatedHeader(endPoint, 'GET');
        HttpResponse response = http.send(req);
        System.debug('StatusCode :: '+ response.getStatusCode());
        System.debug('Body :: '+ response.getBody());
        
        busJson = (CIF_BusinessWrapper)JSON.deserialize(response.getBody(), CIF_BusinessWrapper.class);
        
        //Check the status code, If callout is successful, parse the response and send it to aura component
        if (response.getStatusCode() == 200)
        {
            if(busJson.business.size() > 0)
            {
                 
                result.status = SUCCESS;
                Integer a=0;
                for(CIF_BusinessWrapper.Business record : busJson.business)
                { 
                   searchResult.add(new BusinessSearchResult(record.key, record.fullName, record.aliasName, record.streetAddress.addressLine2,record.streetAddress.city, record.streetAddress.territory,record.streetAddress.countryCd,record.streetAddress.postalCode));   
                   System.debug(searchResult);
                }
                result.results = searchResult;
                if(busJson.Pagination !=null)
                    result.restartToken = busJson.pagination.restart;
            }
            else
            {
                result.status = ERROR;
                throw new ValidationException('LABEL.BBCRM_No_Records_Found');
            }
        }
        else
        {  
            result.status = ERROR;
            List<CIF_Error> errors = new List<CIF_Error>();
            for(CIF_BusinessWrapper.AdditionalStatus error: busJson.status.additionalStatus) 
            {
                errors.add(new CIF_Error(error.statusCode,error.severity,error.statusDesc));
            }
            System.debug('Errors:'+errors);
        }
        return result;
    }

    public class CIF_SearchBusinessResults 
    {
        public List<BusinessSearchResult> results;
        public String status;   
        public List<CIF_Error> errors;
        public String restartToken;
    }

    public static CIF_RetrieveResult setAccountDetails(String CifId)
    {
        CIF_RetrieveResult result = new CIF_RetrieveResult();
        // String endpointKey = 'https://sit.apigateway.td.com:8443/api.parties.cif/businesses/'+CifId+'?expand=contacts&expand=identifications&expand=preferences';

        String endpointKey = 'https://run.mocky.io/v3/cbd0eac5-f456-463d-af85-50e9e6c3cfff';
              
        CIF_BusinessRetrieveWrapper busAccJson = new CIF_BusinessRetrieveWrapper();
              
        if( [select ID from Account where ID = :CifId].size() > 0 ) 
        {
              result.status = ERROR;
              throw new ValidationException('LABEL.BBCRM_Record');
        }
        else
        {     
            //Call the business/key endpoint
            Http http = new Http();
            HttpRequest req = getUpdatedHeader(endpointKey, 'GET');
            HttpResponse response = http.send(req);
            busAccJson = (CIF_BusinessRetrieveWrapper)JSON.deserialize(response.getBody(), CIF_BusinessRetrieveWrapper.class);
            
            System.debug('Mukul::2 ' + busAccJson.business.fullName);
            //Check the status code
            if (response.getStatusCode() == 200 || response.getStatusCode() == 205 || response.getStatusCode() == 207)
            {
                result.status = SUCCESS;
                try
                {
                    // CIF_API_Helper.insertAccounts(busAccJson);
                }
                catch (DMLException exp)
                {
                    throw exp;
                }
            }
            else
            {  
                result.status = ERROR;
                List<CIF_Error> errors = new List<CIF_Error>();
                for(CIF_BusinessRetrieveWrapper.AdditionalStatus error: busAccJson.status.additionalStatus) 
                          errors.add(new CIF_Error(error.statusCode,error.severity,error.statusDesc));
            }
         }
         return result;
    }

    public static CIF_RetrieveResult_Mukul setAccountDetails_Mukul(String CifId)
    {
        CIF_RetrieveResult_Mukul result = new CIF_RetrieveResult_Mukul();
        // String endpointKey = 'https://sit.apigateway.td.com:8443/api.parties.cif/businesses/'+CifId+'?expand=contacts&expand=identifications&expand=preferences';

        String endpointKey = 'https://run.mocky.io/v3/cbd0eac5-f456-463d-af85-50e9e6c3cfff';
              
        CIF_BusinessRetrieveWrapper busAccJson = new CIF_BusinessRetrieveWrapper();
              
        if( [select ID from Account where ID = :CifId].size() > 0 ) 
        {
              result.status = ERROR;
              throw new ValidationException('LABEL.BBCRM_Record');
        }
        else
        {     
            //Call the business/key endpoint
            Http http = new Http();
            HttpRequest req = getUpdatedHeader(endpointKey, 'GET');
            HttpResponse response = http.send(req);
            busAccJson = (CIF_BusinessRetrieveWrapper)JSON.deserialize(response.getBody(), CIF_BusinessRetrieveWrapper.class);
                        
            //Check the status code
            if (response.getStatusCode() == 200 || response.getStatusCode() == 205 || response.getStatusCode() == 207)
            {
                result.status = SUCCESS;
                try
                {
                    result.fullName = busAccJson.business.fullName;
                    // CIF_API_Helper.insertAccounts(busAccJson);
                }
                catch (DMLException exp)
                {
                    throw exp;
                }
            }
            else
            {  
                result.status = ERROR;
                List<CIF_Error> errors = new List<CIF_Error>();
                for(CIF_BusinessRetrieveWrapper.AdditionalStatus error: busAccJson.status.additionalStatus) 
                          errors.add(new CIF_Error(error.statusCode,error.severity,error.statusDesc));
            }
         }
         return result;
    }

    public class CIF_RetrieveResult {
        public String status;
        public List<CIF_Error> errors;
    }

    public class CIF_RetrieveResult_Mukul {
        public String status;
        public List<CIF_Error> errors;
        public String fullName;
    }

    public class CIF_Error
    {
        public Integer statusCode;
        public String severity;
        public String statusDesc;
        
        public CIF_Error(Integer statusCode, String severity, String statusDesc)
        {
            this.statusCode = statusCode;
            this.severity = severity;
            this.statusDesc = statusDesc;
            
        }
    }

    public class BusinessSearchResult 
    {
        public String key;
        public String fullName;
        public String aliasName;
        public String addressLine2;
        public String city;
        public String territory;
        public String countryCd;
        public String postalCode;
    
        public BusinessSearchResult(String key, String fullName, String aliasName, String addressLine2, String city, String territory, String countryCd, String postalCode) 
        {
            this.key = key;
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
