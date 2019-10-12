import React from "react";
import GuestTable from "./components/GuestTable";
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
            <div className="admin__sidebar">
              <div className="admin__profile">
                <div className="admin__profile__avatar">
                  <img src="/images/avatar.jpg" />
                </div>
                <p className="admin__profile__name">Umar ibn Abd al-Aziz</p>
              </div>
              <div className="admin__sidebar__menu">
                <a
                  href="javascript:void"
                  className="admin__sidebar__link admin__sidebar__link--active"
                >
                  Waiting List
                </a>
                <a href="javascript:void" className="admin__sidebar__link">
                  Invited Guests
                </a>
                <a href="javascript:void" className="admin__sidebar__link">
                  Paid Reservations
                </a>
              </div>
            </div>
            <footer className="admin__sidebar__footer">
              <a href="/admin/logout" className="button ui primary">
                Sign out
              </a>
              <p>
                &copy; 2019 by Karol Moroz.
                <br />
                Licensed with BSD 3-clause license.
              </p>
            </footer>
          </div>
          <div className="admin__right">
            <div className="admin__topbar">
              <h1>Waiting List</h1>
            </div>
            <main className="admin__main">
              <GuestTable />
            </main>
          </div>
        </div>
      </Provider>
    );
  }
}
