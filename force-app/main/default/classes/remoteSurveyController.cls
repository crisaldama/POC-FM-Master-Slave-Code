public with sharing class remoteSurveyController {
    @AuraEnabled(cacheable=true)
    public static String getInvitationURL(String externalID, String surveyName) {
        String invitationLink = null;
        HttpRequest feedRequest = new HttpRequest();
        feedRequest.setEndpoint('callout:Invitation_Master/services/apexrest/SurveyInvitationsPagoNxt/');
        feedRequest.setMethod('POST');
        feedRequest.setHeader('Content-Type', 'application/json');
        feedRequest.setBody('{"ExternalID":"'+externalID+'","Nombre_Encuesta":"' + surveyName + '"}');
        Http http = new Http();
        HTTPResponse feedResponse = http.send(feedRequest);
        while (feedResponse.getStatusCode() == 302) {
                        feedRequest.setEndpoint(feedResponse.getHeader('Location'));
                        feedResponse = new Http().send(feedRequest);
                    }
        System.debug(feedResponse.getBody());
        // Parse JSON response to get all the totalPrice field values.
        JSONParser parser = JSON.createParser(feedResponse.getBody());
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'invitationLink')) {
                // Get the value.
                parser.nextToken();
                // Compute the grand total price for all invoices.
                invitationLink = parser.getText();
            }
        }
        system.debug('invitationLink=' + invitationLink);
        return invitationLink;
    }
}