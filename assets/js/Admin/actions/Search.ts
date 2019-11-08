import store from "../store";
import { SearchParams } from "../reducers/guests";
import { GuestActionType } from "../types/guests";
import Guests from "../actions/Guests";
import qs from "qs";
import { History } from "history";

const initialParams = {
  term: "",
  page: 1
};

export default class Search {
  static getInitialParams(location: any) {
    const params =
      location &&
      location.search &&
      qs.parse(location.search.replace(/^\?/, ""));
    if (!params) return initialParams;
    return {
      term: "",
      ...params,
      page: parseInt(params.page)
    };
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
    return `/?${qs.stringify(params)}`;
  }

  static async setSearchParams(newParams: SearchParams, history?: History) {
    const { params, loading } = store.getState().guests;
    let newPage = params.page,
      newTerm = params.term,
      changed = false;
    if (newParams.page && newParams.page != params.page) {
      newPage = newParams.page;
      changed = true;
    }
    if (typeof newParams.term === "string" && newParams.term !== params.term) {
      newTerm = newParams.term;
      newPage = 1;
      changed = true;
    }
    if (!changed && !loading) return;
    const merged = {
      term: newTerm,
      page: newPage
    };
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
