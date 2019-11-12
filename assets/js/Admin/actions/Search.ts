import store from "../store";
import { SearchParams } from "../reducers/guests";
import { GuestActionType } from "../types/guests";
import Guests from "../actions/Guests";
import qs from "qs";
import { History } from "history";

const initialParams = {};

export default class Search {
  static getInitialParams(location: any) {
    const params =
      location &&
      location.search &&
      qs.parse(location.search.replace(/^\?/, ""));
    if (!params) return initialParams;
    return {
      ...params,
      page: parseInt(params.page)
    };
  }

  static async resetSearchParams() {
    store.dispatch({ type: GuestActionType.ResetParams });
    Guests.fetchGuests(store.getState().guests.params);
  }

  static setInitialParams(location: any, history: History) {
    this.setSearchParams(this.getInitialParams(location), history);
  }

  static paramsToUrl(params?: SearchParams) {
    if (!params) {
      const state = store.getState();
      if (!state || !state.guests) return "";
      params = state.guests.params;
    }
    return `/guests?${qs.stringify(params)}`;
  }

  static async setSearchParams(newParams: SearchParams, history?: History) {
    const { params, loading } = store.getState().guests;
    let merged = { ...params },
      changed = false;
    if (newParams.page && newParams.page != params.page) {
      merged.page = parseInt(newParams.page as any);
      changed = true;
    }
    if (typeof newParams.term === "string" && newParams.term !== params.term) {
      merged.term = newParams.term;
      merged.page = 1;
      changed = true;
    }
    if (
      typeof newParams.status === "string" &&
      newParams.status !== params.status
    ) {
      merged.status = newParams.status;
      merged.page = 1;
      changed = true;
    }
    if (!changed && !loading) {
      return Guests.fetchGuests(params);
    }
    console.log(merged);
    if (changed) {
      store.dispatch({
        type: GuestActionType.SetParams,
        payload: merged
      });
    }
    Guests.fetchGuests(merged);
    history && history.push(this.paramsToUrl(merged));
  }
}
