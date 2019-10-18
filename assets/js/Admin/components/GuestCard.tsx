import React from "react";
import { Guest } from "../types/guests";
import CardSection from "./CardSection";
import ColumnData from "./ColumnData";
import Notes from "./Notes";

interface Props {
  guest: Guest | null;
  goBack(e: any): void;
}

export default ({ guest, goBack }: Props) => {
  if (!guest) return null;
  return (
    <div className="card ui display_guest">
      <CardSection padded>
        <a onClick={goBack}>&lt;&lt; Back to list</a>
        <h1>
          {guest.firstName} {guest.lastName}, {guest.residence} (#{guest.id})
        </h1>
      </CardSection>

      <CardSection columnData>
        <ColumnData label="Email:" customClass="monospace">
          {guest.email}
        </ColumnData>
        <ColumnData label="Nationality:">{guest.nationality}</ColumnData>
        <ColumnData label="Living in:">
          {guest.city}, {guest.residence}
        </ColumnData>
        <ColumnData label="Reference:">
          {guest.referenceName}{" "}
          <span className="monospace">&lt;{guest.referenceEmail}&gt;</span>
        </ColumnData>
      </CardSection>
      {guest.notes ? (
        <CardSection padded>
          <Notes>{guest.notes}</Notes>
        </CardSection>
      ) : null}
    </div>
  );
};
