public with sharing class PostRecords {

  @AuraEnabled
    public static String getPostContent(String recordId) {
    Post__c post = [Select Content__c From Post__c Where id = :recordId LIMIT 1];

    return post.Content__c;
    }

  @AuraEnabled
  public static void autoSave(String recordId, String recordContent) {
    try{
      Post__c post= [Select Status__c From Post__c Where id = :recordId];

      post.Content__c = recordContent;
      update post;
    }
    catch(exception e){
      system.debug ('submitPost didn\'t complete, and the reason is: '+e);
    }
  }

  @AuraEnabled
  public static String[] manageSubmitPost(String recordId) {
    Post__c post = [Select Status__c From Post__c Where id = :recordId LIMIT 1];
    string[] status = new List<String>();
    String oldStatus = post.Status__c;
    String newStatus = oldStatus;

    if(oldStatus != 'Under Review' && oldStatus != 'Published'){
      setStatus(recordId, 'Under Review');
      newStatus = 'Under Review';
    }

    status.add(oldStatus);
    status.add(newStatus);

    return status;
  }

  @AuraEnabled
    public static String[] managePublishPost(String recordId) {
    Post__c post = [Select Status__c From Post__c Where id = :recordId LIMIT 1];
    string[] status = new List<String>();
    String oldStatus = post.Status__c;
    String newStatus = oldStatus;

    if(oldStatus == 'Ready'){
      setStatus(recordId, 'Published');
      newStatus = 'Published';
    }
    status.add(oldStatus);
    status.add(newStatus);

    return status;
    }

  private static void setStatus(String recordId, String value) {
    try{
      Post__c post= [Select Status__c From Post__c Where id = :recordId];
      post.Status__c = value;

      update post;
    }
    catch(exception e){
      system.debug ('submitPost didn\'t complete, and the reason is: '+e);
    }
  }
}