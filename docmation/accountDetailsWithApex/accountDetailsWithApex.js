import { LightningElement, api, wire, track } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';

import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';

export default class AccountDetailsWithApex extends LightningElement {

    @api recordId;
    @track error;
    @track record;


    @wire(getRecord, {recordId : '$recordId', fields : [ACCOUNT_NAME_FIELD]})
    wiredaccount({data, error}){
        if(data){
            this.record = data;
            this.error = undefined;
        }
        if(error){
            this.error = error;
            this.record = undefined;
        }
    }
    get name(){
        return this.record.fields.Name.value;
    }

}