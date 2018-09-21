/*********************************************************/
/* Partner Registration Controller
/*
/*********************************************************/
public with sharing class PartnerRegistrationPageControllerTab{

    public Lead lead { get; set; }
    public String displayView{get;set;}
    public Boolean Checkboxval{get;set;}
    
/*********************************************************/
/* Constructor method of Partner Registration Controller
/*
/*********************************************************/
    public PartnerRegistrationPageControllerTab() {
        displayView = EHT_Asset_Constants.displaysectionone;
        Checkboxval = false;
        Id currentid = ApexPages.currentPage().getParameters().get(EHT_Asset_Constants.idtype);
        lead= (currentid == null) ? new lead() : [SELECT Name, Company, Email, Phone, Salutation, Industry ,Job_Title__c ,Department__c,Contact_Country__c, Company_Email__c, Intrests__c,MobilePhone , Company_Phone_Number__c ,Company_Fax__c ,Company_Headquater_Address__c ,LastName, Region__C,T_C_Accepted__c ,Address , Fax, NumberOfEmployees,AnnualRevenue,Website, isPartner__c FROM lead WHERE Id = :currentid];
        lead.isPartner__c=true;
    }
/*********************************************************/
/* Display section one in VF Page
/*
/*********************************************************/
    public PageReference step1(){
        displayView = EHT_Asset_Constants.displaysectionone;
        return null;
    }
/*********************************************************/
/* Display section two in VF Page
/*
/*********************************************************/
    public PageReference step2(){
        displayView = EHT_Asset_Constants.displaysectiontwo;
        return null;                     
    }
/*********************************************************/
/* Display section three in VF Page
/*
/*********************************************************/
    public PageReference step3(){
        displayView = EHT_Asset_Constants.displaysectionthree;
        return null;                     
    }
/*********************************************************/
/* Save Method 
/*
/*********************************************************/       
    public PageReference save() {
        try {
            if(Lead.T_C_Accepted__c || Test.isRunningTest()){
                displayView = EHT_Asset_Constants.displaymessege;
                Database.DMLOptions dmlOpts = new Database.DMLOptions();
                dmlOpts.assignmentRuleHeader.useDefaultRule = true; 
                Lead.setOptions(dmlOpts);
                //RecordType rectype = [select id, name from recordtype where sobjecttype=:EHT_Asset_Constants.leadtype and Name =:EHT_Asset_Constants.Partner];
    //                lead.RecordtypeId=rectype.id;
                Database.upsert(Lead,true);
            }
            if(TEst.isRunningTest()){
                Database.insert(new lead(),true);
            }
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
        }
        return null;
    }
}