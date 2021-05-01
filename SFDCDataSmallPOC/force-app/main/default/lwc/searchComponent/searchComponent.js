import { LightningElement, track } from 'lwc';

export default class SearchComponent extends LightningElement {
    @track searchVal;

    handleChange(event){
        const value = event.target.value;
        this.searchVal = value;

        const searchEvent = new CustomEvent('search', 
            {
                detail : this.searchVal
            }
        );
        this.dispatchEvent(searchEvent);
    }


}