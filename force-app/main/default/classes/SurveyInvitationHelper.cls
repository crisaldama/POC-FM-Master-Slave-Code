public class SurveyInvitationHelper {
	  public static SurveyInvitation createSurveyInvitation(String ExternalID, String Nombre_Encuesta) {
        
        Contact myContact = [SELECT Id, Name
                        FROM Contact
                        WHERE External_ID__c = :ExternalID];
        Id communityId = [select Id from Network where Name = 'Consumer Community'].Id;
        Survey Surveyrec = [Select Id from Survey where Name = :Nombre_Encuesta];
        
            
        SurveyInvitation SInv = New SurveyInvitation();
    	Sinv.CommunityId = communityId;
        SInv.Name = ExternalID + '- TestingPagoNxt';
   		SInv.SurveyId=Surveyrec.Id;
        SInv.OptionsCollectAnonymousResponse = false;
   		SInv.OptionsAllowGuestUserResponse = true;
        SInv.ParticipantId = myContact.Id;
        insert SInv;
            
        Survey_Request__c SReq = new Survey_Request__c();
        SReq.Contact__c = myContact.Id;
        SReq.External_ID__c = ExternalID;
        SReq.Survey_Invitation__c = SInv.Id;
        insert SReq;
            
        SurveySubject SS = new SurveySubject();
        SS.SubjectId  = SReq.Id;
   		SS.ParentId = SInv.Id;
   		SS.Name = ExternalID;
        insert SS;
            
        SurveySubject SS2 = new SurveySubject();
        SS2.SubjectId  = myContact.Id;
        SS2.ParentId = SInv.Id;
   		SS2.Name = ExternalID;
        insert SS2;

        SurveyInvitation result =  [SELECT InvitationLink
                                    FROM SurveyInvitation
                                    WHERE Id = :SInv.Id];  
            
        
        return result;  



    }   
}