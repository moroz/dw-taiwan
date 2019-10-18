import React from "react";
import { Guest } from "../types/guests";
import CardSection from "./CardSection";
import ColumnData from "./ColumnData";

interface Props {
  guest: Guest | null;
  goBack(e: any): void;
}

const Row = ({ title, content }: any) => {
  return (
    <tr>
      <th scope="row">{title}</th>
      <td>{content}</td>
    </tr>
  );
};

export default ({ guest, goBack }: Props) => {
  if (!guest) return null;
  return (
    <div className="card ui display_guest">
      <CardSection padded>
        <a onClick={goBack}>&lt;&lt; Back to list</a>
        <h1>
          {guest.firstName} {guest.lastName}
        </h1>
      </CardSection>

      <CardSection columnData>
        <ColumnData label="Email:">{guest.email}</ColumnData>
        <ColumnData label="Nationality:">{guest.nationality}</ColumnData>
        <ColumnData label="Living in:">
          {guest.city}, {guest.residence}
        </ColumnData>
        <ColumnData label="Reference:">
          {guest.referenceName}{" "}
          <span className="monospace">&lt;{guest.referenceEmail}&gt;</span>
        </ColumnData>
      </CardSection>
      <table className="ui table celled">
        <tbody>
          {guest.notes ? (
            <>
              <tr>
                <td colSpan={2}>Notes:</td>
              </tr>
              <tr>
                <td colSpan={2}>{guest.notes}</td>
              </tr>
            </>
          ) : null}
        </tbody>
      </table>
    </div>
  );
};
