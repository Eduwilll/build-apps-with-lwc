public with sharing class AvaliacaoBuilder {
    
    public List<AvaliacaoVO> buildAvaliacaoVO(List<Avaliacao__c> avaliacoes){
        List<avaliacaoVO> avaliacoesVO = new List<avaliacaoVO>();
       for (Avaliacao__c a : avaliacoes) {
           avaliacaoVO listAva = new avaliacaoVO(a);
           avaliacoesVO.add(listAva);
       }
       return avaliacoesVO;
    }
    
}