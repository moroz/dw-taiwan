import React from "react";

import { Guest } from "../types/guests";
import { Cursor } from "../types/common";
import client from "../graphql/client";
import GuestRow from "./GuestRow";

interface State {
  loading: boolean;
  entries: Guest[];
  cursor: Cursor | null;
}

export default class GuestTable extends React.Component<any, State> {
  state = {
    loading: true,
    entries: [],
    cursor: null
  };

  async componentDidMount() {
    const { guests } = await client.query(
      `{
        guests {
          entries {
            firstName lastName id
            residence nationality city
          }
          cursor {
            totalEntries totalPages page
          }
        }
      }`
    );
    this.setState({
      entries: guests.entries,
      cursor: guests.cursor,
      loading: false
    });
  }

  render() {
    if (this.state.loading) return <h1>Loading...</h1>;
    return (
      <table className="ui table celled guest_table">
        <thead>
          <th className="guest_table__id">ID</th>
          <th>Name</th>
          <th>Country</th>
          <th>Sangha</th>
        </thead>
        <tbody>
          {this.state.entries.map(guest => (
            <GuestRow guest={guest} key={`guest-${guest.id}`} />
          ))}
        </tbody>
      </table>
    );
  }
}
