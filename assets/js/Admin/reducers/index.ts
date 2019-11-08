import { combineReducers } from "redux";
import user, { IUserReducerState } from "./user";
import guests, { IGuestReducerState } from "./guests";
import status, { IStatusReducerState } from "./status";

export interface IReduxState {
  guests: IGuestReducerState;
  user: IUserReducerState;
  status: IStatusReducerState;
}

export default combineReducers({ guests, user, status });
