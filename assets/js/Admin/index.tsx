import React from "react";
import GuestTable from "./components/GuestTable";
import Sidebar from "./layout/Sidebar";
import Topbar from "./layout/Topbar";
import SidebarFooter from "./layout/SidebarFooter";
import SidebarHeader from "./layout/SidebarHeader";
import store from "./store";
import { Provider } from "react-redux";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";

export default class MahamudraAdmin extends React.Component {
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
              <Topbar title="Waiting List" />
              <main className="admin__main">
                <Switch>
                  <Route exact path="/" component={GuestTable} />
                </Switch>
              </main>
            </div>
          </div>
        </Router>
      </Provider>
    );
  }
}
