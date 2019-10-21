import React from "react";
import { connect } from "react-redux";
import { Guest } from "../types/guests";
import { Cursor, id } from "../types/common";
import Guests from "../actions/Guests";
import GuestRow from "./GuestRow";
import Topbar from "../layout/Topbar";
import MainWrapper from "../layout/MainWrapper";
import Loader from "./Loader";
import qs from "qs";
import GuestPagination from "./GuestPagination";
import PageDescription from "./PageDescription";
import { History } from "history";

interface Props extends React.Props<GuestTable> {
  loading: boolean;
  entries: Guest[];
  cursor: Cursor | null;
  location: any;
  history: History;
}

interface State {
  page: number;
}

class GuestTable extends React.Component<Props> {
  state = {
    page: 1
  };

  handleNavigate = (id: id) => {
    this.props.history.push(`/guests/${id}`);
  };

  async componentDidMount() {
    this.setPage(this.getPageNumber());
  }

  setPage = (page: number) => {
    this.setState({ page }, () => {
      Guests.fetchGuests({ page: this.state.page });
    });
  };

  static parsePageNumber(string: string) {
    const params = qs.parse(string.replace(/^\?/, ""));
    if (params && params.page) return parseInt(params.page);
    return 1;
  }

  static getDerivedStateFromProps(nextProps: Props, prevState: State) {
    const page = GuestTable.parsePageNumber(nextProps.location.search);
    if (page !== prevState.page) {
      Guests.fetchGuests({ page });
      return {
        page
      };
    }
    return null;
  }

  getPageNumber = () => {
    const params =
      this.props.location &&
      this.props.location.search &&
      qs.parse(this.props.location.search.replace(/^\?/, ""));
    return parseInt(params.page) || 1;
  };

  render() {
    const { loading, entries, history, cursor } = this.props;
    return (
      <>
        <Topbar title="Waiting List"></Topbar>
        <MainWrapper>
          {loading ? (
            <Loader></Loader>
          ) : (
            <>
              <PageDescription cursor={cursor} />
              <table className="ui table celled guest_table hoverable">
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
                    <GuestRow
                      guest={guest}
                      key={`guest-${guest.id}`}
                      onClick={() => this.handleNavigate(guest.id)}
                    />
                  ))}
                </tbody>
              </table>
            </>
          )}
        </MainWrapper>
        <GuestPagination cursor={this.props.cursor} history={history} />
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
