import React from "react";
import { Guest } from "../types/guests";

interface Props {
  guest: Guest;
  onClick: (e: any) => void;
}

function displayName(guest: Guest) {
  return `${guest.firstName} ${guest.lastName}`;
}

export default function GuestRow({ guest, onClick }: Props) {
  return (
    <tr onClick={onClick}>
      <td className="guest_table__id">{guest.id}</td>
      <td>{displayName(guest)}</td>
      <td>{guest.residence}</td>
      <td>{guest.city}</td>
    </tr>
  );
}
