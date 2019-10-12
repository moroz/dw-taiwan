import store from "../store";
import client from "../graphql/client";
import { GuestActionType, IGuestSearchParams } from "../types/guests";

export default class Guests {
  static async fetchGuests(params?: IGuestSearchParams) {
    try {
      const currentParams = store.getState().guests.params;
      const { guests } = await client.query(
        `
        query guests($params: GuestSearchParams) {
          guests(params: $params) {
            entries {
              firstName lastName id
              residence nationality city
            }
            cursor {
              totalEntries totalPages page
            }
          }
        }`,
        { params: { ...currentParams, ...params } }
      );
      store.dispatch({
        type: GuestActionType.Fetch,
        payload: guests
      });
    } catch (e) {
      console.error(e);
    }
  }
}
