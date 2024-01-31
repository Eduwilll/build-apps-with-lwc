public with sharing class avaliacaoController {

    public static AvaliacaoBuilder builder;

    static{
        builder = new AvaliacaoBuilder();
    }

    @AuraEnabled(cacheable=true scope='global')
    public static List<AccountOption> avaliacaoController() {
        List<AccountOption> options = new List<AccountOption>();
        for (Account acc : [SELECT Id, Name FROM Account]) {
            options.add(new AccountOption(acc.Id, acc.Name));
        }

        return options;
        
    }
    public class AccountOption {
        @AuraEnabled
        public String accountId { get; set; }
        @AuraEnabled
        public String accountName { get; set; }

        public AccountOption(String id, String name) {
            accountId = id;
            accountName = name;
        }
    }

    /******************************************************************/

    @AuraEnabled
    public static User getUserDetails(String userId) {
        return [SELECT Name, UserRole.Name, Profile.Name, Manager.Name FROM User WHERE Id = :userId LIMIT 1];

    }

    @AuraEnabled
    public static Id criarAvaliacao(String titulo, String descricao, Decimal nota, Id accountId) {
        Avaliacao__c novaAvaliacao = new Avaliacao__c(
            Name = titulo,
            Descricao__c = descricao,
            Nota__c = nota,
            Account__c = accountId
        );
    
        try {
            insert novaAvaliacao;
            return novaAvaliacao.Id;
        } catch (DmlException e) {
            // Lógica de tratamento de exceção
            throw new AuraHandledException('Erro ao criar a avaliação: ' + e.getMessage());
        }
    }

   @AuraEnabled
   public static List<avaliacaoVO> getRecords(Id recordId) {
       List<Avaliacao__c> avaliacoes = AvaliacaoDAO.getByAccountId(recordId);

       return builder.buildAvaliacaoVO(avaliacoes);
   }
   
   
}