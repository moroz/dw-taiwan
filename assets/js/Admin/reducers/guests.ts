import { Guest, GuestAction, GuestActionType } from "../types/guests";
import { Cursor } from "../types/common";

interface IGuestReducerState {
  entries: Guest[];
  cursor: Cursor | null;
  loading: boolean;
  params: IGuestSearchParams;
}

interface IGuestSearchParams {
  name?: string;
  page?: number | string;
}

const initialState: IGuestReducerState = {
  entries: [],
  cursor: null,
  loading: true,
  params: {
    name: "",
    page: ""
  }
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
