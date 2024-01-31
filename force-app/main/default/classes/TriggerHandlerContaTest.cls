/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TriggerHandlerContaTest {

    @isTest static void testHandleAvaliacaoTrigger() {
        // criar account
        Account acc1 = TestDataFactory.criarContaDeTeste('Teste Account');


        // Create 3 avaliacoes for acc1 and 2 avaliacoes for acc2
        Avaliacao__c av1 = new Avaliacao__c(Account__c = acc1.Id, Nota__c = 5);
        Avaliacao__c av2 = new Avaliacao__c(Account__c = acc1.Id, Nota__c = 3);
      
        // Trigger the handleAvaliacaoTrigger method
        TriggerHandlerConta.handleAvaliacaoTrigger(new List<Avaliacao__c>{av1,av2}, new Map<Id, Avaliacao__c>());

        // Verify the account records were updated correctly
        Account acc1Updated = [SELECT Nota_da_Conta__c FROM Account WHERE Id = :acc1.Id];


        System.assertEquals(4, acc1Updated.Nota_da_Conta__c);
 
    }
        

}