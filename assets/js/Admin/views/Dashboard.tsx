import React, { useEffect } from "react";
import Loader from "../components/Loader";
import Search from "../actions/Search";
import GuestStats from "../components/dashboard/GuestStats";
import useQuery from "../graphql/withQuery";

const DASHBOARD_QUERY = `
{
  counts: dashboardData {
    totalCount invitedCount backupCount
    unverifiedCount paidCount canceledCount
  }
}`;

export default function() {
  const { loading, data } = useQuery({ query: DASHBOARD_QUERY });

  useEffect(() => {
    Search.resetSearchParams(false);
  }, []);

  if (loading) return <Loader />;

  return (
    <>
      <h1>Dashboard</h1>
      <div className="dashboard">
        <GuestStats counts={data.counts} />
        <div className="sales ui card">
          <div className="content">
            <h2 className="header">Sales statistics</h2>
          </div>
        </div>
      </div>
    </>
  );
}
