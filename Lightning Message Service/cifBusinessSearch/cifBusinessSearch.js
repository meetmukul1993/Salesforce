import { LightningElement, api, wire, track } from 'lwc';
import BusinessSearchController from '@salesforce/apex/BusinessSearchController.searchBusinesses';
// import getRecordfromCIF from '@salesforce/apex/BusinessSearchController.getRecords';
import { publish, MessageContext } from 'lightning/messageService';
import PASS_CIFID_CHANNEL from '@salesforce/messageChannel/Pass_Cifid__c';

import NoRecordFoundLabel from '@salesforce/label/c.BBCRM_No_Records_Found';

const COLS = [  
    { label: 'Customer Name', fieldName: 'fullName'},
    { label: 'Alias', fieldName: 'aliasName'},
    { label: 'Street Address', fieldName: 'addressLine2'},
    { label: 'City', fieldName: 'city'},
    { label: 'Postal Code', fieldName: 'postalCode'},
    { label: 'Province', fieldName: 'territory'},
    { label: 'Country', fieldName: 'countryCd'},
    {type: "button", 
        typeAttributes: {  
            label: 'View',  
            name: 'View',  
            title: 'View',  
            disabled: false,  
            value: 'view',  
            iconPosition: 'left'  
        }
    },
    {
        type: 'button-icon',
        label: 'View',       
        initialWidth: 75,
        typeAttributes: {
            iconName: 'action:preview',
            title: 'Preview',
            name: 'Preview',  
            variant: 'border-filled',
            alternativeText: 'View'
        }
    },
];

export default class cifBusinessSearch extends LightningElement {  

    @wire(MessageContext)
    messageContext;
    
    @track temp = [];

    @track record = {};
    @track bShowModal = false;
    @track isLoading = false;
    data = [];
    columns = COLS;
    recordCIF;    
    formObj = {'restartToken' : ''};
    restartToken = '';
    fieldValidity = true;
    searchButtonClicked = false;
    isNext = false;
    showError = false;
    label = {
        NoRecordFoundLabel
    };
    handleClick(event){
        event.preventDefault();
        this.isLoading = true;
        this.isNext = false;
        //this.data = [];        

        const allValid = [...this.template.querySelectorAll('input')]
            .reduce((validSoFar, inputCmp) => {
                        inputCmp.reportValidity();
                        return validSoFar && inputCmp.checkValidity();
            }, true);

        if (allValid) {
            this.data = [];
            var formData = this.template.querySelectorAll('input');
            const fields = event.detail.fields;

            if(formData){
                formData.forEach(function(element){
                    this.formObj[element.name] = element.value;
                },this);
            }

            BusinessSearchController({restartToken : '', name: this.formObj['name'], postalCode : this.formObj['postalCode'], telephoneNum: this.formObj['telephoneNum']})
            .then(data => {
                this.isLoading = false;
                var status = data.status;
                console.log(data);
                if(status.localeCompare("SUCCESS") == 0){
                    this.showError = false;
                    this.data = data.results;

                    this.searchButtonClicked = true;
                    let restartToken = data.restartToken;
                    if(restartToken){
                        this.isNext = true;
                        this.restartToken =  data.restartToken;
                    }
                }
                else{
                    this.showError = true;
                    this.isLoading = false;
                }
            })
            .catch(error => {
                this.showError = true;
                this.isLoading = false;
                console.log(error);
            })  
        }
        else {
            alert('Please enter Name field and search again.');
            this.isLoading = false;
        }
    }

    callRowAction( event ) {

        const rowObj =  event.detail.row;
        console.log(rowObj);
        console.log(JSON.stringify(rowObj));

        const actionName = event.detail.action.name;
        if ( actionName === 'View') {  
            // var rowIndex = rows.indexOf(row);
            // console.log('Row Index  = ' + actionName);

            let CIFID = rowObj.key;
            console.log("CIFID " + CIFID);
        }     

        if ( actionName === 'Preview') {  
            console.log('Row Index  = ' + actionName);

            let CIFID = rowObj.key;
            console.log("CIFID " + CIFID);

            const payload = {
                cifId : CIFID
            }
            publish(this.messageContext, PASS_CIFID_CHANNEL, payload);
        }
    }  

    fetchMoreRecords(event){
        this.isLoading = true;
        var formData = this.template.querySelectorAll('lightning-input');
        this.formObj['restartToken'] = this.restartToken;

        BusinessSearchController({restartToken : this.formObj['restartToken'], name: this.formObj['name'], postalCode : this.formObj['postalCode'], telephoneNum: this.formObj['telephoneNum']})
        .then(data => {
            this.isLoading = false;
            this.data = [];
            console.log(data);
            this.data = data.results;
            let restartToken = data.restartToken;
            if(restartToken){
                this.isNext = true;
                this.restartToken =  data.restartToken;;
            }else{
                this.restartToken = undefined;
                this.isNext = false;
            }
        })
        .catch(error => {
            console.log(error);
        });
    }
}
