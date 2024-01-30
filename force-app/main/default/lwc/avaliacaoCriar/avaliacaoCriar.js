import { LightningElement, wire, api } from 'lwc';
import getAccounts from '@salesforce/apex/avaliacaoController.avaliacaoController';
import createAvaliacao from '@salesforce/apex/avaliacaoController.createAvaliacao';
import Avaliacao from '@salesforce/schema/Avaliacao__c'
import selectedAccountId from '@salesforce/schema/Avaliacao__c.Account__c'
import titulo from '@salesforce/schema/Avaliacao__c.Name'
import descricao from '@salesforce/schema/Avaliacao__c.Descricao__c'
import nota from '@salesforce/schema/Avaliacao__c.Nota__c'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AvaliacaoCriar extends LightningElement {

    titulo = '';
    descricao = '';
    nota = '';
    selectedAccountId = '';
    accountOptions  = [];
    @api recordId
    @wire(getAccounts)
    wiredAccount({ error, data}){
        if(data){
            this.accountOptions = data.map(option => ({
                label: option.accountName,
                value: option.accountId
            }));
        } else if (error) {
            console.error(error);
        }
    
    }

    handleChanged(event){
        this.selectedAccountId = event.detail.value;
        window.alert(JSON.stringify(this.selectedAccountId));
    }

    contactChangeVal(event) {
        const field = event.target.name;
        console.log(event.target.label);
        console.log(event.target.value);
        if (field) {
            this[field] = event.target.value;
        }
    }

    handleClick(){
        console.log('id:'+this.selectedAccountId);

        console.log('titulo: '+this.titulo);
        console.log('descricao: '+this.descricao);
        console.log('descricao: '+this.nota);
        
        // console.log('titulo.fieldApiName: '+titulo.fieldApiName); // Verify the field API name
        // console.log('descricao.fieldApiName: '+descricao.fieldApiName); // Verify the field API name
        // console.log('nota.fieldApiName: '+nota.fieldApiName); // Verify the field API name
        const fields = {};
        fields[titulo.fieldApiName] = this.titulo;
        fields[descricao.fieldApiName] = this.descricao;
        fields[nota.fieldApiName] = this.nota;
        fields[selectedAccountId.fieldApiName] = this.selectedAccountId;
        const recordInput = { apiName: Avaliacao.objectApiName, fields };
     
        
        createAvaliacao(recordInput)
        .then((Avaliacao) => {
                this.contactId = Avaliacao.id;

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact record has been created',
                        variant: 'success',
                    }),
                );
                console.log(JSON.stringify(Avaliacao));
                console.log("result", this.contactId)
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
    

}