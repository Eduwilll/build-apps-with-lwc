trigger AvaliacaoTrigger on Avaliacao__c (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete) {
            TriggerHandlerConta.handleAvaliacaoTrigger(Trigger.new, Trigger.oldMap);
        }
    }
}
