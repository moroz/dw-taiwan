import React from "react";

interface Props {
  customClass?: string;
  children: JSX.Element | string | null;
  label: string;
}

export default function({ label, children, customClass }: Props) {
  return (
    <div className={`display_guest__data_field ${customClass}`}>
      <p className="label-with-border">{label}</p>
      {children}
    </div>
  );
}
