public class SurveyInvitationFlow {
    /** caldama: invoked from a flow when a we need an invitation for a given user of this org 
     * */
	
  @InvocableMethod(label='Get Survey Invitation' description='Return a list of invitations for the SurveyRequestData passed in the request' category='PagoNxt FM PoC')
  public static List<SurveyInvitation> getInviteURL(List<Survey_Request_Data> sdatalist) {

      
     List<SurveyInvitation> surveyInviteList = new List<SurveyInvitation>();
      for (Survey_Request_Data srd : sdatalist) {
          //ASUMO EXTERNAL_ID ÚNICO PARA SIMPLIFICAR
          User u =  [ SELECT ID, ContactID from User where ID = :srd.UserID ];
          Contact c  = [ SELECT ID, External_ID__c from Contact where contact.id = :u.ContactID ];
          
      	surveyInviteList.add(SurveyInvitationHelper.createSurveyInvitation(c.External_ID__c, srd.nombreEncuesta));    
      }

    return surveyInviteList; 
  }
    public class Survey_Request_Data{
        
        @InvocableVariable
        public String userID;

        @InvocableVariable
        public String nombreEncuesta;
        
    }
    
}