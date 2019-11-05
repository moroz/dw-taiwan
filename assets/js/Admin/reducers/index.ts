import { combineReducers } from "redux";
import user, { IUserReducerState } from "./user";
import guests, { IGuestReducerState } from "./guests";

export interface IReduxState {
  guests: IGuestReducerState;
  user: IUserReducerState;
}

export default combineReducers({ guests, user });
