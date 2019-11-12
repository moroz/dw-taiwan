import React from "react";
import Loader from "../components/Loader";
import client from "../graphql/client";

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

function Statistic({ label, children, className }: any) {
  return (
    <div className={`statistic ui card ${className || ""}`}>
      <div className="value">{children}</div>
      <div className="label">{label}</div>
    </div>
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
          <Statistic label="Invited, not paid">{counts.invitedCount}</Statistic>
          <Statistic label="Tickets sold">{counts.paidCount}</Statistic>
          <Statistic label="Waiting list">{counts.backupCount}</Statistic>
          <Statistic label="Unrevieved">{counts.unverifiedCount}</Statistic>
          <Statistic label="Total guests">{counts.totalCount}</Statistic>
          <Statistic label="Canceled reservations">
            {counts.canceledCount}
          </Statistic>
        </div>
      </div>
    );
  }
}

export default Dashboard;
