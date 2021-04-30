import { LightningElement, api } from 'lwc';

export default class ldsEditForm extends LightningElement {
    @api recordId;
    @api objectApiName;
}