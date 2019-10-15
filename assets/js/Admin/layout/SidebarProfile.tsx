import React from "react";
import { connect } from "react-redux";
import { User } from "../types/users";

interface Props extends React.Props<SidebarProfile> {
  user: User | null;
}

class SidebarProfile extends React.Component<Props> {
  render() {
    const { user } = this.props;
    const src = user ? "/images/avatar.jpg" : "";
    return (
      <div className="admin__profile">
        <div className="admin__profile__avatar">
          <img src={src} />
        </div>
        {user ? (
          <p className="admin__profile__name">{user.displayName}</p>
        ) : null}
      </div>
    );
  }
}

function mapState(state: any) {
  return {
    user: state.user.user
  };
}

export default connect(mapState)(SidebarProfile);
