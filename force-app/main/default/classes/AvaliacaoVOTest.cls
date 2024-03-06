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
        System.assertEquals('Test Avaliacao', testAvaliacaoVO.titulo,' Titulo não é igual');
        System.assertEquals('Test Description', testAvaliacaoVO.descricao,'descricao não é igual');
        System.assertEquals(4.5, testAvaliacaoVO.nota,'nota não é igual');
        System.assertEquals(acc.id, testAvaliacaoVO.accountId,'accountId não é igual');
        System.assertEquals(user.Name, testAvaliacaoVO.userName,'userName não é igual');
    }
}
