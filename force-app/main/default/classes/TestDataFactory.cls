/**
 * @description       : 
 * @author            : Eduardo Fabricio
 * @group             : 
 * @company           : Sottelli
 * @systemLayer       : 
 * @last modified on  : 06-03-2024
 * @last modified by  : Eduardo Fabricio
**/
@isTest
public class TestDataFactory {

    public static Account criarContaDeTeste(String nome) {
        Account contaTeste = new Account(Name = nome);
        return contaTeste;
    } 
    
    public static Avaliacao__c criarAvaliacaoDeTeste(String titulo, String descricao, Decimal nota, Id accountId) {
        Avaliacao__c avaliacaoTeste = new Avaliacao__c(
            Name = titulo,
            Descricao__c = descricao,
            Nota__c = nota,
            Account__c = accountId
        );
        return avaliacaoTeste;
    }

    public static User criarUsuarioDeTeste(String name) {
  
        return new User(
            ProfileId = [SELECT Id FROM Profile LIMIT 1].Id,
            LastName = name,
            Email = name + 'email@email.com',
            Username = name + 'email@email.com',
            CompanyName = name + 'company',
            Title = name + 'title',
            Alias = 'newAlias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
    }

    
}
