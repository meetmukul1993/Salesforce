import { LightningElement, api } from 'lwc';

export default class RecordList extends LightningElement {

    @api record;
    @api iconName;

    

    handleSelect(){
        console.log(this.iconName);
        console.log(this.record);
        console.log(this.record.Id);
        const selectEvent = new CustomEvent('select', 
            {
                detail : this.record.Id
            }
        );

        this.dispatchEvent(selectEvent);
    }

}