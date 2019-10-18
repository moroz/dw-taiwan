import React from "react";

interface Props {
  children: string | JSX.Element | JSX.Element[] | null;
}

export default ({ children }: Props) => (
  <main className="admin__main" id="mainWrapper">
    {children}
  </main>
);
