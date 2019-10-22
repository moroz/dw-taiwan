import React from "react";
import SidebarProfile from "./SidebarProfile";
import { NavLink } from "react-router-dom";

function SidebarLink({ to, exact, children }: any) {
  return (
    <NavLink
      to={to}
      exact={exact}
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
        <SidebarLink exact to="/">
          Waiting List
        </SidebarLink>
        <SidebarLink exact to="/help">
          Read This First
        </SidebarLink>
        <a href="/admin/csv_export" className="admin__sidebar__link" target="_blank">
          CSV Export
        </a>
        <a href="/" className="admin__sidebar__link">
          Back to Website
        </a>
        {/* <SidebarLink to="/invited">Invited Guests</SidebarLink>
        <SidebarLink to="/paid">Paid Reservations</SidebarLink> */}
      </div>
    </div>
  );
}
