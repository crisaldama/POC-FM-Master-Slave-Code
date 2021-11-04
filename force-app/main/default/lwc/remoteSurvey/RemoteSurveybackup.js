import { LightningElement } from 'lwc';

export default class RemoteSurvey extends LightningElement {
    receivedToken;
    invitationURL='Auth failed';
    hasRendered = false;
    
    
    launchSurvey() {
        const calloutURI1 = 'https://poc-mango-2021-int-demo.my.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9cHH2bfKACZZR.Q4DYJs4pqOz0cy2vcz65rcNE2LH_vWej6A9h_jLZw9AdEBkR3lg3owCRku7aOJzlfAU&client_secret=6D25876022F8243BA91DE6CCC1058440898A3CBEA5F25528E15934CB47E80230&username=admin@poc-mango-2021-int.demo&password=Salesforce1';
        //const calloutURI2 = 'https://na162.salesforce.com/services/apexrest/SurveyInvitationsPagoNxt/';
        const calloutURI2 = 'https://poc-mango-2021-int-demo.my.salesforce.com/services/apexrest/SurveyInvitationsPagoNxt/';
        // requires whitelisting of calloutURI in CSP Trusted Sites
        console.log('entra');
        fetch(calloutURI1, {
            method: "POST",
            mode: 'no-cors',
            headers: {
                "Accept": "*/*"
              }
        }).then(
            (response) => {
                if (response.ok) {
                    console.log('entraRessponse');
                    return response.json();
                    
                } 
            }
        ).then(responseJSON => {
            console.log(responseJSON);
            this.receivedToken = responseJSON.access_token;
            console.log('entraResponseURI1');
            console.log(this.receivedToken);
        });
        


    }

    renderedCallback() {
        console.log('entraCallback');
        if(this.hasRendered == false) {
            this.launchSurvey();
            this.hasRendered = true;
        }
    }
}