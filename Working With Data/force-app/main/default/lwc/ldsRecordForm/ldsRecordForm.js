import { LightningElement, api } from 'lwc';

export default class LdsRecordForm extends LightningElement {

    @api recordId;
    @api objectApiName; 

    successHandler(){
        console.log('success');
    }

    submitHandler(){
        console.log('submit');
    }
}