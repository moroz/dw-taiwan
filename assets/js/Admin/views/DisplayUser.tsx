import React, { Component } from "react";
import { History } from "history";
import CardSection from "../components/CardSection";
import Loader from "../components/Loader";
import Users from "../actions/Users";
import { Link } from "react-router-dom";
import { match } from "react-router";
import { User } from "../types/users";

interface Props extends React.Props<DisplayUser> {
  history: History;
  match: match;
}

interface State {
  user: User | null;
  loading: boolean;
}

class DisplayUser extends Component<Props, State> {
  state: State = {
    user: null,
    loading: true
  };

  async componentDidMount() {
    const id = this.props.match.params.id;
    const user = await Users.getUser(id);
    this.setState({ loading: false, user });
  }

  render() {
    const { user, loading } = this.state;
    if (loading) return <Loader />;
    if (!user) return <h1>Not found</h1>;
    return (
      <div className="card ui display_guest">
        <CardSection padded className="display_guest__header">
          <div>
            <Link to="/users">&lt;&lt; Back to list</Link>
            <h1>User: {user.displayName}</h1>
          </div>
        </CardSection>
      </div>
    );
  }
}

export default DisplayUser;
