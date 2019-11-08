import { Guest, GuestAction, GuestActionType } from "../types/guests";
export interface IStatusReducerState {
  success: boolean;
  message: string | null;
}

const initialState: IStatusReducerState = {
  success: true,
  message: null
};

export default function(
  state: IStatusReducerState = initialState,
  action: any
) {
  switch (action.type) {
    case GuestActionType.MutationFailed:
    case GuestActionType.EmailFailed:
      return { ...state, success: false, message: action.payload.message };
    default:
      return state;
  }
}
