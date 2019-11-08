import React from "react";

interface Props {
  title: string;
  right?: string | JSX.Element | JSX.Element[];
}

export default function Topbar({ title, right }: Props) {
  return (
    <div className="admin__topbar">
      <form id="searchForm" className="topbar__search">
        <input
          type="text"
          name="term"
          placeholder="Search..."
          className="topbar__search__input"
        ></input>
        <img src="/images/search.svg" className="topbar__search__icon"></img>
      </form>
      {right ? <div className="admin__topbar__right">{right}</div> : null}
    </div>
  );
}
