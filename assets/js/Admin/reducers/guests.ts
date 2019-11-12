import {
  Guest,
  GuestAction,
  GuestActionType,
  GuestStatus
} from "../types/guests";
import { Cursor } from "../types/common";

export interface IGuestReducerState {
  entries: Guest[];
  entry: Guest | null;
  cursor: Cursor | null;
  loading: boolean;
  emailSending: boolean;
  params: SearchParams;
}

export interface SearchParams {
  term?: string;
  page?: number;
  status?: GuestStatus | null;
}

const initialState: IGuestReducerState = {
  entries: [],
  entry: null,
  cursor: null,
  loading: true,
  emailSending: false,
  params: { term: "" }
};

export default function(
  state: IGuestReducerState = initialState,
  action: GuestAction
) {
  switch (action.type) {
    case GuestActionType.Loading:
      return {
        ...state,
        loading: true
      };

    case GuestActionType.Fetch:
      return {
        ...state,
        loading: false,
        entry: null,
        emailSending: false,
        ...action.payload
      };

    case GuestActionType.SetParams:
      return {
        ...state,
        params: action.payload,
        loading: true,
        entries: []
      };

    case GuestActionType.ResetParams:
      return {
        ...state,
        params: initialState.params,
        entries: []
      };

    case GuestActionType.FetchOne:
      return {
        ...state,
        loading: false,
        emailSending: false,
        entry: action.payload,
        entries: []
      };

    case GuestActionType.Mutation:
    case GuestActionType.EmailSent:
      return {
        ...state,
        emailSending: false,
        entry: action.payload.guest || state.entry
      };

    case GuestActionType.MutationFailed:
    case GuestActionType.EmailFailed:
      return {
        ...state,
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
