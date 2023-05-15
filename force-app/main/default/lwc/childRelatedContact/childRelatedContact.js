import { LightningElement, api, wire} from 'lwc';
import getChildRelatedContacts from '@salesforce/apex/AccountController.getChildRelatedContacts';
export default class ChildRelatedContact extends LightningElement {

    @api recordId;
    @wire(getChildRelatedContacts, {childAccId:'$recordId'})
    relatedConList;

}