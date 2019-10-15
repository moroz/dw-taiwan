import { createStore, applyMiddleware } from "redux";
import thunk from "redux-thunk";
import { composeWithDevTools } from "redux-devtools-extension";
import rootReducer from "./reducers";

const initialState = {};
const middleware = [thunk];

const enhancers = composeWithDevTools(applyMiddleware(...middleware));

const store = createStore(rootReducer, initialState, enhancers);

export default store;
