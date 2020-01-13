import client from "../graphql/client";
import store from "../store";
import { UserActionType } from "../types/users";
import { FETCH_USER_QUERY } from "../graphql/queries/userQueries";

export default class Users {
  static async fetchUser() {
    try {
      const { currentUser } = await client.query(FETCH_USER_QUERY);
      store.dispatch({
        type: UserActionType.Fetch,
        payload: currentUser
      });
    } catch (e) {
      console.error(e);
    }
  }
}
