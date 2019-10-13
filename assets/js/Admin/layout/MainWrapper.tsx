import React from "react";

interface Props {
  children: string | JSX.Element | JSX.Element[];
}

export default ({ children }: Props) => (
  <main className="admin__main">{children}</main>
);
