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
public with sharing class AvaliacaoBuilderTest {
    
    @isTest
    static void testAvaliacaoBuilder(){
        Account acc = TestDataFactory.criarContaDeTeste('Account Test');
        insert acc;
        
        // Criar avaliacoes relacionadas às contas criadas
        Avaliacao__c avaliacao1 = AvaliacaoController.criarAvaliacao('Avaliacao 1', 'Description 1', 4.0, acc.Id);
        Avaliacao__c avaliacao2 = AvaliacaoController.criarAvaliacao('Avaliacao 2', 'Description 2', 3.5, acc.Id);
        
        Avaliacao__c[] avas = new List<Avaliacao__c>{avaliacao1, avaliacao2};
        
        
     
        AvaliacaoBuilder builder = new AvaliacaoBuilder();
        List<AvaliacaoVO> avaBuilderList = builder.buildAvaliacaoVO(avas);
        
        
        System.assertEquals(2, avaBuilderList.size(), 'Size is not as expected');
        System.assertEquals('Avaliacao 1', avaBuilderList[0].titulo, 'Avaliacao 1 titulo não é igual');
        System.assertEquals('Avaliacao 2', avaBuilderList[1].titulo, 'Avaliacao 2 titulo não é igual');
    }
}
