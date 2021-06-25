public class CIF_BusinessWrapper {

    public class StreetAddress {
         public String addressLine2;
         public String city;
         public String territory;
         public String postalCode;
         public String countryCd;
         public Double n;
     }
 
     public List<Business> business;
     public Double o;
     public String clTrackingId;
     public Pagination pagination;
 
     public class BusinessCIFExtension {
         public List<String> name;
         public String aliasNameFormCd;
         public Double q;
     }
 
     public class Business {
         public String key;
         public BusinessCIFExtension businessCIFExtension;
         public String fullName;
         public String aliasName;
         public StreetAddress streetAddress;
         public Double h;
     }
 
     public class Pagination {
         public String restart;
         public Integer sentCnt;
         public Integer p;
     }
     
     public class Status {
         public String serverStatusCode;
         public String severity;
         public List<AdditionalStatus> additionalStatus;
     }
 
     public Status status;
 
     public class AdditionalStatus {
         public Integer statusCode;
         public String serverStatusCode;
         public String severity;
         public String statusDesc;
     }
     
     public static CIF_BusinessWrapper parse(String json) {
         return (CIF_BusinessWrapper) System.JSON.deserialize(json, CIF_BusinessWrapper.class);
     }
 
 }