import { LightningElement, api } from 'lwc';
import getUserDetails from '@salesforce/apex/avaliacaoController.getUserDetails';
import criarAvaliacao from '@salesforce/apex/avaliacaoController.criarAvaliacao';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Id from '@salesforce/user/Id'; 


export default class AvaliacaoNota extends LightningElement {
    userId = Id;
    userName;
    userRoleName;
    userProfileName;
    userManagerName;
    @api recordId;
    titulo;
    nota=0;
    descricao;
    value = '';
    
    get options() {
        return [
            {label: '1', value: '1'},
            {label: '2', value: '2'},
            {label: '3', value: '3'},
            {label: '4', value: '4'},
            {label: '5', value: '5'}
        ]
    }

    connectedCallback() {
        this.retrieveUserDetails();
        console.log('Record ID:', this.recordId);

    }

    retrieveUserDetails() {
   
        getUserDetails({ userId: this.userId })
            .then(result => {
                this.userName = result.Name;
                this.userRoleName = result.UserRole ? result.UserRole.Name : null;
                this.userProfileName = result.Profile ? result.Profile.Name : null;
                this.userManagerName = result.Manager ? result.Manager.Name : null;
            })
            .catch(error => {
                console.error('Error fetching user details:', error);
            });
    }
    
    // get value
    contactChangeVal(event) {
        console.log(event.target.name);
        console.log(event.target.value);
        const field = event.target.name;
        if (field) {
            this[field] = event.target.value;
        }
    }

    async handleClick() {
        try {
            const result = await criarAvaliacao({
                titulo: this.titulo,
                descricao: this.descricao,
                nota: this.nota,
                accountId: this.recordId
            });

            if (result) {
                const childComponent = this.template.querySelector('c-avaliacao-lista');
                if (childComponent) {
                    childComponent.refreshTable();
                }
            }
            // Limpar os campos após o sucesso
            this.titulo = '';
            this.descricao = '';
            this.nota = 0;
    
            // Exibir uma mensagem de sucesso
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Sucesso',
                    message: 'Avaliação criada com sucesso!',
                    variant: 'success'
                })
            );
        } catch (error) {
            console.error(error);
            // Extrair a mensagem de erro da exceção
            let errorMessage = 'Ocorreu um erro ao criar a avaliação.';
            if (error.body && error.body.message) {
                errorMessage = error.body.message;
            }
            // Exibir uma mensagem de erro
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Erro',
                    message: 'Ocorreu um erro ao criar a avaliação.'+errorMessage,
                    variant: 'error'
                })
            );
            
        }
        
    }
    
}