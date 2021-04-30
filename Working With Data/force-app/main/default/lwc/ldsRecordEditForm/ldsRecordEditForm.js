import { LightningElement, api } from 'lwc';

export default class LdsRecordEditForm extends LightningElement {
    @api recordId;
    @api objectApiName;
}