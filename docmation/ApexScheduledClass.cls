global class ApexScheduledClass  implements Schedulable {
   global void execute(SchedulableContext sc) {
      Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
       string [] toaddress= New string[]{'meetmukul1993@gmail.com'};
       email.setSubject('Testing Apex Scheduler-Subject');
       email.setPlainTextBody('Testing Apex Scheduler-Body');
       email.setToAddresses(toaddress);
       Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
   }
}


======================
Schedule

ApexScheduledClass m = new ApexScheduledClass();

String sch = '0 0 4 * * ?'; 
String jobID = system.schedule('RunReport1', sch, m);
