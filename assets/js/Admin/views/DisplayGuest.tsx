import React, { SyntheticEvent } from "react";
import { History } from "history";
import Topbar from "../layout/Topbar";
import MainWrapper from "../layout/MainWrapper";
import GuestCard from "../components/GuestCard";
import { match } from "react-router";
import { Guest } from "../types/guests";
import Guests from "../actions/Guests";
import { connect } from "react-redux";
import Message, { LogLevel } from "../components/Message";

interface Props extends React.Props<DisplayGuest> {
  history: History;
  match: match;
  guest: Guest | null;
  loading: boolean;
  message: string | null;
  success: boolean;
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
    const { guest, success, message } = this.props;
    const title = guest
      ? `Guest: ${guest.firstName} ${guest.lastName}`
      : "Loading Guest";
    return (
      <>
        <Topbar title={title} />
        <Message
          message={message}
          level={success ? LogLevel.Success : LogLevel.Error}
        />
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
    loading: state.guests.loading,
    message: state.guests.mutationMsg,
    success: state.guests.mutationSuccess
  };
}

export default connect(mapState)(DisplayGuest);