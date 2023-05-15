public with sharing class AccountController {
  //step1: if you want to use your APex class in LWC, we need to decorate our method with @AuraEnabled(cacheable=true)
    //get the child accounts of the parent accounts.
    @AuraEnabled(cacheable=true)
    public static List<Account> getChildAccounts(String parentAccId){
        return[SELECT Id, Name,BillingStreet,BillingState, BillingPostalCode, BillingCountry, BillingCity
               FROM Account
               WHERE ParentId =: parentAccId
               WITH SECURITY_ENFORCED];
    }

    //get the contacts of the child Accounts.
    @AuraEnabled(Cacheable=true)
    public static List<Contact> getChildRelatedContacts(String childAccId){
        return[SELECT Id, Name,AccountId,Account.Name, MailingStreet, MailingState, MailingPostalCode, MailingCountry, MailingCity
               FROM Contact
               WHERE AccountId =:childAccId
               WITH SECURITY_ENFORCED];
    }
}