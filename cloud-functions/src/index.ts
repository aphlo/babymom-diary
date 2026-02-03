import * as admin from "firebase-admin";
import { acceptInvitation } from "./invitations/acceptInvitation";
import { removeMember } from "./members/removeMember";
import { registerFcmToken } from "./notifications/registerFcmToken";
import { sendDailyEncouragement } from "./notifications/sendDailyEncouragement";
import { sendVaccineReminder } from "./notifications/sendVaccineReminder";
import { unregisterFcmToken } from "./notifications/unregisterFcmToken";

// Initialize Firebase Admin SDK
admin.initializeApp();

// Export all Cloud Functions
export {
  acceptInvitation,
  removeMember,
  registerFcmToken,
  sendDailyEncouragement,
  sendVaccineReminder,
  unregisterFcmToken,
};
