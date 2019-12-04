import React from "react";
import SidebarProfile from "./SidebarProfile";
import { NavLink } from "react-router-dom";
import Search from "../actions/Search";

function SidebarLink({ to, exact, children, onClick }: any) {
  return (
    <NavLink
      to={to}
      exact={exact}
      className="admin__sidebar__link"
      activeClassName="admin__sidebar__link--active"
      onClick={onClick}
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
          Dashboard
        </SidebarLink>
        <SidebarLink
          exact
          to="/guests"
          onClick={() => Search.setSearchParams({ page: 1, term: "" })}
        >
          Guest list
        </SidebarLink>
        <SidebarLink exact to="/help">
          Read This First
        </SidebarLink>
      </div>
    </div>
  );
}
