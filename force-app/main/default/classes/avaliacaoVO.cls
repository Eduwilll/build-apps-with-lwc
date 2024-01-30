public with sharing class avaliacaoVO {

    public avaliacaoVO(Avaliacao__c avaliacao){
        this.titulo = avaliacao.Name;
        this.descricao = avaliacao.Descricao__c;
        this.nota = avaliacao.Nota__c;
        this.accountId = avaliacao.Account__c;
        this.userName = avaliacao.CreatedBy.Name;
    }

    @AuraEnabled public String titulo {get; set;}
    @AuraEnabled public String descricao {get; set;}
    @AuraEnabled public Double nota {get; set;}
    @AuraEnabled public Id accountId {get; set;}
    @AuraEnabled public String userName {get; set;}

}