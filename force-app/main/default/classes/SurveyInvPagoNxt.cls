@RestResource(urlMapping='/SurveyInvitationsPagoNxt/*')

global with sharing class SurveyInvPagoNxt {
    
    @HttpPost
    global static void createSurveyInvitation(String ExternalID, String Nombre_Encuesta) {
        
        SurveyInvitation result = SurveyInvitationHelper.createSurveyInvitation(ExternalID, Nombre_Encuesta);
            
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.responseBody = Blob.valueOf('{ "invitationLink" : "' + result.InvitationLink + '"}');
        //return result.InvitationLink;  



    }   
}