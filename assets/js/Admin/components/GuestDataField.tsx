import React from "react";

type child = JSX.Element | string;

interface Props {
  customClass?: string;
  children: child | child[] | null;
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
