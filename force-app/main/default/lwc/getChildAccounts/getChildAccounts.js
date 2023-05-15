import { LightningElement,api,wire  } from 'lwc';
import getChildAccounts from '@salesforce/apex/AccountController.getChildAccounts';
export default class GetChildAccounts extends LightningElement {

    @api recordId;
    @wire(getChildAccounts,{parentAccId:'$recordId'})
    childAccounts;

    //Note-1: This wire method gets two parameters. 1. the name of the imported Apex method. 2. The parameter information of this imported method if there is any.

    //Note-2: the wire services are reactive, so every variable(local property) we pass must also be reactive. So do not forget to make your variables reactive. '$variableName' : Single quotation and $ makes the variable reactive. Reactive: keeps the variable up to date with any changes.
    
}