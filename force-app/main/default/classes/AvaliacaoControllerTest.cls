/**
 * @description       : 
 * @author            : Eduardo Fabricio
 * @group             : 
 * @last modified on  : 07-03-2024
 * @last modified by  : Eduardo Fabricio
**/
@isTest
public class AvaliacaoControllerTest {

    @TestSetup
    static void makeData(){
        User usuarioTeste = TestDataFactory.criarUsuarioDeTeste('Jonas');
        System.debug(usuarioTeste);
        insert usuarioTeste;
    }
    @isTest
    public static void testCriarAvaliacao() {
        Account contaTeste = TestDataFactory.criarContaDeTeste('Conta de Teste');
        insert contaTeste;
        Test.startTest();
        // Chamar o método criarAvaliacao usando a TestDataFactory
        AvaliacaoController.criarAvaliacao('Título Teste', 'Descrição Teste', 4.5, contaTeste.Id);
        Test.stopTest();

        // Verificar se a avaliação foi criada
        List<Avaliacao__c> avaliacoes = [SELECT Id FROM Avaliacao__c WHERE Name = 'Título Teste' LIMIT 1];
        Assert.areEqual(1, avaliacoes.size(), 'A avaliação não foi criada corretamente');

    }
    
    @isTest
    public static void testCriarAvaliacaoExeption() {
        Account contaTeste = TestDataFactory.criarContaDeTeste('Conta de Teste');
        Exception exp;

        Test.startTest();
        try {
            // Chamar o método criarAvaliacao usando a TestDataFactory
            AvaliacaoController.criarAvaliacao('Título Teste', 'Descrição Teste', 10, contaTeste.Id);
        } catch (Exception ex) {
            exp = ex;
        }

        Test.stopTest();

        // Verificar se a avaliação foi criada
        //List<Avaliacao__c> avaliacoes = [SELECT Id FROM Avaliacao__c WHERE Name = 'Título Teste' LIMIT 1];
        Assert.isTrue(exp != null);

    }

    @isTest
    public static void testGetRecords() {
        Account contaTeste = TestDataFactory.criarContaDeTeste('Conta de Teste');
        insert contaTeste;
        Avaliacao__c avaliacaoTeste = TestDataFactory.criarAvaliacaoDeTeste('Título Teste', 'Descrição Teste', 4.5, contaTeste.Id);
        insert avaliacaoTeste;
        // Chamar o método getRecords usando a TestDataFactory
        List<AvaliacaoVO> resultados = AvaliacaoController.getRecords(contaTeste.Id);

        // Verificar se a avaliação é retornada corretamente
        Assert.areEqual(1, resultados.size(), 'A lista de avaliações não está correta');
        Assert.areEqual('Título Teste', resultados[0].titulo, 'O título da avaliação não está correto');
    }

    @isTest
    public static void testGetUserDetails() {
        // Criar um usuário de teste
        User userQuery = [SELECT Name FROM User WHERE LastName = 'Jonas' LIMIT 1];
        // Chamar o método getUserDetails usando a TestDataFactory
        String detalhesUsuario = ''; 
        System.runAs(userQuery ){
            detalhesUsuario = AvaliacaoController.getUserDetails();
        }
        System.debug(detalhesUsuario);
        // Verificar se os detalhes do usuário são retornados corretamente
        Assert.areEqual(userQuery.Name, detalhesUsuario, 'o usuário name é diferente');
    }
}
