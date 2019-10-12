import React from "react";
import { connect } from "react-redux";
import { Guest } from "../types/guests";
import { Cursor } from "../types/common";
import Guests from "../actions/Guests";
import GuestRow from "./GuestRow";

interface Props extends React.Props<GuestTable> {
  loading: boolean;
  entries: Guest[];
  cursor: Cursor | null;
}

class GuestTable extends React.Component<Props> {
  async componentDidMount() {
    Guests.fetchGuests();
  }

  render() {
    if (this.props.loading) return <h1>Loading...</h1>;
    return (
      <table className="ui table celled guest_table">
        <thead>
          <tr>
            <th className="guest_table__id">ID</th>
            <th>Name</th>
            <th>Country</th>
            <th>Sangha</th>
          </tr>
        </thead>
        <tbody>
          {this.props.entries.map(guest => (
            <GuestRow guest={guest} key={`guest-${guest.id}`} />
          ))}
        </tbody>
      </table>
    );
  }
}

function mapState(state: any) {
  return {
    entries: state.guests.entries,
    loading: state.guests.loading,
    cursor: state.guests.cursor
  };
}

export default connect(mapState)(GuestTable);
