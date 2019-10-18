import React from "react";

interface Props {
  label: string;
  children: any;
}

export default ({ label, children }: Props) => {
  return (
    <div className="column-data">
      <span className="column-data__label">{label}</span>
      <p className="column-data__content">{children}</p>
    </div>
  );
};
