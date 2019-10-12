import { Guest, GuestAction, GuestActionType } from "../types/guests";
import { Cursor } from "../types/common";

interface IGuestReducerState {
  entries: Guest[];
  cursor: Cursor | null;
  loading: boolean;
}

const initialState: IGuestReducerState = {
  entries: [],
  cursor: null,
  loading: true
};

export default function(
  state: IGuestReducerState = initialState,
  action: GuestAction
) {
  switch (action.type) {
    case GuestActionType.Fetch:
      return {
        ...state,
        loading: false,
        ...action.payload
      };

    default:
      return state;
  }
}
