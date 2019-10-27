import React from "react";
import GuestDataField from "./GuestDataField";
import { AdminNote } from "../types/notes";
import DateHelpers from "../helpers/DateHelpers";

interface Props {
  notes: AdminNote[];
}

function Note({ note }: { note: AdminNote }) {
  return (
    <div className="admin_note">
      <p className="admin_note__metadata">
        {note.userName}, {DateHelpers.timestamp(note.timestamp)}
      </p>
      <p className="admin_note__body">{note.body}</p>
    </div>
  );
}

export default function({ notes }: Props) {
  if (!notes.length) return null;
  return (
    <GuestDataField label="Admin notes">
      {notes.map((note, index) => (
        <Note note={note} key={`note-${index}`} />
      ))}
    </GuestDataField>
  );
}
