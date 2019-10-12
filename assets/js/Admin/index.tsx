import React from "react";
import GuestTable from "./components/GuestTable";
import Sidebar from "./layout/Sidebar";
import Topbar from "./layout/Topbar";
import SidebarFooter from "./layout/SidebarFooter";
import store from "./store";
import { Provider } from "react-redux";

export default class MahamudraAdmin extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <div className="admin">
          <div className="admin__left">
            <div className="admin__header">
              <img src="/images/logo-admin.svg" />
            </div>
            <Sidebar />
            <SidebarFooter />
          </div>
          <div className="admin__right">
            <Topbar />
            <main className="admin__main">
              <GuestTable />
            </main>
          </div>
        </div>
      </Provider>
    );
  }
}
