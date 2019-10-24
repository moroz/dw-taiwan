import React, { SyntheticEvent } from "react";
import { History } from "history";
import Topbar from "../layout/Topbar";
import MainWrapper from "../layout/MainWrapper";
import GuestCard from "../components/GuestCard";
import { match } from "react-router";
import { Guest } from "../types/guests";
import Guests from "../actions/Guests";
import { connect } from "react-redux";

interface Props extends React.Props<DisplayGuest> {
  history: History;
  match: match;
  guest: Guest | null;
  loading: boolean;
}

class DisplayGuest extends React.Component<Props> {
  goBack = (e: SyntheticEvent) => {
    e.preventDefault();
    this.props.history.goBack();
  };

  async componentDidMount() {
    const id = this.props.match.params.id;
    await Guests.fetchGuest(id);
  }

  render() {
    const { guest } = this.props;
    const title = guest
      ? `Guest: ${guest.firstName} ${guest.lastName}`
      : "Loading Guest";
    return (
      <>
        <Topbar title={title} />
        <MainWrapper>
          <GuestCard guest={guest} goBack={this.goBack} />
        </MainWrapper>
      </>
    );
  }
}

function mapState(state: any) {
  return {
    guest: state.guests.entry,
    loading: state.guests.loading
  };
}

export default connect(mapState)(DisplayGuest);
