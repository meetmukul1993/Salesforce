import { LightningElement, api, wire } from 'lwc';
import getContactList from '@salesforce/apex/contactController.getContactList';

export default class WireApexMethod extends LightningElement {

    @wire(getContactList)
        contacts;
}