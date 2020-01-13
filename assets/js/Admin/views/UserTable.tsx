import React from "react";
import Loader from "../components/Loader";
import { User } from "../types/users";

interface State {
  users: User[];
  loading: boolean;
}

class UserTable extends React.Component<any, State> {
  state = {
    users: [],
    loading: true
  };

  render() {
    if (this.state.loading) return <Loader />;
  }
}

export default UserTable;
