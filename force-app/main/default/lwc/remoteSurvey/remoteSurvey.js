import { LightningElement, api } from 'lwc';
import getInvitationURL from '@salesforce/apex/remoteSurveyController.getInvitationURL';

export default class remoteSurvey extends LightningElement {
    @api surveyName;
    contactID = 'Contact.001';
    iframeWidth = '0';
    iframeheight = '0';
    iframeborder = '0';

    //@wire(getInvitationURL, { externalID: '$contactID' } )
    invitationURL;
    error;
    
    handleLoad() {
        console.log('In handleLoad)');
        getInvitationURL({ externalID: this.contactID, surveyName: this.surveyName})
            .then(result => {
                this.invitationURL = result;
                this.iframeWidth = '1200';
                this.iframeheight = '600';
                this.iframeborder = '1';
                //window.open(result);
            })
            .catch(error => {
                this.error = error;
            });
            
    }
}