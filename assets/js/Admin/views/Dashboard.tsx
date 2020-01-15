import React, { useEffect } from "react";
import Loader from "../components/Loader";
import Search from "../actions/Search";
import GuestStats from "../components/dashboard/GuestStats";
import useQuery from "../graphql/useQuery";
import { Link } from "react-router-dom";

const DASHBOARD_QUERY = `
{
  counts: dashboardData {
    totalCount invitedCount backupCount
    unverifiedCount paidCount canceledCount
  }
}`;

export default function() {
  const { loading, data } = useQuery(DASHBOARD_QUERY);

  useEffect(() => {
    Search.resetSearchParams(false);
  }, []);

  if (loading) return <Loader />;

  return (
    <>
      <h1>Dashboard</h1>
      <div className="dashboard">
        <GuestStats counts={data.counts} />
        <div className="ui card">
          <div className="content">
            <div className="header">Ticketing</div>
            <table className="ui table sales_table">
              <thead>
                <tr>
                  <th>Item</th>
                  <th className="center aligned">Units</th>
                  <th className="right aligned">Subtotal</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Full tickets:</td>
                  <td className="center aligned">0</td>
                  <td className="right aligned">NT$0</td>
                </tr>
                <tr className="negative">
                  <td>Invoiced (max. 240):</td>
                  <td className="center aligned">0</td>
                  <td className="right aligned">NT$0</td>
                </tr>
                <tr>
                  <td>Single tickets:</td>
                  <td className="center aligned">0</td>
                  <td className="right aligned">NT$0</td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <th colSpan={2}>Total</th>
                  <th className="right aligned">NT$0</th>
                </tr>
              </tfoot>
            </table>
          </div>
          <div className="extra content">
            <Link className="ui button primary" to="/guests?status=INVITED">
              Sell full ticket
            </Link>
            <a className="right floated button ui">Single ticket</a>
          </div>
        </div>
      </div>
    </>
  );
}
