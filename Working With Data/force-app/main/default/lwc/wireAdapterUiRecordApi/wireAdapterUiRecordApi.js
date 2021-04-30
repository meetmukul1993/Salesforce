import { LightningElement, api, wire } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';

export default class WireAdapterUiRecordApi extends LightningElement {
    @api recordId;

    @wire(getRecord, {
        recordId : '$recordId',
        layoutTypes : ['Full', 'Compact'],
        modes: ['View', 'Edit', 'Create']
    })
    wiredRecord({data, error}){
        if(data){
            console.log('Data ' , data);
        }
        if(error){
            console.log('Error ' + error);
        }
    }
}