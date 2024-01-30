import { LightningElement, api } from 'lwc';
import getRecords from '@salesforce/apex/avaliacaoController.getRecords';

const columns = [
    { label: 'Titulo', fieldName: 'titulo' },
    { label: 'Avaliador', fieldName: 'userName'},
    { label: 'Descrição', fieldName: 'descricao' },
    { label: 'Nota', fieldName: 'nota' },
  ];

export default class AvaliacaoLista extends LightningElement {
    dataListAva = [];
    @api recordId
    columns = columns;
    sortBy = 'CreatedDate';
    sortDirection = 'desc';

    connectedCallback(){
      console.log('RECORD ID FROM LIST:', this.recordId);
      this.retrieveRecordsAvaliacao();
    }

    @api
    refreshTable(){
      this.connectedCallback();
    }

    retrieveRecordsAvaliacao() {
      getRecords({ recordId: this.recordId })
          .then(result => {
              this.dataListAva = result;
          })
  }
  
    handleSortData(event) {
      this.sortBy = event.detail.fieldName;
      this.sortDirection = event.detail.sortDirection;
      console.log('getRecords:'+getRecords);

    }

    get getRecordsData() {
      return this.dataListAva.length!=0;
    }
}