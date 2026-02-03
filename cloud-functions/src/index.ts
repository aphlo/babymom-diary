import * as admin from "firebase-admin";
import { acceptInvitation } from "./invitations/acceptInvitation";
import { removeMember } from "./members/removeMember";
import { registerFcmToken } from "./notifications/registerFcmToken";
import { unregisterFcmToken } from "./notifications/unregisterFcmToken";
import { sendVaccineReminder } from "./notifications/sendVaccineReminder";

// Initialize Firebase Admin SDK
admin.initializeApp();

// Export all Cloud Functions
export {
  acceptInvitation,
  removeMember,
  registerFcmToken,
  unregisterFcmToken,
  sendVaccineReminder,
};
