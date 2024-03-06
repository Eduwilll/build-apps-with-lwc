/**
 * @description       : 
 * @author            : Eduardo Fabricio
 * @group             : 
 * @company           : Sottelli
 * @systemLayer       : 
 * @last modified on  : 06-03-2024
 * @last modified by  : Eduardo Fabricio
**/
public with sharing class avaliacaoController {

    public static AvaliacaoBuilder builder;

    static{
        builder = new AvaliacaoBuilder();
    }

    @AuraEnabled
    public static String getUserDetails() {
        return UserInfo.getName();
    }

    @AuraEnabled
    public static Avaliacao__c criarAvaliacao(String titulo, String descricao, Decimal nota, Id accountId) {
        Avaliacao__c novaAvaliacao = new Avaliacao__c(
            Name = titulo,
            Descricao__c = descricao,
            Nota__c = nota,
            Account__c = accountId
        );
    
        try {
            insert novaAvaliacao;
            return novaAvaliacao;
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