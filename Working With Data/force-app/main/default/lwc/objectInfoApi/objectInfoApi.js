import { LightningElement, wire, track } from 'lwc';
import {getObjectInfo, getPicklistValues} from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class ObjectInfoApi extends LightningElement {

    @track value;
    @track pickVal;

    @wire(getObjectInfo, {objectApiName: ACCOUNT_OBJECT})
    wireAccount({data, error}){
        if(data){
            // console.log(data);

        }
        if(error){
            // console.log(error);
        }
    }

    @wire(getPicklistValues, {recordTypeId: '012000000000000AAA', fieldApiName : INDUSTRY_FIELD})
        wiredField({data, error}){
            if(data){
                console.log('data ' + data);
                this.pickVal = data.values;
            }
            if(error){
                console.log('error ' + error);
            }
        }
}
