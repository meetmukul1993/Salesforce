public class CIF_BusinessRetrieveWrapper {

    
    public Business business;
	public Integer f;
	public String clTrackingId;
    public Status status;

	public class Locator_Z {
		public TelephoneNumber_Y telephoneNumber;
		public Integer t;
	}

	public class Locator_Y {
		public EmailAddress emailAddress;
		public Integer x;
	}

	public class StreetAddress_Z {
		public String addressLine1;
		public String addressLine2;
        public String addressLine3;
		public String city;
		public String territory;
		public String postalCode;
		public String countryCd;
		public Integer f;
	}

	public class TelephoneNumber {
		public String areaCodeNum;
		public String exchangeNum;
		public String lineNum;
		public String telephoneNum;
		public Integer k;
	}

	public class EmailAddress {
		public String text;
		public Integer e;
	}

	public class Contact {
		public String usageCd;
		public List<Locator> locator;
		public Integer b;
		public Integer p;
		public Integer f;
	}

	public class StreetAddress {
		public String addressLine1;
		public String addressLine2;
        public String addressLine3;
		public String city;
		public String territory;
		public String postalCode;
		public String countryCd;
		public Integer d;
	}

	public class Locator {
		public StreetAddress_Z streetAddress;
		public Integer d;
		public TelephoneNumber_Z telephoneNumber;
		public Integer h;
        public EmailAddress emailAddress;
	}

	public class TelephoneNumber_Z {
		public String areaCodeNum;
		public String exchangeNum;
		public String lineNum;
		public String telephoneNum;
		public Integer p;
	}

	public class TelephoneNumber_Y {
		public String areaCodeNum;
		public String exchangeNum;
		public String lineNum;
		public String telephoneNum;
		public Integer s;
	}

	public class BusinessCIFExtension {
		public String lastMaintenanceBranchNum;
		public String lastMaintenanceDt;
		public String streetAddressLastMaintenanceDt;
		public String streetAddressLastMaintenanceBranchNum;
		public List<String> name;
		public Integer m;
	}
    public class Identification {
		public String typeCd;
		public String identificationNum;
		public Integer r;
		public String issuingCountryCd;
		public String issuingTerritoryCd;
		public String startDt;
		public Integer n;
	}
	public class Business {
		public String languageCd;
		public String statusCd;
		public String customerStartDt;
		public String aliasName;
		public String homeBranchNum;
		public String legalClassificationCd;
		public String legalSubClassificationCd;
		public String startDt;
        public Integer fullTimeEmployeeCnt;
		public Integer partTimeEmployeeCnt;
        public String employeeCountYm;
		public String fiscalYearEndYm;
        public Integer annualRevenueAmt;
        public String mailCd;
		public String taxResidenceCd;
		public String industrialSectorClassificationCd;
		public String industrialSectorClassificationDesc;
		public String standardIndustrialClassificationCd;
		public String standardIndustrialClassificationDesc;
		public String fullName;
		public TelephoneNumber telephoneNumber;
		public List<String> segmentCd;
		public StreetAddress streetAddress;
		public BusinessCIFExtension businessCIFExtension;
		public String key;
		public List<Contact> contact;
        public List<Identification> identification;
        public List<Preference> preference;
		public Integer w;
        
	}
    
    public class Preference 
    {
	    public Solicitation solicitation;
        public Contact_Z contact;
		public Privacy privacy;
		
	}
    
    public class Solicitation {
		public String typeCd;
		public Boolean preferenceInd;
		public Integer l;
	}

	public class Contact_Z {
		public String channelTypeCd;
		public Boolean preferenceInd;
		public Integer e;
	}

	public class Privacy {
		public String dataUsageCd;
		public Boolean preferenceInd;
		public Integer c;
	}

        public class Status 
        {
		public String serverStatusCode;
		public String severity;
		public List<AdditionalStatus> additionalStatus;
	}

	public class AdditionalStatus {
		public Integer statusCode;
		public String serverStatusCode;
		public String severity;
		public String statusDesc;
	}
	
    public static CIF_BusinessRetrieveWrapper parse(String json) {
		return (CIF_BusinessRetrieveWrapper) System.JSON.deserialize(json, CIF_BusinessRetrieveWrapper.class);
	}
}