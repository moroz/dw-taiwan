import React from "react";
import { Guest } from "../types/guests";
import CardSection from "./CardSection";
import ColumnData from "./ColumnData";
import Notes from "./Notes";
import GuestDataField from "./GuestDataField";
import GuestHelpers from "../helpers/GuestHelpers";
import GuestHistory from "../components/GuestHistory";
import GuestActionButtons from "./GuestActionButtons";
import AdminNotes from "./AdminNotes";

interface Props {
  guest: Guest | null;
  goBack(e: any): void;
}

export default ({ guest, goBack }: Props) => {
  if (!guest) return null;
  return (
    <div className="card ui display_guest">
      <CardSection padded className="display_guest__header">
        <div>
          <a onClick={goBack}>&lt;&lt; Back to list</a>
          <h1>
            {guest.firstName} {guest.lastName}, {guest.residence} (#{guest.id})
          </h1>
        </div>
        <GuestActionButtons />
      </CardSection>

      <CardSection columnData>
        <ColumnData label="Email:" customClass="monospace">
          {guest.email}
        </ColumnData>
        <ColumnData label="Status:">{GuestHelpers.status(guest)}</ColumnData>
        <ColumnData label="Nationality:">{guest.nationality}</ColumnData>
        <ColumnData label="Living in:">
          {guest.city}, {guest.residence}
        </ColumnData>
      </CardSection>
      <CardSection twoColumns padded>
        <div>
          <AdminNotes notes={guest.adminNotes} />
          <GuestDataField label="Sex">{GuestHelpers.sex(guest)}</GuestDataField>
          <GuestDataField label="Reference:">
            {guest.referenceName}
            <br />
            <span className="monospace">&lt;{guest.referenceEmail}&gt;</span>
          </GuestDataField>
        </div>
        <div>
          <Notes>{guest.notes}</Notes>
          <GuestHistory guest={guest} audits={guest.audits} />
        </div>
      </CardSection>
    </div>
  );
};
