trigger CreateInvoiceFromOpportunity on Opportunity (after insert, after update) {
    List<Invoice__c> invoiceRecords = new List<Invoice__c>();

    for (Opportunity o : trigger.new) {
        if (o.isWon && !trigger.oldMap.get(o.Id).isWon) {
            Invoice__c newInvoice = new Invoice__c();
            newInvoice.Opportunity__c = o.id;
            newInvoice.Amount__c = o.Amount;
            newInvoice.Account__c = o.AccountId;
            newInvoice.Due_Date__c = o.CloseDate.addDays(30);

            System.debug('Invoice successfully created');
            invoiceRecords.add(newInvoice);
        }

    }

    if (!invoiceRecords.isEmpty()) {
        Database.insert(invoiceRecords, false);

    }

   /* set<Id> oppId = new Set<Id>();
    List<Invoice__c> invoiceRecords = new List<Invoice__c>();
    for (Opportunity o : trigger.new) {
        if ((o.StageName == 'Closed Won') && (Trigger.oldMap.get(o.Id).StageName != 'Closed Won')) {
            oppId.add(o.Id);
            Invoice__c newInvoice = new Invoice__c();
            newInvoice.Opportunity__c = o.id;
            newInvoice.Amount__c = o.Amount;
            newInvoice.Account__c = o.AccountId;
            newInvoice.Due_Date__c = o.CloseDate.addDays(30);
            System.debug('Invoice successfully created');
            invoiceRecords.add(newInvoice);
        }
    }

    insert invoiceRecords; */

}