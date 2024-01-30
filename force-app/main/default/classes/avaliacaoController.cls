public with sharing class avaliacaoController {
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

   // Método para criar avaliação
   @AuraEnabled
   public static Id criarAvaliacao(String titulo, String descricao, Double nota, Id accountId) {
       Avaliacao__c novaAvaliacao = new Avaliacao__c(
           Name = titulo,
           Descricao__c = descricao,
           Nota__c = nota,
           Account__c = accountId
       );
   
       try {
           insert novaAvaliacao;
           return novaAvaliacao.Id;
       } catch (Exception e) {
           // Lógica de tratamento de exceção
           throw new AuraHandledException('Erro ao criar a avaliação: ' + e.getMessage());
       }
   }

    @AuraEnabled
    public static List<avaliacaoVO> getRecords() {
        List<Avaliacao__c> listaAvaciacaoDAO= AvaliacaoDAO.getAll();
        System.debug('listaAvaciacaoDAO:'+listaAvaciacaoDAO);

        List<avaliacaoVO> listaAvalicaoVO = new List<avaliacaoVO>();


        for (Avaliacao__c a : listaAvaciacaoDAO) {
            avaliacaoVO listAva = new avaliacaoVO(a);
            listaAvalicaoVO.add(listAva);
        }
        System.debug('listaAvalicaoVO:'+listaAvalicaoVO);

        return listaAvalicaoVO;

    }
   
}