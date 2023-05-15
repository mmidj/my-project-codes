Datetime today =Datetime.now();
System.debug('Today is ' + today);

// To
system.debug('Todays date: '+ today);
Datetime oneWeekAgo = Datetime.now()-7;
system.debug('One week ago: '+ oneWeekAgo);

BatchUserDeactivation asd = new BatchUserDeactivation();
Id batchId = Database.executeBatch(asd,1);

//Contract Batch Class
ContractEndDateBatch batchContract = new ContractEndDateBatch();
Id BatchContractId = Database.executeBatch(batchContract, 1);

//Invoke Schedulable class Invocation Code
ContractEndDateBatch scheduleBatchContract = new ContractEndDateBatch();
String cronExp = '0 30 8 ? * MON-FRI 2023-2024'; 
System.schedule('Contract Exp.Notification', cronExp, scheduleBatchContract);


List<Account> childAccounts = AccountController.getChildAccounts('001Dn0000095ugdIAA');
system.debug(childAccounts);

/*List<Contact> childContacts = AccountController.getChildContacts('003Dn0000069WH7IAM');
system.debug(childContacts);*/