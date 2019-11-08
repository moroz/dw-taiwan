import React from "react";
import GuestTable from "./views/GuestTable";
import DisplayGuest from "./views/DisplayGuest";
import Sidebar from "./layout/Sidebar";
import SidebarFooter from "./layout/SidebarFooter";
import SidebarHeader from "./layout/SidebarHeader";
import Users from "./actions/Users";
import store from "./store";
import Help from "./views/Help";
import { Provider } from "react-redux";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import Topbar from "./layout/Topbar";
import FlashMessages from "./components/FlashMessages";

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
              <Topbar />
              <FlashMessages />
              <main className="admin__main" id="mainWrapper">
                <Switch>
                  <Route exact path="/" component={GuestTable} />
                  <Route exact path="/help" component={Help} />
                  <Route exact path="/guests/:id" component={DisplayGuest} />
                </Switch>
              </main>
            </div>
          </div>
        </Router>
      </Provider>
    );
  }
}
