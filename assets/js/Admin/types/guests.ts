import { id } from "./common";

export interface Guest {
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
