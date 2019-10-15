import { id } from "./common";

export interface User {
  id: id;
  displayName: string;
  email: string;
  avatarUrl: string | null;
}

export enum UserActionType {
  Fetch = "FETCH_USER"
}

export interface UserAction {
  type: UserActionType;
  payload: User;
}
