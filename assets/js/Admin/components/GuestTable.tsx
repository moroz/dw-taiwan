import React from "react";

import { Guest } from "../types/guests";
import GuestRow from "./GuestRow";

const GUESTS: Guest[] = [
  {
    firstName: "Borys",
    lastName: "Szyc",
    residence: "United Catholic Emirates",
    city: "Warsaw",
    id: 252
  },
  {
    firstName: "Jan",
    lastName: "Paweł II",
    residence: "Vatican",
    city: "Vatican",
    id: 251
  },
  {
    firstName: "Olaf",
    lastName: "Lubaszenko",
    residence: "Israel",
    city: "Tel Aviv",
    id: 250
  }
];

export default class GuestTable extends React.Component {
  render() {
    return (
      <table className="ui table celled guest_table">
        <thead>
          <th className="guest_table__id">ID</th>
          <th>Name</th>
          <th>Country</th>
          <th>Sangha</th>
        </thead>
        <tbody>
          {GUESTS.map(guest => (
            <GuestRow guest={guest} key={`guest-${guest.id}`} />
          ))}
        </tbody>
      </table>
    );
  }
}
