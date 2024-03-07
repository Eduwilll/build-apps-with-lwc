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
private class AvaliacaoVOTest {

    @isTest
    static void testAvaliacaoVO() {

        Account acc = TestDataFactory.criarContaDeTeste('Account Test');
        User user = TestDataFactory.criarUsuarioDeTeste('Eduardo');
        insert acc;
        insert  user;
        // Create a test record for Avaliacao__c
        Avaliacao__c testAvaliacao = new Avaliacao__c(
            Name = 'Test Avaliacao',
            Descricao__c = 'Test Description',
            Nota__c = 4.5,
            Account__c = acc.id
        );
        insert testAvaliacao;

        // Instantiate avaliacaoVO using the test record
        avaliacaoVO testAvaliacaoVO = new avaliacaoVO(testAvaliacao);

        // Verify that the values are set correctly
        Assert.areEqual('Test Avaliacao', testAvaliacaoVO.titulo,' Titulo não é igual');
        Assert.areEqual('Test Description', testAvaliacaoVO.descricao,'descricao não é igual');
        Assert.areEqual(4.5, testAvaliacaoVO.nota,'nota não é igual');
        Assert.areEqual(acc.id, testAvaliacaoVO.accountId,'accountId não é igual');
        Assert.areEqual(user.Name, testAvaliacaoVO.userName,'userName não é igual');
    }
}
