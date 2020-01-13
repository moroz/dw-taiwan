import { id } from "./common";

export interface User {
  id: id;
  displayName: string;
  email: string;
  avatarUrl: string | null;
  admin: boolean;
  human: boolean;
}

export enum UserActionType {
  Fetch = "FETCH_USER"
}

export interface UserAction {
  type: UserActionType;
  payload: User;
}
