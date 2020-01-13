import store from "../store";
import { SearchParams, initialParams } from "../reducers/guests";
import { GuestActionType } from "../types/guests";
import Guests from "../actions/Guests";
import qs from "qs";
import { History } from "history";

export default class Search {
  static getInitialParams(location: any) {
    const params =
      location &&
      location.search &&
      qs.parse(location.search.replace(/^\?/, ""));
    if (!params) return initialParams;
    return params;
  }

  static anyParams(params: SearchParams) {
    return params?.term || params?.status;
  }

  static async resetSearchParams() {
    store.dispatch({ type: GuestActionType.ResetParams });
    Guests.fetchGuests(store.getState().guests.params);
  }

  static setInitialParams(
    location: any,
    history: History,
    force: boolean = false
  ) {
    const initial = this.getInitialParams(location);
    this.setSearchParams(initial, history, force);
  }

  static paramsToUrl(params?: SearchParams) {
    if (!params) {
      const state = store.getState();
      if (!state || !state.guests) return "";
      params = state.guests.params;
    }
    if (params) {
      if (params.term === "") delete params.term;
      if (params.status === null) delete params.status;
      if (params.page == 1) delete params.page;
    }
    return `/guests?${qs.stringify(params)}`;
  }

  static setTerm(term: string) {
    if (!term) {
      this.resetSearchParams();
    } else {
      store.dispatch({ type: GuestActionType.SetTerm, payload: term });
    }
  }

  static search(history?: History) {
    const { params } = store.getState().guests;
    const searchParams = { term: params.term };
    store.dispatch({
      type: GuestActionType.SetParams,
      payload: searchParams
    });
    Guests.fetchGuests(searchParams);
    history && history.push(this.paramsToUrl(searchParams));
  }

  static statesDiffer(oldState, newState) {
    let diff = false;
    ["term", "status", "page"].forEach(key => {
      if (oldState[key] != newState[key]) diff = true;
    });
    return diff;
  }

  static async setSearchParams(
    newParams: SearchParams,
    history?: History,
    force: boolean = false
  ) {
    const { params } = store.getState().guests;
    let searchParams = { ...params, ...newParams };
    if (!this.statesDiffer(searchParams, params) && !force) return;
    if (
      searchParams.status !== params.status ||
      searchParams.term !== params.term
    ) {
      searchParams.page = 1;
    }
    await store.dispatch({
      type: GuestActionType.SetParams,
      payload: searchParams
    });
    Guests.fetchGuests(searchParams);
    history && history.push(this.paramsToUrl(searchParams));
  }
}
