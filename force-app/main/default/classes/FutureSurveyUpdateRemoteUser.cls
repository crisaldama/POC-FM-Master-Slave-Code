public class FutureSurveyUpdateRemoteUser {
	@future(callout=true) 
    public static void processSurveyCallout(String username, String externalID, String invitationURL, Boolean surveyable ) {
        String result; 
        
        HttpRequest feedRequest = new HttpRequest();
        feedRequest.setEndpoint('callout:POC_FM_GTS/services/apexrest/SurveyUpdateUserFields/');
        feedRequest.setMethod('POST');
        feedRequest.setHeader('Content-Type', 'application/json');
        feedRequest.setBody('{"externalID":"'+externalID +'","invitationURL":"' + invitationURL  +'","surveyable":"' + surveyable + '"}');
        Http http = new Http();
        HTTPResponse feedResponse = http.send(feedRequest);
        while (feedResponse.getStatusCode() == 302) {
                        feedRequest.setEndpoint(feedResponse.getHeader('Location'));
                        feedResponse = new Http().send(feedRequest);
                    }
        System.debug(feedResponse.getBody());
        // Parse JSON response to confirm OK.
        JSONParser parser = JSON.createParser(feedResponse.getBody());
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'result')) {
                // Get the value.
                parser.nextToken();
                // Compute the grand total price for all invoices.
                result = parser.getText();
            }
        }
        system.debug('result for username '+ username + ' is ' + result);
    }
}