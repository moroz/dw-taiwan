import React from "react";
import SidebarProfile from "./SidebarProfile";
import { NavLink } from "react-router-dom";

function SidebarLink({ to, children }: any) {
  return (
    <NavLink
      to={to}
      className="admin__sidebar__link"
      activeClassName="admin__sidebar__link--active"
    >
      {children}
    </NavLink>
  );
}

export default function Sidebar(_props?: any) {
  return (
    <div className="admin__sidebar">
      <SidebarProfile />
      <div className="admin__sidebar__menu">
        <SidebarLink to="/">Waiting List</SidebarLink>
        {/* <SidebarLink to="/invited">Invited Guests</SidebarLink>
        <SidebarLink to="/paid">Paid Reservations</SidebarLink> */}
      </div>
    </div>
  );
}
