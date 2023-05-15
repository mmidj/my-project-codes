public with sharing class OpportunityTriggerHandler {
   public static void createContract(List<Opportunity>  listOpp, Map<Id,Opportunity> mapOpp) {
    // List<Opportunity> listOpp = Opportunity.getOpportunities();
    // step one
    List<Contract> toBeInserted = new List<Contract>(); //empaty list of contract
    //step 2
    for (Opportunity opp : listOpp) {
        if (opp.StageName == 'Closed Won' /*&& opp.StageName != mapOpp.get(opp.Id).StageName*/) {

            Contract con = new Contract(); //create a new instance of the object
            con.AccountId = opp.AccountId;
            con.Status = 'Draft';
            con.StartDate = opp.CloseDate;
            con.ContractTerm = 4;
            con.Leasing_Admin__c = opp.Leasing_Admin__c;
            con.Leasing_Analyst__c = opp.Leasing_Analyst__c;
            con.Space__C = opp.Space__C;
            con.Asset_Manager__c = opp.Asset_Manager__c;
            con.Center__c = opp.Center__c;
            con.OwnerId = opp.OwnerId;
            toBeInserted.add(con);
            
        }
        insert toBeInserted;
    }
}

    public static void mapTeamMemeber(List<Opportunity> oppList){
        // step 1 : we need o feth the center ids and put them in a collection of set.
        Set<String> centerIds = new Set<String>();
        for (Opportunity w : oppList) {
            if (String.isNotBlank(w.Center__c)) {
                centerIds.add(w.Center__c);
            }
        }
       //Step-2: Create a map collection and fetch the center data(Names) with SOQL in the map.
       Map<Id,Center__c> mapCenter = new Map<Id,Center__c>([SELECT Id,Name,Leasing_Admin__c,Leasing_Analyst__c,Asset_Manager__c 
       FROM Center__c
       WHERE Id IN:centerIds]);
        for(Opportunity ww : oppList){
           if(String.isNotBlank(ww.Center__c) && mapCenter.containsKey(ww.Center__c)){
             ww.Leasing_Admin__c = mapCenter.get(ww.Center__c).Leasing_Admin__c;
             ww.Leasing_Analyst__c = mapCenter.get(ww.Center__c).Leasing_Analyst__c;
             ww.Asset_Manager__c = mapCenter.get(ww.Center__c).Asset_Manager__c;
           }
       }
   }
} 
