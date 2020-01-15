import React from "react";
import Loader from "../components/Loader";
import client from "../graphql/client";
import { GuestStatus } from "../types/guests";
import { Link } from "react-router-dom";
import Search from "../actions/Search";
import GuestStats from "../components/dashboard/GuestStats";

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
    Search.resetSearchParams();
  }

  render() {
    const { loading, counts } = this.state;
    if (loading) return <Loader />;
    return (
      <>
        <h1>Dashboard</h1>
        <div className="dashboard">
          <GuestStats counts={counts} />
          <div className="sales ui card">
            <div className="content">
              <h2 className="header">Sales statistics</h2>
            </div>
          </div>
        </div>
      </>
    );
  }
}

export default Dashboard;
