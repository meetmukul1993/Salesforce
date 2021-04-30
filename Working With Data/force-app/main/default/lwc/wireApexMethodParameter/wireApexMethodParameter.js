import { LightningElement, wire, api } from 'lwc';
import getCaseList from '@salesforce/apex/caseController.getCaseList';

export default class WireApexMethodParameter extends LightningElement {

    @api subject = ''; 
    @api records;
    @api error;

    handleChange(event){
        this.subject = event.target.value;
    }

    @wire(getCaseList, {'subject' : '$subject'})
        caseData({data, error}){
            if(data){
                this.records = data;
                this.error = undefined;
            }else{
                this.error = error;
                this.records = undefined;
            }
        }
}