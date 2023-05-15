public with sharing class ContractEndDateBatch implements Database.Batchable <sObject>, Database.Stateful ,schedulable {
    Integer counter = 0;
    //Start Method
    public Database.QueryLocator start(Database.BatchableContext bc){
        //Please prepare Dynamic query. Dynamic query must be written as String datatype. The databse.queryLocator recognizes this string and process the SOQL accordingly.
        String dQuery = 'SELECT Id, EndDate, Asset_Manager__r.Email,Leasing_Admin__r.Email, Leasing_Analyst__r.Email FROM Contract WHERE EndDate=NEXT_N_DAYS:5 ORDER BY EndDate ASC';
        return Database.getQueryLocator(dQuery);
    }
    //Execute Method
    public void execute(Database.BatchableContext bc, List<Contract> listContract){
        if(listContract.size()>0){
            List<Messaging.SingleEmailMessage> emailsTobeSent = new List<MEssaging.SingleEmailMessage>();
            for(Contract w : listContract ){
                //Prepare the instance of Messaging.SingleEmailMessage Object in order to send any email.
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                //Prepare the recepients(To, CC or Bcc) To Whom?
                List<String> emailMembers = new List<String>();
                emailMembers.add(w.Asset_Manager__r.Email);
                emailMembers.add(w.Leasing_Admin__r.Email);
                emailMembers.add(w.Leasing_Analyst__r.Email);
                email.setToAddresses(emailMembers);
                //Prepare your Subject of your email
                email.setSubject('Attention! The Contract is expiring Soon!');
                //Prepare your body of your email
                email.setPlainTextBody(
                    'Hello,'+ '\n'
                    + 'The following contract is expiring soon' +'\n'
                    + 'Contract End Date: ' + w.EndDate + '\n'
                    +'Please see the contract details from the following link' + '\n'
                    + 'https://newagora-c-dev-ed.develop.lightning.force.com/lightning/r/Contract/'+w.Id+'/view' +'\n'
                    + 'Thank you for your attention on this matter!'
                );
                //Add all of these to your messaging.SingleEMailMessage List.(Prepare this list first :)
                emailsTobeSent.add(email);
                //Now, send the emials!
                Messaging.sendEmail(emailsTobeSent); 
                counter++;
            }
        }
        
    }
      //Finish Method
      public void finish(Database.BatchableContext bc){
        System.debug('The number of Emials sent: '+counter);
        AsyncApexJob myBatch = [SELECT Id, Status, JobItemsProcessed, TotalJobItems,NumberOfErrors
                                FROM AsyncApexJob
                                WHERE id=:bc.getJobId()]; //WHERE id=:BatchContractId - See your batch.apex script to see the name of your batch id.

        System.debug('Job Items Processsed: '+ myBatch.JobItemsProcessed);
        System.debug('Status: '+ myBatch.Status);

    //Send a summary repor to your manager:  Optional
    }

    //Schedule your Batch Class
    public void execute(SchedulableContext cs){
        ContractEndDateBatch batchContract = new ContractEndDateBatch();
        Id BatchContractId = Database.executeBatch(batchContract, 1);

        ContractEndDateBatch scheduleBatchContract = new ContractEndDateBatch();
        String cronExp = '0 30 8 ? * MON-FRI 2023-2024'; 
        System.schedule('Contract Exp.Notification', cronExp, scheduleBatchContract);
    }
    
   
}