import React from "react";
import Loader from "../components/Loader";
import { User } from "../types/users";
import Users from "../actions/Users";

interface State {
  users: User[];
  loading: boolean;
}

class UserTable extends React.Component<any, State> {
  state = {
    users: [],
    loading: true
  };

  async componentDidMount() {
    const users = await Users.listUsers();
    this.setState({ loading: false, users });
  }

  render() {
    const { users, loading } = this.state;
    if (loading) return <Loader />;
    return (
      <>
        <h2>User list</h2>
        {users.length ? (
          <table className="ui table celled guest_table hoverable">
            <thead>
              <tr>
                <th className="guest_table__id">ID</th>
                <th className="user_table__admin">Admin?</th>
                <th>Name</th>
                <th>E-mail</th>
              </tr>
            </thead>
            <tbody>
              {users.map(user => (
                <tr key={`user-${user.id}`}>
                  <td className="guest_table__id">{user.id}</td>
                  <td className="user_table__admin">
                    {user.admin ? "Yes" : "No"}
                  </td>
                  <td>{user.displayName}</td>
                  <td>{user.email}</td>
                </tr>
              ))}
            </tbody>
          </table>
        ) : null}
      </>
    );
  }
}

export default UserTable;
