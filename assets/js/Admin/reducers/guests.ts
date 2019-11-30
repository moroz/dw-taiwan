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

export const initialParams = {
  term: "",
  page: 1,
  status: null
};

const initialState: IGuestReducerState = {
  entries: [],
  entry: null,
  cursor: null,
  loading: true,
  emailSending: false,
  params: initialParams
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

    case GuestActionType.SetTerm:
      return {
        ...state,
        params: {
          term: action.payload
        }
      };

    case GuestActionType.SetParams:
      const page = action.payload.page
        ? parseInt(action.payload.page)
        : parseInt(state && (state.params.page as any));
      return {
        ...state,
        loading: true,
        entries: [],
        params: {
          ...state.params,
          ...action.payload,
          page
        }
      };

    case GuestActionType.ResetParams:
      return {
        ...state,
        params: initialParams,
        loading: true,
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
