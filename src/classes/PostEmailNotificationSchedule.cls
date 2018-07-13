global class PostEmailNotificationSchedule implements Schedulable {
      global void execute (SchedulableContext sch) {
        PostEmailNotificationBatch batch = new PostEmailNotificationBatch();
        Database.executeBatch(batch, 1);
      }
}
