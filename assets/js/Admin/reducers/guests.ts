import { Guest, GuestAction, GuestActionType } from "../types/guests";
import { Cursor } from "../types/common";

interface IGuestReducerState {
  entries: Guest[];
  entry: Guest | null;
  cursor: Cursor | null;
  loading: boolean;
  params: IGuestSearchParams;
  mutationSuccess: boolean | null;
  mutationMsg: string | null;
}

interface IGuestSearchParams {
  name?: string;
  page?: number | string;
}

const initialState: IGuestReducerState = {
  entries: [],
  entry: null,
  cursor: null,
  loading: true,
  mutationMsg: null,
  mutationSuccess: null,
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
        entry: null,
        ...action.payload
      };

    case GuestActionType.FetchOne:
      return {
        ...state,
        loading: false,
        entry: action.payload
      };

    case GuestActionType.Mutation:
      return {
        ...state,
        mutationSuccess: action.payload.success,
        mutationMsg: action.payload.message,
        entry: action.payload.guest || state.entry
      };

    case GuestActionType.MutationFailed:
      return {
        ...state,
        mutationSuccess: false,
        mutationMsg: action.payload.message,
        entry: action.payload.guest || state.entry
      };

    default:
      return state;
  }
}
