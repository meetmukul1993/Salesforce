import { LightningElement, wire, api, track } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD  from '@salesforce/schema/Account.Name';

export default class WireFunction extends LightningElement {

    @api recordId;
    @track record;
    @track error;

    @wire(getRecord, {recordId: '$recordId', fields : [ACCOUNT_NAME_FIELD]})
    wiredAccount({error, data}){
        if(data){
            this.record = data;
            this.error = undefined;
        }else{
            this.error = error;
            this.data = undefined;
        }
    }

    get name(){
        return this.record.fields.Name.value;
    }
}