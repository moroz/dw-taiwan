import React from "react";
import { connect } from "react-redux";
import { Guest } from "../types/guests";
import { Cursor, id } from "../types/common";
import GuestRow from "../components/GuestRow";
import Loader from "../components/Loader";
import GuestPagination from "../components/GuestPagination";
import PageDescription from "../components/PageDescription";
import { History } from "history";
import Search from "../actions/Search";
import { SearchParams } from "../reducers/guests";

interface Props extends React.Props<GuestTable> {
  loading: boolean;
  entries: Guest[];
  cursor: Cursor | null;
  params: SearchParams;
  location: any;
  history: History;
}

class GuestTable extends React.Component<Props> {
  handleNavigate = (id: id) => {
    this.props.history.push(`/guests/${id}`);
  };

  async componentWillMount() {
    Search.setInitialParams(this.props.location, this.props.history);
  }

  render() {
    const { loading, entries, history, cursor, params } = this.props;
    return (
      <>
        {loading ? (
          <Loader />
        ) : (
          <>
            <h2>Guest List</h2>
            <PageDescription cursor={cursor} params={params} />
            {entries.length ? (
              <table className="ui table celled guest_table hoverable">
                <thead>
                  <tr>
                    <th className="guest_table__id">ID</th>
                    <th className="guest_table__status">Status</th>
                    <th>Name</th>
                    <th>Country</th>
                    <th>Sangha</th>
                  </tr>
                </thead>
                <tbody>
                  {entries.map(guest => (
                    <GuestRow
                      guest={guest}
                      key={`guest-${guest.id}`}
                      onClick={() => this.handleNavigate(guest.id)}
                    />
                  ))}
                </tbody>
              </table>
            ) : null}
            <GuestPagination cursor={this.props.cursor} history={history} />
          </>
        )}
      </>
    );
  }
}

function mapState(state: any) {
  return {
    entries: state.guests.entries,
    loading: state.guests.loading,
    cursor: state.guests.cursor,
    params: state.guests.params
  };
}

export default connect(mapState)(GuestTable);
