public with sharing class AccountObjHandler {
    public static void beforeInsert(List<Account> newAccounts){
    // copy the billing address ti mailing shiping address
    for (Account acc : newAccounts) {


        if(acc.AnnualRevenue == null || acc.AnnualRevenue<1000000){
            acc.addError('Oppa!, Annual Revenue can not be less then $1000,000');
        }

        if (acc.BillingStreet != null && acc.BillingCity != null && acc.ShippingStreet == null && acc.ShippingCity== null) {
          acc.ShippingStreet =  acc.BillingStreet;
          acc.ShippingCity = acc.BillingCity;
          acc.ShippingState = acc.BillingState;
          acc.ShippingCountry = acc.BillingCountry;
          acc.ShippingPostalCode = acc.BillingPostalCode;
        }
    }
    }
    public static void beforeUpdate(){
        
    }
    public static void beforeDelete(){
        
    }

    // save

    public static void afterInsert(){
        
    }
    public static void afterUpdate(){
        
    }
    public static void afterDelete(){
        
    }
    public static void afterUndelete(){
        
    }
}