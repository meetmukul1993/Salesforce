import { LightningElement, wire, track} from 'lwc';
import fetchAccounts from '@salesforce/apex/accountController.fetchAccounts';

const columns = [{
    label: 'View',
    type: 'button-icon',
    initialWidth: 75,
    typeAttributes: {
        iconName: 'action:preview',
        title: 'Preview',
        variant: 'border-filled',
        alternativeText: 'View'
    }
},
{
    label: 'Name',
    fieldName: 'Name'
},
{
    label: 'Phone',
    fieldName: 'Phone'
},
{
    label: 'Type',
    fieldName: 'Type'
}
];

export default class DataTable extends LightningElement {
    @track columns = columns;
    @track record = {};
    @track rowOffset = 0;
    @track data = {};
    @track bShowModal = false;
    @wire(fetchAccounts) parameters;
 
    // Row Action event to show the details of the record
    handleRowAction(event) {
        const row = event.detail.row;
        this.record = row;
        this.bShowModal = true; // display modal window
    }
 
    // to close modal window set 'bShowModal' tarck value as false
    closeModal() {
        this.bShowModal = false;
    }
}