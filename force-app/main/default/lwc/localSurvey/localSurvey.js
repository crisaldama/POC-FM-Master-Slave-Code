import { LightningElement, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import NAME_FIELD from '@salesforce/schema/User.Name';
import EMAIL_FIELD from '@salesforce/schema/User.Email';
import INVITATION_URL_FIELD from '@salesforce/schema/User.Invitation_URL__c';
const fields = [NAME_FIELD, EMAIL_FIELD, INVITATION_URL_FIELD];

export default class localSurvey extends LightningElement {
    userId = Id;

    @wire(getRecord, { recordId: '$userId', fields })
    user;

    get name() {
        return getFieldValue(this.user.data, NAME_FIELD);
    }

    get email() {
        return getFieldValue(this.user.data, EMAIL_FIELD);
    }

    get invitationURL() {
        return getFieldValue(this.user.data, INVITATION_URL_FIELD);
    }
}
