import { LightningElement, api } from 'lwc';

export default class LdsCreateRecords extends LightningElement {

    @api objectApiName;

    handleSuccess(){
        console.log('success');
    }
}