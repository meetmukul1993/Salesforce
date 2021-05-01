import { LightningElement, api, track } from 'lwc';
import findRecord from '@salesforce/apex/lookupController.findRecord';
export default class customLookup extends LightningElement {

    @api objectApiName;
    @api fieldApiName;
    @api iconName = 'custom:custom35';

    @api error;
    @api records;

    @track selectedRecord;

    handleSearch(event){
        
        const searchValue = event.detail;
        // console.log('search value  ' + searchValue);
        findRecord({
            objectApiName : 'Account',
            fieldApiName : 'Name',
            searchTerm : searchValue
        })
        .then(result =>{
            this.records= result;
            // console.log(result)
            // console.log(this.records);
            this.error = undefined;
        })
        .catch(error => {
            this.error = error;
            this.records = undefined;
            console.log('error  ' + error);
        })
    }

    handleSelect(event){
        
        const contactId = event.detail;
        console.log('Selected Record  contactId = ' + contactId );

        const selectedRec = this.records.find(record => record.Id === contactId);
        console.log(selectedRec);
        this.selectedRecord = selectedRec;
    }
}