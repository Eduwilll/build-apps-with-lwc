@isTest
public class TestDataFactory {

    public static Account criarContaDeTeste(String nome) {
        Account contaTeste = new Account(Name = nome);
        insert contaTeste;
        return contaTeste;
    }

    public static User criarUsuarioDeTeste(String nome, String perfil) {
        // Implemente conforme necessário para criar um usuário de teste
        User usuarioTeste = new User(
            FirstName = 'teste',
            LastName = 'teste',
            Email = 'teste@example.com',
            ProfileId = [SELECT Id FROM Profile WHERE Name = :perfil LIMIT 1].Id
        );
        insert usuarioTeste;
        return usuarioTeste;
    }
}
