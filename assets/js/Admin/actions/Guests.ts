import store from "../store";
import client from "../graphql/client";
import { GuestActionType, GuestAction, Guest } from "../types/guests";

export default class Guests {
  static async fetchGuests() {
    try {
      const { guests } = await client.query(`
        {
          guests {
            entries {
              firstName lastName id
              residence nationality city
            }
            cursor {
              totalEntries totalPages page
            }
          }
        }`);
      store.dispatch({
        type: GuestActionType.Fetch,
        payload: guests
      });
    } catch (e) {
      console.error(e);
    }
  }
}
