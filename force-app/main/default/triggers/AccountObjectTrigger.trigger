trigger AccountObjectTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
     // automation codes goes here 
     if(Trigger.isBefore){
        if (Trigger.isInsert) {
            //all the fields and validation before inserting a new recorde 
            AccountObjHandler.beforeInsert(Trigger.new);
        }
        if (Trigger.isUpdate) {
            //all the fields and validation before updating a new recorde
            AccountObjHandler.beforeUpdate();
        }
        if (Trigger.isDelete) {
            //all the fields and validation before deleting a new recorde
            AccountObjHandler.beforeDelete();
        }
     }

     if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            // all related operation while recored is getting created.
            AccountObjHandler.afterInsert();
        }
        if (Trigger.isUpdate) {
             // all related operation while recored is getting updated.
             AccountObjHandler.afterUpdate();
        }
        if (Trigger.isDelete) {
             // all related operation while recored is getting deleted.
             AccountObjHandler.afterUpdate();
        }
        if (Trigger.isUndelete) {
             // all related operation while recored is getting undeleted.
             AccountObjHandler.afterUndelete();
        }
     }
}