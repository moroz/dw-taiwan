import React from "react";
import { connect } from "react-redux";
import { Guest } from "../types/guests";
import { Cursor } from "../types/common";
import Guests from "../actions/Guests";
import GuestRow from "./GuestRow";
import Topbar from "../layout/Topbar";
import MainWrapper from "../layout/MainWrapper";
import Loader from "./Loader";
import qs from "qs";

interface Props extends React.Props<GuestTable> {
  loading: boolean;
  entries: Guest[];
  cursor: Cursor | null;
  location: any;
}

class GuestTable extends React.Component<Props> {
  async componentDidMount() {
    Guests.fetchGuests({ page: this.getPageNumber() });
  }

  getPageNumber = () => {
    const params =
      this.props.location &&
      this.props.location.search &&
      qs.parse(this.props.location.search.replace(/^\?/, ""));
    return parseInt(params.page) || 1;
  };

  render() {
    const { loading, entries } = this.props;
    return (
      <>
        <Topbar title="Waiting List"></Topbar>
        <MainWrapper>
          {loading ? (
            <Loader></Loader>
          ) : (
            <table className="ui table celled guest_table">
              <thead>
                <tr>
                  <th className="guest_table__id">ID</th>
                  <th>Name</th>
                  <th>Country</th>
                  <th>Sangha</th>
                </tr>
              </thead>
              <tbody>
                {entries.map(guest => (
                  <GuestRow guest={guest} key={`guest-${guest.id}`} />
                ))}
              </tbody>
            </table>
          )}
        </MainWrapper>
      </>
    );
  }
}

function mapState(state: any) {
  return {
    entries: state.guests.entries,
    loading: state.guests.loading,
    cursor: state.guests.cursor
  };
}

export default connect(mapState)(GuestTable);
