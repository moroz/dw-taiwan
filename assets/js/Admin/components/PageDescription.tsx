import React from "react";
import { Cursor } from "../types/common";
import { SearchParams } from "../reducers/guests";
import { Link } from "react-router-dom";
import Search from "../actions/Search";

interface Props {
  cursor: Cursor | null;
  params: SearchParams;
}

export default function({ params, cursor }: Props) {
  if (!cursor) return null;
  const { page, totalEntries, pageSize } = cursor;
  if (!totalEntries)
    return (
      <p className="page_description">
        No entries found
        {params.status ? (
          <>
            {" "}
            for status <strong>{params.status.toLowerCase()}</strong>
          </>
        ) : (
          ""
        )}
        .
        <Link to="/guests" onClick={Search.resetSearchParams}>
          {" "}
          Show all entries.
        </Link>
      </p>
    );
  const lastNumber =
    page * pageSize > totalEntries ? totalEntries : page * pageSize;
  return (
    <p className="page_description">
      Displaying{" "}
      {params.status ? (
        <strong>{params.status.toLowerCase() + " "}</strong>
      ) : (
        ""
      )}
      entries{" "}
      <strong>
        {(page - 1) * pageSize + 1}-{lastNumber}
      </strong>{" "}
      out of <strong>{totalEntries}</strong>.
      {Search.anyParams(params) ? (
        <Link to="/guests" onClick={Search.resetSearchParams}>
          {" "}
          Show all entries.
        </Link>
      ) : (
        " No filters applied."
      )}
    </p>
  );
}
