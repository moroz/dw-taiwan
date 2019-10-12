import React from "react";

export default function Sidebar(_props?: any) {
  return (
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
  );
}
