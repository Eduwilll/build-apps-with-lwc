import { LightningElement } from 'lwc';
import ursusResources from '@salesforce/resourceUrl/ursus_park';
/** BearController.getAllAccounts() Apex method */
import getAllAccounts from '@salesforce/apex/AccountControl.AccountControl';
export default class BearList extends LightningElement {
	Accts;
	error;
	
	connectedCallback() {
		this.loadAccts();
	}
	loadAccts() {
		getAllAccounts()
			.then(result => {
				this.Accts = result;
			})
			.catch(error => {
				this.error = error;
			});
	}
}