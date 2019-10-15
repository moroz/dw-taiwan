import { User, UserActionType, UserAction } from "../types/users";

interface IUserReducerState {
  user: User | null;
}

const initialState: IUserReducerState = {
  user: null
};

export default function(
  state: IUserReducerState = initialState,
  action: UserAction
) {
  switch (action.type) {
    case UserActionType.Fetch:
      return {
        ...state,
        user: action.payload
      };
    default:
      return state;
  }
}
