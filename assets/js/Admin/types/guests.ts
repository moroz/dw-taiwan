import { id } from "./common";
import { Audit } from "./audits";
import { AdminNote } from "./notes";

export interface Guest {
  email: string;
  nationality: string;
  referenceName: string;
  referenceEmail: string;
  backupSent: boolean;
  registrationSent: boolean;
  confirmationSent: boolean;
  paymentSent: boolean;
  notes: string;
  firstName: string;
  lastName: string;
  residence: string;
  city: string;
  sex: Gender;
  status: GuestStatus;
  audits: Audit[];
  adminNotes: AdminNote[];
  insertedAt: string;
  id: id;
}

export enum GuestActionType {
  Loading = "LOADING",
  Fetch = "FETCH_GUESTS",
  FetchOne = "FETCH_SINGLE_GUEST",
  Mutation = "GUEST_MUTATION_SUCCESS",
  MutationFailed = "GUEST_MUTATION_FAILED",
  TriggerEmailSend = "GUEST_TRIGGER_EMAIL_SENDING",
  EmailSent = "GUEST_EMAIL_SENT",
  EmailFailed = "GUEST_EMAIL_SENDING_FAILED",
  SetParams = "CHANGE_GUEST_SEARCH_PARAMS"
}

export enum EmailType {
  Backup = "BACKUP",
  Registration = "REGISTRATION",
  Confirmation = "CONFIRMATION",
  Payment = "PAYMENT"
}

export enum Gender {
  Male = "MALE",
  Female = "FEMALE"
}

export enum GuestStatus {
  Unverified = "UNVERIFIED",
  Verified = "VERIFIED",
  Invited = "INVITED",
  Backup = "BACKUP",
  Canceled = "CANCELED",
  Paid = "PAID"
}

export type GuestAction = {
  type: GuestActionType;
  payload: any;
};

export interface IGuestSearchParams {
  term?: string;
  page?: number | string;
}
