import React from "react";

export default class MahamudraAdmin extends React.Component {
  render() {
    return (
      <div className="admin">
        <div className="admin__left">
          <div className="admin__header">
            <img src="/images/logo-admin.svg"></img>
          </div>
          <div className="admin__menu">
            <div className="admin__profile">
              <div className="admin__profile__avatar">
                <img src="/images/avatar.jpg"></img>
              </div>
              <p className="admin__profile__name">Umar ibn Abd al-Aziz</p>
            </div>
          </div>
        </div>
        <div className="admin__right">
          <div className="admin__topbar">
            <h1>Waiting List</h1>
          </div>
          <main className="admin__main">Hello from React!</main>
        </div>
      </div>
    );
  }
}
