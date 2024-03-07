/**
 * @description       : 
 * @author            : Eduardo Fabricio
 * @group             : 
 * @company           : Sottelli
 * @systemLayer       : 
 * @last modified on  : 07-03-2024
 * @last modified by  : Eduardo Fabricio
**/
@isTest
public with sharing class AvaliacaoDAOTest {
    @isTest
    static void testGetByAccountId() {

        User user = TestDataFactory.criarUsuarioDeTeste('Eduardo');
        // Criar Account test
        Account testAccount = TestDataFactory.criarContaDeTeste('Test Account 2');
        insert testAccount;

        // Criar avaliacaoes ralacionado as contas criadas
        Avaliacao__c avaliacao1 = AvaliacaoController.criarAvaliacao('Avaliacao 1', 'Description 1', 4.0, testAccount.Id);
        Avaliacao__c avaliacao2 = AvaliacaoController.criarAvaliacao('Avaliacao 2', 'Description 2', 3.5, testAccount.Id);

        // Chamando AvaliacaoDAO.getByAccountId method
        List<Avaliacao__c> resultAvaliacoes = AvaliacaoDAO.getByAccountId(testAccount.Id);

        // Verificar o resultado
        Assert.areEqual(2, resultAvaliacoes.size());
        Assert.areEqual('Avaliacao 1', resultAvaliacoes[0].Name,'Avaliacao 1 não é igual');
        Assert.areEqual('Avaliacao 2', resultAvaliacoes[1].Name,'Avaliacao 2 não é igual');
    }
}