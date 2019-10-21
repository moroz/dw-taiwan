import React from "react";
import GuestHelpers from "../helpers/GuestHelpers";
import CardSection from "../components/CardSection";
import GuestDataField from "./GuestDataField";

export default function({ children }: { children: string | null }) {
  if (!children) return null;
  return (
    <GuestDataField label="Notes">
      <span
        dangerouslySetInnerHTML={{
          __html: GuestHelpers.formatUnsafeNotes(children)
        }}
      />
    </GuestDataField>
  );
}
