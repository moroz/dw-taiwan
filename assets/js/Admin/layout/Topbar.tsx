import React from "react";

interface Props {
  title: string;
  right?: string | JSX.Element | JSX.Element[];
}

export default function Topbar({ title, right }: Props) {
  return (
    <div className="admin__topbar">
      <h1>{title}</h1>
      {right ? <div className="admin__topbar__right">{right}</div> : null}
    </div>
  );
}
