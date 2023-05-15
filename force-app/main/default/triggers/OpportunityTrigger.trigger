trigger OpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            // Logic for after update trigger
            OpportunityTriggerHandler.createContract(Trigger.new , Trigger.oldMap);
        }
    }

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            // Logic for before insert trigger
            OpportunityTriggerHandler.mapTeamMemeber(Trigger.new);
            
        }
    }

    if (Trigger.isDelete) {
        // Logic for delete trigger
    }

    if (Trigger.isUpdate) {
        // Logic for before update trigger
    }
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            // Logic for after insert trigger
        }
    }
    
    if (Trigger.isAfter) {
        if (Trigger.isDelete) {
            // Logic for after delete trigger
        }
    }
    
    if (Trigger.isAfter) {
        if (Trigger.isUndelete) {
            // Logic for after undelete trigger
        }
    }

}
