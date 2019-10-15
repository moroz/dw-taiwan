import { id } from "./common"

export interface User {
  id: id;
  displayName: string;
  email: string;
}

export enum UserActionType {
  Fetch = "FETCH_USER"
}

export interface UserAction {
  type: UserActionType,
  payload: User;
}
