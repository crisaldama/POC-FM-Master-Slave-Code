public class SurveyUpdateUserFlow {
@InvocableMethod(label='Update USA Org USer' description='Updates a given users invitationURL and Surveyable field in the USA Org' category='PagoNxt FM PoC')
  public static void updateRemoteUsers(List<User> userList) {
      // This method will make the necessary callouts to update surveyable  and inivitationURL fields of a user with the same externalID in the remote org
      // It relies in an APEX class exposed as a web service in the remote ORG
      

      for (User u :userList) {
         FutureSurveyUpdateRemoteUser.processSurveyCallout(u.username, u.External_ID__c, u.Invitation_URL__c, u.USER_CHK_ShowSurvey_temp_c__c);
        
       }
  }
}