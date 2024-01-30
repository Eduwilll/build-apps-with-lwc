try {
    // Perform any additional validation or processing here before inserting
    List<Contact> supervisors = new List<Contact>();
    List<Bear__c> bears = new List<Bear__c>();

    for (Integer i = 0; i < 10; i++) {
        Contact supervisor = new Contact(
            FirstName = 'Supervisor' + i,
            LastName = 'LastName' + i
            // Add other required Contact fields here
        );
        supervisors.add(supervisor);
    }

    // Insert the list of Contact records
    insert supervisors;

    // Use the created Contact records in Bear records
    for (Integer i = 0; i < 10; i++) {
        Bear__c bear = new Bear__c(
            Name = 'Bear' + i,
            Sex__c = 'Male',
            Height__c = 120,
            Weight__c = 150,
            Location__Latitude__s = 37.7749, // Replace with actual latitude
            Location__Longitude__s = -122.4194, // Replace with actual longitude
            Supervisor__c = supervisors[i].Id
        );
        bears.add(bear);
    }
    System.debug(bears);
    // Insert the list of Bear__c records
    insert bears;

    System.debug('Bears and Supervisors inserted successfully');
} catch (Exception e) {
    System.debug('Error inserting bears: ' + e.getMessage());
    // Handle the exception as needed (e.g., log the error, notify users, etc.)
}
