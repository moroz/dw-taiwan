import React from "react";
import { Audit } from "../types/audits";
import { Guest } from "../types/guests";
import GuestDataField from "../components/GuestDataField";
import GuestHelpers from "../helpers/GuestHelpers";

interface Props {
  audits: Audit[];
  guest: Guest;
}

function AuditRow({ timestamp, userName, description }: Audit) {
  return (
    <p className="audit">
      <strong className="audit__timestamp">{timestamp}</strong>:{" "}
      <span className="audit__username">{userName}</span> {description}
    </p>
  );
}

function GuestCreated({ guest }: { guest: Guest }) {
  return (
    <AuditRow
      userName={GuestHelpers.displayName(guest)}
      timestamp={guest.insertedAt}
      description="registered"
    />
  );
}

export default function({ audits, guest }: Props) {
  return (
    <GuestDataField label="History">
      <GuestCreated guest={guest} />
    </GuestDataField>
  );
}
