import { LightningElement, api, wire, track } from 'lwc';
import BusinessSearchController from '@salesforce/apex/BusinessSearchController.searchBusinesses';
import getRecordfromCIF from '@salesforce/apex/BusinessSearchController.getRecords';

const COLS = [
    {
        label: 'View',
        type: 'button-icon',
        initialWidth: 75,
        typeAttributes: {
            iconName: 'action:preview',
            title: 'Preview',
            variant: 'border-filled',
            alternativeText: 'View'
        }
    },
    { label: 'CIF ID', fieldName: 'key'},
    { label: 'Full Name', fieldName: 'fullName'},
    { label: 'Country', fieldName: 'countryCd'},
    { label: 'city', fieldName: 'city' },
    { label: 'postalCode', fieldName: 'postalCode' },
    { label: 'territory', fieldName: 'territory'},
    {type: "button", 
        typeAttributes: {  
            label: 'View',  
            name: 'View',  
            title: 'View',  
            disabled: false,  
            value: 'view',  
            iconPosition: 'left',
            alternativeText: 'View'  
        }
    }
];


// {type: "button", typeAttributes: {  
//     label: 'Create',  
//     name: 'Create',  
//     title: 'Create',  
//     disabled: false,  
//     value: 'create',  
//     iconPosition: 'left'  
// }} 

export default class BusinessSearch extends LightningElement {

    @track record = {};
    @track bShowModal = false;

    data = [];
    columns = COLS;

    recordCIF;
    
    formObj = {'restartToken' : ''};
    fname = '';
    lname = '';
    phone = '';
    email = '';
    restartToken = '';

    handleClick(event){
        event.preventDefault();
        var formData = this.template.querySelectorAll('lightning-input');
        //alert(formData);
        console.log('mukul '  + formData);

        const fields = event.detail.fields;
        console.log(fields);

        if(formData){
            
            formData.forEach(function(element){
                console.log('Field is==> ' + element.value);
                this.formObj[element.name] = element.value;
            },this);

        }
        // alert('mukul');
        console.log(this.formObj);

        var tst = {restartToken : '', name: this.formObj['name'], postalCode : this.formObj['postalCode'], telephoneNum: this.formObj['telephoneNum']};

        console.log(tst);

        // this.formObj
        BusinessSearchController({restartToken : '', name: this.formObj['name'], postalCode : this.formObj['postalCode'], telephoneNum: this.formObj['telephoneNum']})
        .then(data => {
            console.log(data);
            this.data = data.results;
        })
        .catch(error => {
            console.log(error);
        })   
    }

    callRowAction( event ) {  
          
        const row = event.detail.row;
        this.record = row;
        const recId =  event.detail.row.key;  
        console.log('record ID : ' + recId);
        const actionName = event.detail.action.name;  
        this.bShowModal = true; // display modal window

        getRecordfromCIF({'CifId' : recId})
        .then(data => {
            console.log(data);
            this.recordCIF = data;
        })
        .catch(error => {
            console.log(error);
        }) 

        if ( actionName === 'Edit' ) {  
  
            // this[NavigationMixin.Navigate]({  
            //     type: 'standard__recordPage',  
            //     attributes: {  
            //         recordId: recId,  
            //         objectApiName: 'Account',  
            //         actionName: 'edit'  
            //     }  
            // })  
  
        } else if ( actionName === 'View') {  
  
            // this[NavigationMixin.Navigate]({  
            //     type: 'standard__recordPage',  
            //     attributes: {  
            //         recordId: recId,  
            //         objectApiName: 'Account',  
            //         actionName: 'view'  
            //     }  
            // })  

            // alert('View Button Clicked');
  
        }
    }  
}