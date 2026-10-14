import * as admin from "firebase-admin";
import { createHousehold } from "./households/createHousehold";
import { acceptInvitation } from "./invitations/acceptInvitation";
import { createInvitation } from "./invitations/createInvitation";
import { removeMember } from "./members/removeMember";
import { registerFcmToken } from "./notifications/registerFcmToken";
import { sendDailyEncouragement } from "./notifications/sendDailyEncouragement";
import { sendVaccineReminder } from "./notifications/sendVaccineReminder";
import { unregisterFcmToken } from "./notifications/unregisterFcmToken";
import { deleteAccount } from "./users/deleteAccount";

// Initialize Firebase Admin SDK
admin.initializeApp();

// Export all Cloud Functions
export {
  createHousehold,
  createInvitation,
  acceptInvitation,
  removeMember,
  registerFcmToken,
  sendDailyEncouragement,
  sendVaccineReminder,
  unregisterFcmToken,
  deleteAccount,
};
