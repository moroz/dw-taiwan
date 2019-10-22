import React from "react";
import { Audit } from "../types/audits";
import { Guest } from "../types/guests";
import GuestDataField from "../components/GuestDataField";
import GuestHelpers from "../helpers/GuestHelpers";
import DateHelpers from "../helpers/DateHelpers";
import DisplayGuest from "../views/DisplayGuest";

interface Props {
  audits: Audit[];
  guest: Guest;
}

function AuditRow({ timestamp, userName, description }: Audit) {
  return (
    <p className="audit">
      <strong className="audit__timestamp">
        {DateHelpers.timestamp(timestamp)}
      </strong>{" "}
      <span className="audit__username">{userName}</span> {description}
    </p>
  );
}

function GuestCreated({ guest }: { guest: Guest }) {
  return (
    <AuditRow
      userName={GuestHelpers.displayName(guest)}
      timestamp={guest.insertedAt}
      description="registered."
    />
  );
}

export default function({ audits, guest }: Props) {
  return (
    <GuestDataField label="History">
      <GuestCreated guest={guest} />
      <p className="guest_history__tz_info">
        All timestamps are in {DateHelpers.tzname()} timezone.
      </p>
    </GuestDataField>
  );
}
