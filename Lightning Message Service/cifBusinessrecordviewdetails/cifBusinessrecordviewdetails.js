import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import PASS_CIFID_CHANNEL from '@salesforce/messageChannel/Pass_Cifid__c';

export default class CifBusinessrecordviewdetails extends LightningElement {

    cifId; 
    @wire(MessageContext)
    messageContext;

    subscribeToMessageChannel() {
        this.subscription = subscribe(
          this.messageContext,
          PASS_CIFID_CHANNEL,
          (message) => this.handleMessage(message)
        );
      }
      handleMessage(message) {
        this.cifId = message.cifId;
        console.log('Cif ID ' + this.cifId);
      }
      connectedCallback() {
        this.subscribeToMessageChannel();
      }
}