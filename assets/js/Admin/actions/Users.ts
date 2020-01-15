import client from "../graphql/client";
import store from "../store";
import { UserActionType } from "../types/users";
import {
  FETCH_USER_QUERY,
  LIST_USERS_QUERY,
  GET_USER_QUERY
} from "../graphql/queries/userQueries";
import { id } from "../types/common";

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

  static async listUsers() {
    try {
      const { listUsers } = await client.query(LIST_USERS_QUERY);
      return listUsers;
    } catch (e) {
      console.error(e);
      return [];
    }
  }

  static async getUser(id: id) {
    const { user } = await client.query(GET_USER_QUERY, { id });
    return user;
  }
}
