import React from "react";
import { Guest } from "../types/guests";
import GuestHelpers from "../helpers/GuestHelpers";

interface Props {
  guest: Guest;
  onClick: (e: any) => void;
}

function displayName(guest: Guest) {
  return `${guest.firstName} ${guest.lastName}`;
}

export default function GuestRow({ guest, onClick }: Props) {
  return (
    <tr onClick={onClick} className={GuestHelpers.statusClass(guest)}>
      <td className="guest_table__id">{guest.id}</td>
      <td className="guest_table__status">{GuestHelpers.status(guest)}</td>
      <td>{displayName(guest)}</td>
      <td>{guest.residence}</td>
      <td>{guest.city}</td>
    </tr>
  );
}
