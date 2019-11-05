import { Guest, GuestAction, GuestActionType } from "../types/guests";
import { Cursor } from "../types/common";

export interface IGuestReducerState {
  entries: Guest[];
  entry: Guest | null;
  cursor: Cursor | null;
  loading: boolean;
  params: IGuestSearchParams;
  emailSending: boolean;
  mutationSuccess: boolean;
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
  emailSending: false,
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
        mutationMsg: null,
        mutationSuccess: null,
        emailSending: false,
        ...action.payload
      };

    case GuestActionType.FetchOne:
      return {
        ...state,
        loading: false,
        mutationMsg: null,
        mutationSuccess: null,
        emailSending: false,
        entry: action.payload
      };

    case GuestActionType.Mutation:
    case GuestActionType.EmailSent:
      return {
        ...state,
        mutationSuccess: action.payload.success,
        mutationMsg: action.payload.message,
        emailSending: false,
        entry: action.payload.guest || state.entry
      };

    case GuestActionType.MutationFailed:
    case GuestActionType.EmailFailed:
      return {
        ...state,
        mutationSuccess: false,
        mutationMsg: action.payload.message,
        entry: action.payload.guest || state.entry,
        emailSending: false
      };

    case GuestActionType.TriggerEmailSend:
      return {
        ...state,
        emailSending: true
      };

    default:
      return state;
  }
}
