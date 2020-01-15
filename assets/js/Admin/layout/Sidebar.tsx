import React from "react";
import SidebarProfile from "./SidebarProfile";
import { connect } from "react-redux";
import { IReduxState } from "../reducers";
import { NavLink } from "react-router-dom";
import { User } from "../types/users";
import Search from "../actions/Search";

interface Props {
  user: User | null;
}

function SidebarLink({ to, children, onClick }: any) {
  return (
    <NavLink
      to={to}
      className="admin__sidebar__link"
      activeClassName="admin__sidebar__link--active"
      onClick={onClick}
      exact
    >
      {children}
    </NavLink>
  );
}

class Sidebar extends React.Component<Props> {
  render() {
    const { user } = this.props;
    return (
      <div className="admin__sidebar">
        <SidebarProfile user={user} />
        <div className="admin__sidebar__menu">
          <SidebarLink to="/">Dashboard</SidebarLink>
          <SidebarLink
            to="/guests"
            onClick={() => Search.setSearchParams({ page: 1, term: "" })}
          >
            Guest list
          </SidebarLink>
          {user?.admin && (
            <SidebarLink to="/users">User Management</SidebarLink>
          )}
          <SidebarLink to="/help">Documentation</SidebarLink>
        </div>
      </div>
    );
  }
}

function mapState(state: IReduxState) {
  return {
    user: state.user.user
  };
}

export default connect(mapState)(Sidebar);
