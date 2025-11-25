import * as admin from "firebase-admin";
import { acceptInvitation } from "./invitations/acceptInvitation";
import { removeMember } from "./members/removeMember";

// Initialize Firebase Admin SDK
admin.initializeApp();

// Export all Cloud Functions
export { acceptInvitation, removeMember };
