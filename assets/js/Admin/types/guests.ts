import { id } from "./common";

export interface Guest {
  email: string;
  nationality: string;
  referenceName: string;
  referenceEmail: string;
  notes: string;
  firstName: string;
  lastName: string;
  residence: string;
  city: string;
  sex: Gender;
  id: id;
}

export enum GuestActionType {
  Fetch = "FETCH_GUESTS"
}

export enum Gender {
  Male = "MALE",
  Female = "FEMALE"
}

export type GuestAction = {
  type: GuestActionType;
  payload: any;
};

export interface IGuestSearchParams {
  name?: string;
  page?: number | string;
}
