import React from "react";
import Loader from "../components/Loader";
import client from "../graphql/client";
import { GuestStatus } from "../types/guests";
import { Link } from "react-router-dom";

interface State {
  counts: {
    totalCount: number;
    invitedCount: number;
    backupCount: number;
    canceledCount: number;
    unverifiedCount: number;
    paidCount: number;
  };
  loading: boolean;
}

const DASHBOARD_QUERY = `
{
  counts: dashboardData {
    totalCount invitedCount backupCount
    unverifiedCount paidCount canceledCount
  }
}`;

interface StatisticProps {
  label: string;
  children: number;
  className?: string;
  status: GuestStatus | null;
}

function Statistic({ label, children, className, status }: StatisticProps) {
  const statusClass = status ? status.toLowerCase() : "";
  const href = status ? `/guests?status=${status}` : "/guests";
  return (
    <Link className={`statistic ${className || ""} ${statusClass}`} to={href}>
      <div className="value">{children}</div>
      <div className="label">{label}</div>
    </Link>
  );
}

class Dashboard extends React.Component<any, State> {
  state: State = {
    loading: true,
    counts: {
      totalCount: 0,
      invitedCount: 0,
      backupCount: 0,
      unverifiedCount: 0,
      canceledCount: 0,
      paidCount: 0
    }
  };

  async componentDidMount() {
    const { counts } = await client.query(DASHBOARD_QUERY);
    this.setState({ loading: false, counts });
  }

  render() {
    const { loading, counts } = this.state;
    if (loading) return <Loader />;
    return (
      <div className="dashboard">
        <h1>Dashboard</h1>
        <div className="statistics">
          <Statistic label="Invited, not paid" status={GuestStatus.Invited}>
            {counts.invitedCount}
          </Statistic>
          <Statistic label="Tickets sold" status={GuestStatus.Paid}>
            {counts.paidCount}
          </Statistic>
          <Statistic label="Waiting list" status={GuestStatus.Backup}>
            {counts.backupCount}
          </Statistic>
          <Statistic label="Unrevieved" status={GuestStatus.Unverified}>
            {counts.unverifiedCount}
          </Statistic>
          <Statistic label="Total guests" status={null} className="total">
            {counts.totalCount}
          </Statistic>
          <Statistic
            label="Canceled reservations"
            status={GuestStatus.Canceled}
          >
            {counts.canceledCount}
          </Statistic>
        </div>
      </div>
    );
  }
}

export default Dashboard;
