/**
 * @description       : 
 * @author            : Eduardo Fabricio
 * @group             : 
 * @company           : Sottelli
 * @systemLayer       : 
 * @last modified on  : 28-02-2024
 * @last modified by  : Eduardo Fabricio
**/
public with sharing class TriggerHandlerConta {
  
    public static void handleAvaliacaoTrigger(List<Avaliacao__c> newAvaliacoes, Map<Id, Avaliacao__c> oldAvaliacoesMap) {
        Map<Id, List<Avaliacao__c>> contaAvaliacoesMap = new Map<Id, List<Avaliacao__c>>();
        List<Account> contasToUpdate = new List<Account>();

        // Agrupar as avaliações por conta
        for (Avaliacao__c avaliacao : newAvaliacoes) {
            if (avaliacao.Account__c != null) {
                if (!contaAvaliacoesMap.containsKey(avaliacao.Account__c)) {
                    contaAvaliacoesMap.put(avaliacao.Account__c, new List<Avaliacao__c>());
                }
                contaAvaliacoesMap.get(avaliacao.Account__c).add(avaliacao);
            }
            System.debug(contaAvaliacoesMap);
        }

         // Calcular a média e atualizar as contas
        for (Id contaId : contaAvaliacoesMap.keySet()) {
            System.debug('contaAvaliacoesMap.keySet():'+contaAvaliacoesMap.keySet());
            List<Avaliacao__c> avaliacoes = contaAvaliacoesMap.get(contaId);
            Decimal media = 0;
            System.debug('avaliacoes:'+avaliacoes);
            for (Avaliacao__c avaliacao : avaliacoes) {
                media += avaliacao.Nota__c;
            }

            media = (avaliacoes.size() > 0) ? media / avaliacoes.size() : 0;
            
            System.debug('média:'+media);
            
            contasToUpdate.add(new Account(
                Id = contaId,
                Nota_da_Conta__c = media
            ));
        }

        // Atualizar as contas
        if (!contasToUpdate.isEmpty()) {
            update contasToUpdate;
        }
    }
}