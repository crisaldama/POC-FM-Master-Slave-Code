@RestResource(urlMapping='/SurveyUpdateUserFields/*')
global with sharing class SurveyUpdateUserFields {
	@HttpPost
    global static void updateUserFields(String externalID, String invitationURL, boolean surveyable) {
        String result = 'error';
		// search for user with external ID passed as parameter. 
		User u = [ SELECT ID,Show_CSAT_Survey__c, Invitation_URL__c  from User where External_ID__c = :externalID LIMIT 1];
        
        
		// updates the obtained user with values surveyable and invitationURL
		u.Show_CSAT_Survey__c = surveyable;
        u.Invitation_URL__c = invitationURL;
        update(u);
        result = 'ok'; // KK de error checking 
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.responseBody = Blob.valueOf('{ "result" : "' + result +'"}');
        //return result.InvitationLink;  



    }   

}