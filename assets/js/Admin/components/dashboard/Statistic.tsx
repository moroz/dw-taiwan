import React from "react";
import { Link } from "react-router-dom";

interface StatisticProps {
  label: string;
  count: number;
  className?: string;
  status: GuestStatus | null;
}

export default function Statistic({
  label,
  count,
  className,
  status
}: StatisticProps) {
  const statusClass = status ? status.toLowerCase() : "";
  const href = status ? `/guests?status=${status}` : "/guests";
  return (
    <Link className={`statistic ${className || ""} ${statusClass}`} to={href}>
      <span className="label">{label}</span>
      <span className="value">{count}</span>
    </Link>
  );
}
