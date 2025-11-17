import * as admin from "firebase-admin";
import { acceptInvitation } from "./invitations/acceptInvitation";
import { createInvitation } from "./invitations/createInvitation";

// Initialize Firebase Admin SDK
admin.initializeApp();

// Export all Cloud Functions
export { acceptInvitation, createInvitation };
