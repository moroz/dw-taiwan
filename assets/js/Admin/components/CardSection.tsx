import React from "react";

interface Props {
  children: JSX.Element | JSX.Element[];
  padded?: boolean;
  bordered?: boolean;
  className?: string;
  columnData?: boolean;
}

function getClassNames(
  bordered?: boolean,
  padded?: boolean,
  className?: string,
  columnData?: boolean
) {
  let result = "card__section ";
  if (columnData) result += "column-data-wrapper ";
  if (!bordered) result += "card__section--no-border ";
  if (padded) result += "card__section--padded ";
  if (className) result += className;
  return result;
}

export default function CardSection({
  children,
  bordered,
  padded,
  className,
  columnData
}: Props) {
  const classNames = getClassNames(bordered, padded, className, columnData);
  return <section className={classNames}>{children}</section>;
}
