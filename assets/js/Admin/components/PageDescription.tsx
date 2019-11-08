import React from "react";
import { Cursor } from "../types/common";

interface Props {
  cursor: Cursor | null;
}

export default function({ cursor }: Props) {
  if (!cursor) return null;
  const { page, totalEntries, pageSize } = cursor;
  if (!totalEntries)
    return <p className="page_description">No entries found.</p>;
  const lastNumber =
    page * pageSize > totalEntries ? totalEntries : page * pageSize;
  return (
    <p className="page_description">
      Displaying entries{" "}
      <strong>
        {(page - 1) * pageSize + 1}-{lastNumber}
      </strong>{" "}
      out of <strong>{totalEntries}</strong>.
    </p>
  );
}
