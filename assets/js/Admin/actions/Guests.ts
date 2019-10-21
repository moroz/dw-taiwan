import store from "../store";
import client from "../graphql/client";
import { GuestActionType, IGuestSearchParams } from "../types/guests";
import { id } from "../types/common";

const SINGLE_GUEST_QUERY = `
query guest($id: ID!) {
  guest(id: $id) {
    id firstName lastName city residence nationality
    notes email referenceName referenceEmail sex
    status insertedAt
    audits {
      userName description timestamp
    }
  }
}`;

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

  static async fetchGuest(id: id) {
    try {
      return client.query(SINGLE_GUEST_QUERY, { id });
    } catch (e) {
      console.error(e);
    }
  }
}
