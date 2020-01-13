import React, { Component } from "react";
import { connect } from "react-redux";
import { User } from "../types/users";
import { IReduxState } from "../reducers";

interface Props extends React.Props<SidebarProfile> {
  user: User | null;
}

export default class SidebarProfile extends Component<Props> {
  render() {
    const { user } = this.props;
    return (
      <div className="admin__profile">
        <div className="admin__profile__avatar">
          <img src={this.avatarURL()} />
        </div>
        {user ? (
          <p className="admin__profile__name">{user.displayName}</p>
        ) : null}
      </div>
    );
  }

  avatarURL = () => {
    const { user } = this.props;
    if (!user) return "";
    if (user.avatarUrl) return user.avatarUrl;
    return "/images/avatar.jpg";
  };
}
