import { combineReducers } from "redux";
import user from "./user";
import guests from "./guests";

export default combineReducers({ guests, user });
