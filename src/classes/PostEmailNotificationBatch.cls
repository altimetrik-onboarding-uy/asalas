global class PostEmailNotificationBatch implements Database.Batchable<SObject>, Database.Stateful{

  global Map<String, String> postMap = new Map<String, String>();

  global Database.QueryLocator start(Database.BatchableContext BC){
    String query = 'Select Id, Name, Status__c,  Writer__c , CreatedById, '+
                   'CreatedBy.Manager.Email '+
                   'FROM Post__C WHERE Status__c = \'Under Review\'';

    return Database.getQueryLocator(query);
  }

  global void execute(Database.BatchableContext BC, List<Post__c> scope){
    String auxMessage = '';

    for(Post__c p : scope)
    {
      if (postMap.containsKey(p.CreatedBy.Manager.Email)){
        auxMessage = this.emailStructure(p, postMap.get(p.CreatedBy.Manager.Email));
        postMap.put(p.CreatedBy.Manager.Email,auxMessage);
      }
      else{
        auxMessage = this.emailStructure(p, null);
        postMap.put(p.CreatedBy.Manager.Email, auxMessage);
      }
    }
  }

  global void finish(Database.BatchableContext BC){
    Set <String> postSet = new Set<String>();
    postSet = postMap.keySet();

    if (postSet.isEmpty()){
      System.debug('There is no new email to send');
    }
    else{
      for (String postEmail : postSet) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {postEmail});
        mail.setSubject('This is your daily \'Under Review\' Post List to check');
        mail.setPlainTextBody(postMap.get(postEmail));
        mail.setHtmlBody(postMap.get(postEmail));
        try{
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
          System.debug('The email to '+postEmail+' was sent successfully.');
        }catch (Exception e){
          System.debug('There was an error while sending the emails: ' + e.getMessage());
        }
      }
    }
  }

  private String emailStructure (Post__c post, String content){
    String newContent ='';
    String postURL = '';

    // new Email
    if (String.isEmpty(content)){
      content ='The list below contains all the Post to be reviewed by you, please check it whenever you have the time to do it: <br /><hr><br />';
    }

    //List Structure Definition
    if (!String.isEmpty(post.Id)){
      postURL = Url.getSalesforceBaseURL().toExternalForm()+'/lightning/r/Post__c/'+post.Id+'/view';
      newContent = newContent+'ID: '+post.Id+'<br />';
      postURL = 'Link of the Post: '+postURL;
    }
    if (!String.isEmpty(post.Name)){
      newContent = newContent+'Post Name: '+post.Name+'<br />';
    }
    if (!String.isEmpty(post.CreatedById)){
      newContent = newContent+'Created By: '+post.CreatedById+'<br />';
    }
    newContent = newContent+postURL+'<br />=====<br /><br />';

    return content+newContent;
  }
}
