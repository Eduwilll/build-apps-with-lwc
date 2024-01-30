public with sharing class AccountControl {
    @AuraEnabled(cacheable=true)
    public static List<AccountOption> getAccountOptions() {
        List<AccountOption> options = new List<AccountOption>();

        for (Account acc : [SELECT Id, Name FROM Account]) {
            options.add(new AccountOption(acc.Id, acc.Name));
        }

        return options;
    }

    @AuraEnabled
    public static Id createContact(String firstName, String lastName, String email, String accountId) {
        Contact newContact = new Contact(
            FirstName = firstName,
            LastName = lastName,
            Email = email,
            AccountId = accountId 
        );

        insert newContact;

        return newContact.Id;
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
}