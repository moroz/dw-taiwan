import React from "react";
import Statistic from "./Statistic";
import { GuestStatus } from "../../types/guests";

interface Props {
  counts: {
    totalCount: number;
    invitedCount: number;
    backupCount: number;
    canceledCount: number;
    unverifiedCount: number;
    paidCount: number;
  };
}

export default ({ counts }: Props) => (
  <div className="ui card">
    <div className="content">
      <div className="header">Guest statistics</div>
    </div>
    <div className="statistics">
      <Statistic
        label="Invited, not paid"
        status={GuestStatus.Invited}
        count={counts.invitedCount}
      />
      <Statistic
        label="Tickets sold"
        status={GuestStatus.Paid}
        count={counts.paidCount}
      />
      <Statistic
        label="Waiting list"
        status={GuestStatus.Backup}
        count={counts.backupCount}
      />
      <Statistic
        label="Unrevieved"
        status={GuestStatus.Unverified}
        count={counts.unverifiedCount}
      />
      <Statistic
        label="Canceled"
        status={GuestStatus.Canceled}
        count={counts.canceledCount}
      />
    </div>
  </div>
);
