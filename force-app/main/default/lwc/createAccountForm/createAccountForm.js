import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import conObject from '@salesforce/schema/Contact';
import conFirstName from '@salesforce/schema/Contact.FirstName';
import conLastName from '@salesforce/schema/Contact.LastName';
import conBday from '@salesforce/schema/Contact.Birthdate';
import conEmail from '@salesforce/schema/Contact.Email';
import conDepartment from '@salesforce/schema/Contact.Department';
import conAccountId from '@salesforce/schema/Contact.AccountId';
import conType from '@salesforce/schema/Contact.Type__c';
import conCPF from '@salesforce/schema/Contact.CPF__c';
import conCNPJ from '@salesforce/schema/Contact.CNPJ__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactForm extends LightningElement {
    firstName = '';
    lastName = '';
    bday= '';
    emailId='';
    departmentVal='';
    value = 'Escolha';
    juridico = '';
    fisico = '';
    lastInsertedContactId = '';



    get options() {
        return [
            { label: '--None--', value: '' },
            { label: 'Juridico', value: 'Juridico' },
            { label: 'Fisico', value: 'Fisico' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }

    get isSelectedJuridico() {
        return this.value === 'Juridico';
    }

    get isSelectedFisico() {
        return this.value === 'Fisico';
    }

    get isSelectedNone() {
        return this.value === '';
    }

 
    contactChangeVal(event) {
        console.log(event.target.label);
        console.log(event.target.value);
        if(event.target.label=='Nome'){
            this.firstName = event.target.value;
        }
        if(event.target.label=='Sobrenome'){
            this.lastName = event.target.value;
        }
        if(event.target.label=='Data de Nascimento'){
            this.bday = event.target.value;
        }
        if(event.target.label=='Email'){
            this.emailId = event.target.value;
        }
        if(event.target.label=='Departamento'){
            this.departmentVal = event.target.value;
        }
        if(event.target.label=='conAccountId'){
            this.conAccountId = event.target.value;
        }
        if(event.target.label=='Tipo de Contato'){
            this.value = event.target.value;
        }
        if(event.target.label=='CNPJ'){
            this.juridico = event.target.value;
        }
        if(event.target.label=='CPF'){
            this.fisico = event.target.value;
        }
    }
    
    // contactChangeVal(event) {
    //     console.log(event.target.label);
    //     console.log(event.target.value);
    //     const field = event.target.label;
    //     if (field) {
    //         this[field] = event.target.value;
    //     }
    // }
    
    insertContactAction() {
        console.log(this.selectedAccountId);
        const fields = {};
        fields[conFirstName.fieldApiName] = this.firstName;
        fields[conLastName.fieldApiName] = this.lastName;
        fields[conBday.fieldApiName] = this.bday;
        fields[conEmail.fieldApiName] = this.emailId;
        fields[conDepartment.fieldApiName] = this.departmentVal;
        fields[conAccountId.fieldApiName] = this.conAccountId;
        fields[conType.fieldApiName] = this.value;
    
        if (this.isSelectedJuridico) {
            fields[conCNPJ.fieldApiName] = this.juridico;
        } else if (this.isSelectedFisico) {
            fields[conCPF.fieldApiName] = this.fisico;
        }
    
        const recordInput = { apiName: conObject.objectApiName, fields };
        this.juridico = '';
        this.fisico = '';
        createRecord(recordInput)
            .then((contactobj) => {
                this.contactId = contactobj.id;
                this.lastInsertedContactId = this.contactId; // Armazena o ID do último registro inserido
                this.retrieveLastInsertedContact();

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact record has been created',
                        variant: 'success',
                    }),
                );
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
    // Método para buscar os detalhes do último registro inserido
    retrieveLastInsertedContact() {
        getRecord({ recordId: this.lastInsertedContactId, fields: Object.values(conObject.fields) })
            .then((record) => {
                console.log('Last Inserted Contact:', record);
            })
            .catch((error) => {
                console.error('Error retrieving last inserted contact details:', error);
            });
    }
}