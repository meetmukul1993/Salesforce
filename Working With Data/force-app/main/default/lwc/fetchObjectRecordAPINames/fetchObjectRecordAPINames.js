import { LightningElement, api } from 'lwc';

export default class FetchObjectRecordAPINames extends LightningElement {

    @api recordId;
    @api objectApiName;

    constructor(){
        super();
        console.log('record id ' + this.recordId);
    }
}