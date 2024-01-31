@isTest
public class TestDataFactory {

    public static Account criarContaDeTeste(String nome) {
        Account contaTeste = new Account(Name = nome);
        insert contaTeste;
        return contaTeste;
    }

    public static Avaliacao__c criarAvaliacaoDeTeste(String titulo, String descricao, Decimal nota, Id accountId) {
        Avaliacao__c avaliacaoTeste = new Avaliacao__c(
            Name = titulo,
            Descricao__c = descricao,
            Nota__c = nota,
            Account__c = accountId
        );
        insert avaliacaoTeste;
        return avaliacaoTeste;
    }

    public static User criarUsuarioDeTeste(String nome, String perfil) {
        // Implemente conforme necessário para criar um usuário de teste
        // Este método dependerá da estrutura do seu ambiente de desenvolvimento
        User usuarioTeste = new User(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'john.doe@example.com',
            ProfileId = [SELECT Id FROM Profile WHERE Name = :perfil LIMIT 1].Id
        );
        insert usuarioTeste;
        return usuarioTeste;
    }
}
