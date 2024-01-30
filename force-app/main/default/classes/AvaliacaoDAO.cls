public with sharing class AvaliacaoDAO {
    public static List<Avaliacao__c> getByAccountId(Id accountId) {
        return [SELECT Id, Name, Account__c, CreatedBy.Name, Descricao__c, Nota__c, CreatedDate FROM Avaliacao__c WHERE Account__c = :accountId];
    }
    // public static List<Avaliacao__c> getAll() {
    //     return [SELECT Id, Name, Account__c, CreatedBy.Name, Descricao__c, Nota__c, CreatedDate FROM Avaliacao__c ];
    // }
}
