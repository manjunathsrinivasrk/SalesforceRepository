trigger CaseTrigger on Case (before insert) {
    If(trigger.isBefore && trigger.isInsert)
    {
        KeyWordSearcher.checkSEKeywords(Trigger.New);
    }
}