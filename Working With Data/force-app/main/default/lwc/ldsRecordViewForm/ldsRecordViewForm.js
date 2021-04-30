import { LightningElement, api } from 'lwc';
// import LastName from '@salesforce/schema/Contact.LastName';
// import Phone from '@salesoforce/schema/Contact.Phone';
export default class LdsRecordViewForm extends LightningElement {

    @api recordId;
    @api objectApiName;

    // FIELDS = [LastName, Phone];
}