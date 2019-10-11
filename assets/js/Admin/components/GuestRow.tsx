import React from "react";
import { Guest } from "../types/guests";

function displayName(guest: Guest) {
  return `${guest.firstName} ${guest.lastName}`;
}

export default function GuestRow({ guest }: { guest: Guest }) {
  return (
    <tr>
      <td className="guest_table__id">{guest.id}</td>
      <td>{displayName(guest)}</td>
      <td>{guest.residence}</td>
      <td>{guest.city}</td>
    </tr>
  );
}
