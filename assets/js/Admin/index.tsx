import React from "react";
import GuestTable from "./components/GuestTable";
import DisplayGuest from "./components/DisplayGuest";
import Sidebar from "./layout/Sidebar";
import SidebarFooter from "./layout/SidebarFooter";
import SidebarHeader from "./layout/SidebarHeader";
import Users from "./actions/Users";
import store from "./store";
import { Provider } from "react-redux";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";

export default class MahamudraAdmin extends React.Component {
  componentDidMount() {
    Users.fetchUser();
  }

  render() {
    return (
      <Provider store={store}>
        <Router basename="/admin">
          <div className="admin">
            <div className="admin__left">
              <SidebarHeader />
              <Sidebar />
              <SidebarFooter />
            </div>
            <div className="admin__right">
              <Switch>
                <Route exact path="/" component={GuestTable} />
                <Route exact path="/guests/:id" component={DisplayGuest} />
              </Switch>
            </div>
          </div>
        </Router>
      </Provider>
    );
  }
}
