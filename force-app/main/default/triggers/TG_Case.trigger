trigger TG_Case on Case (before insert, after insert, before update, after update) { 
    new TG_CaseHandler().run();
}