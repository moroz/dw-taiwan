import React from "react";

interface Props {
  title: string;
}

export default function Topbar({ title }: Props) {
  return (
    <div className="admin__topbar">
      <h1>{title}</h1>
    </div>
  );
}
