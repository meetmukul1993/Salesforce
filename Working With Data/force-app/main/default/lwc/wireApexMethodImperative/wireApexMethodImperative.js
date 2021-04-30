import { LightningElement, wire, api } from 'lwc';
import getAllCaseList from '@salesforce/apex/caseController.getAllCaseList';

export default class WireApexMethodImperative extends LightningElement {

    @api error;
    @api records;

    handleEvent(){
        getAllCaseList()
        .then( result => {
            this.records= result;
            console.log(this.records);
            this.error = undefined;
        })
        .catch( error => {
            this.error = error;
            this.records = undefined;
        })
    }
}