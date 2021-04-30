import { LightningElement, wire, api } from 'lwc';
import findContacts from '@salesforce/apex/contactController.findContacts';

const DELAY = 300;

export default class ApexWireMethodWithParams extends LightningElement {

    searchKey = '';

    @wire(findContacts, {searchKey : '$searchKey'})
    contacts;

    handleKeyChange(event){
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
        }, DELAY);
    }
}