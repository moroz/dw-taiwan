import React from "react";
import GuestHelpers from "../helpers/GuestHelpers";

export default function({ children }: { children: string | null }) {
  if (!children) return null;
  return (
    <div className="display_guest__data_field">
      <p className="label-with-border">Notes</p>
      <p
        dangerouslySetInnerHTML={{
          __html: GuestHelpers.formatUnsafeNotes(children)
        }}
      />
    </div>
  );
}
