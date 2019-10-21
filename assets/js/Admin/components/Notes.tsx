import React from "react";
import GuestHelpers from "../helpers/GuestHelpers";
import GuestDataField from "./GuestDataField";

export default function({ children }: { children: string | null }) {
  if (!children) return null;
  return (
    <GuestDataField label="Guest notes">
      <span
        dangerouslySetInnerHTML={{
          __html: GuestHelpers.formatUnsafeNotes(children)
        }}
      />
    </GuestDataField>
  );
}
