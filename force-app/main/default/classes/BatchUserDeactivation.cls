public with sharing class BatchUserDeactivation implements Database.Batchable<sObject>, Database.Stateful, Schedulable {
    Integer numberOfDeactivatedUsers = 0;
    List<String> deactivatedUsers = new List<String>();
    //Start Method
    public Database.QueryLocator start(Database.BatchableContext bc){
         String daysAmount = System.Label.User_Deactivation;  // I got my Custom Label in Start method.
         Integer numberOfDays = Integer.valueOf(daysAmount);     // Converted the string value as Integer value 
         Datetime lastNumberAccessDay = Datetime.now() - numberOfDays; //Go back to numberofDays from now on to find the last access day.
         return Database.getQueryLocator([SELECT Id, Name, LastLoginDate, IsActive 
                                          FROM User
                                          WHERE (LastLoginDate <= :lastNumberAccessDay OR (LastLoginDate = null AND CreatedDate <=: lastNumberAccessDay)) AND IsActive = true]);

    }

    //Execute Method
    public void execute(Database.BatchableContext bc, List<User> sObjectList){
        if (sObjectList.size()>0){
            for (User w : sObjectList){
                w.IsActive = false;
                numberOfDeactivatedUsers++;
                String userName = w.Name;
                deactivatedUsers.add(userName);
        }
        Database.update(sObjectList, false);
        //Syntax:Database.update(sobject, allOrNothing)
            //allOrNothing = true : If error occurs while updating, cancel everything and do not make any update.
            //allOrNothing = false : If error occurs while updating, that's ok. Just update the ones that have no error and deactivate their accounts.
    }
}

    //Finish Method
    public void finish(Database.BatchableContext bc){
        system.debug('Number of Deactivated users: '+ numberOfDeactivatedUsers);
        system.debug('Num of the Deactivated users: '+ deactivatedUsers);
        // send email to your manager with the deactivation information
        // step 1: get instance of 'messaging.SingleEmailMessage' object
        // step 2: get instance of'messaging.EmailMessage' object
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        list<String> emailAddresses = new List<String>{'ahmadpouya2016@gmail.com', 'menhaj.afg@gmail.com'};
        email.setToAddresses(emailAddresses);
      //  lis<String> ToBccEmailAddresses = new List<String>{'ahmadpouya2016@gmail.com', 'menhaj.afg@gmail.com'};
      //  lis<String> ToCcEmailAddresses = new List<String>{'ahmadpouya2016@gmail.com', 'menhaj.afg@gmail.com'};
       // email.setBccAddresses(ToBccEmailAddresses);
       // email.setCcAddresses(ToCcEmailAddresses);
       // add subject
       email.setSubject('User Deactivation Job');
       // add body 
       email.setPlainTextBody('Hello, ' + '\n' 
                                        + 'Names of deactivated users: '+ deactivatedUsers + '\n' 
                                        + 'Number of deactivated users: '+ numberOfDeactivatedUsers);
       //send email
       // create empaty 
       List<Messaging.SingleEmailMessage> listEmail = new List<Messaging.SingleEmailMessage>();
       listEmail.add(email);
       Messaging.sendEmail(listEmail);
       // end of email
    }
    // way 1 : add your schedulable execute method in side of your batch class and implement schedulable interface.
    public void execute(SchedulableContext sc){
        BatchUserDeactivation asd = new BatchUserDeactivation();
        Id batchId = Database.executeBatch(asd,1);
    }
}