import { LightningElement } from 'lwc';
import {createRecord} from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';

export default class WireAdaptercreateRecord extends LightningElement {

    recordId; 
    handleClick(){    
        const fieldsObj = {};
        fieldsObj[NAME_FIELD.fieldApiName] = 'SFDCMukul';
        const accRecord = {apiName : ACCOUNT_OBJECT.objectApiName , fields: fieldsObj};

        createRecord(accRecord)
        .then(result => {
            const id = result.id;
            this.recordId = id;
            console.log('Record Id - ' + id  );
        })
        .catch(error => {
            console.log('error  = ' + error);
        })
    }

}