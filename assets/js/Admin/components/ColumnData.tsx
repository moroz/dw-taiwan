import React from "react";

interface Props {
  label: string;
  customClass?: string;
  children: any;
}

export default ({ label, children, customClass }: Props) => {
  return (
    <div className="column-data">
      <span className="column-data__label">{label}</span>
      <p className={`column-data__content ${customClass || ""}`}>{children}</p>
    </div>
  );
};
