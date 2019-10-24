import store from "../store";
import client from "../graphql/client";
import {
  GuestActionType,
  IGuestSearchParams,
  GuestStatus
} from "../types/guests";
import { id } from "../types/common";

const GUEST_DETAILS = `
fragment GuestDetails on Guest {
  id firstName lastName city residence nationality
  notes email referenceName referenceEmail sex
  status insertedAt
  audits {
    userName description timestamp
  }
}
`;

const SINGLE_GUEST_QUERY = `
${GUEST_DETAILS}
query guest($id: ID!) {
  guest(id: $id) { ...GuestDetails }
}`;

const CHANGE_GUEST_STATUS = `
${GUEST_DETAILS}
  mutation transitionGuestState($id: ID!, $toState: GuestStatus!) {
    transition(id: $id, toState: $toState) {
      success message
      guest { ...GuestDetails }
    }
  }
`;

const GUEST_LIST_QUERY = `
query guests($params: GuestSearchParams) {
  guests(params: $params) {
    entries {
      firstName lastName id
      residence nationality city
    }
    cursor {
      totalEntries totalPages page pageSize
    }
  }
}`;

export default class Guests {
  static async fetchGuests(params?: IGuestSearchParams) {
    try {
      const currentParams = store.getState().guests.params;
      const { guests } = await client.query(GUEST_LIST_QUERY, {
        params: { ...currentParams, ...params }
      });
      store.dispatch({
        type: GuestActionType.Fetch,
        payload: guests
      });
      const wrapper = document.getElementById("mainWrapper");
      wrapper && wrapper.scroll(0, 0);
    } catch (e) {
      console.error(e);
    }
  }

  static async transitionGuest(id: id, toState: GuestStatus) {
    try {
      const { transition } = await client.query(CHANGE_GUEST_STATUS, {
        id,
        toState
      });
      store.dispatch({
        type: transition.success
          ? GuestActionType.Mutation
          : GuestActionType.MutationFailed,
        payload: transition
      });
    } catch (e) {
      console.error(e);
    }
  }

  static async fetchGuest(id: id) {
    try {
      const { guest } = await client.query(SINGLE_GUEST_QUERY, { id });
      store.dispatch({
        type: GuestActionType.FetchOne,
        payload: guest
      });
    } catch (e) {
      console.error(e);
    }
  }
}
