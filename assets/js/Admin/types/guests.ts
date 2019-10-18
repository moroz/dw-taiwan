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
  id: id;
}

export enum GuestActionType {
  Fetch = "FETCH_GUESTS"
}

export type GuestAction = {
  type: GuestActionType;
  payload: any;
};

export interface IGuestSearchParams {
  name?: string;
  page?: number | string;
}
