import { Guest, GuestAction, GuestActionType } from "../types/guests";
import { Cursor } from "../types/common";

interface IGuestReducerState {
  entries: Guest[];
  cursor: Cursor | null;
}

const initialState: IGuestReducerState = {
  entries: [],
  cursor: null
};

export default function(
  state: IGuestReducerState = initialState,
  action: GuestAction
) {
  switch (action.type) {
    case GuestActionType.Fetch:
      return {
        ...state,
        entries: action.payload
      };

    default:
      return state;
  }
}
