@isTest
public class AvaliacaoControllerTest {

    @isTest
    public static void testCriarAvaliacao() {
        Account contaTeste = TestDataFactory.criarContaDeTeste('Conta de Teste');

        Test.startTest();
        // Chamar o método criarAvaliacao usando a TestDataFactory
        AvaliacaoController.criarAvaliacao('Título Teste', 'Descrição Teste', 4.5, contaTeste.Id);
        Test.stopTest();

        // Verificar se a avaliação foi criada
        List<Avaliacao__c> avaliacoes = [SELECT Id FROM Avaliacao__c WHERE Name = 'Título Teste' LIMIT 1];
        System.assertEquals(1, avaliacoes.size(), 'A avaliação não foi criada corretamente');
    }

    @isTest
    public static void testGetRecords() {
        Account contaTeste = TestDataFactory.criarContaDeTeste('Conta de Teste');
        Avaliacao__c avaliacaoTeste = TestDataFactory.criarAvaliacaoDeTeste('Título Teste', 'Descrição Teste', 4.5, contaTeste.Id);

        // Chamar o método getRecords usando a TestDataFactory
        List<AvaliacaoVO> resultados = AvaliacaoController.getRecords(contaTeste.Id);

        // Verificar se a avaliação é retornada corretamente
        System.assertEquals(1, resultados.size(), 'A lista de avaliações não está correta');
        System.assertEquals('Título Teste', resultados[0].titulo, 'O título da avaliação não está correto');
    }

    @isTest
    public static void testGetUserDetails() {
        // Criar um usuário de teste
        User usuarioTeste = TestDataFactory.criarUsuarioDeTeste('Nome Teste', 'Perfil de Teste');

        // Chamar o método getUserDetails usando a TestDataFactory
        User detalhesUsuario = AvaliacaoController.getUserDetails(usuarioTeste.Id);

        // Verificar se os detalhes do usuário são retornados corretamente
        System.assertEquals('Nome Teste', detalhesUsuario.Name, 'O nome do usuário não está correto');
        System.assertEquals('Perfil de Teste', detalhesUsuario.Profile.Name, 'O perfil do usuário não está correto');
    }
}
