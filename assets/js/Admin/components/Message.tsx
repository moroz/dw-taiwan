import React from "react";

export enum LogLevel {
  Info,
  Notice,
  Warning,
  Error,
  Success
}

function logLevelColor(level: LogLevel = LogLevel.Info) {
  switch (level) {
    case LogLevel.Info:
      return "info";
    case LogLevel.Success:
      return "positive";
    case LogLevel.Notice:
      return "olive";
    case LogLevel.Error:
      return "error";
  }
}

interface Props {
  message: string | null;
  level?: LogLevel;
}

export default function({ message, level }: Props) {
  if (!message) return null;
  return (
    <div className={`ui message status_message ${logLevelColor(level)}`}>
      <p>{message}</p>
    </div>
  );
}
