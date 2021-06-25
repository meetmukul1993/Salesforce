import { LightningElement, api } from 'lwc';

export default class LdsCreateRecord extends LightningElement {

    objectApiName;

    successHandler(){
        alert('record created');
    }
}