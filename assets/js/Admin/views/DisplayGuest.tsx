import React, { SyntheticEvent } from "react";
import { History } from "history";
import MainWrapper from "../layout/MainWrapper";
import GuestCard from "../components/GuestCard";
import { match } from "react-router";
import { Guest } from "../types/guests";
import Guests from "../actions/Guests";
import { connect } from "react-redux";
import Message, { LogLevel } from "../components/Message";
import { IReduxState } from "../reducers";

interface Props extends React.Props<DisplayGuest> {
  history: History;
  match: match;
  guest: Guest | null;
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
    return <GuestCard guest={this.props.guest} goBack={this.goBack} />;
  }
}

function mapState(state: IReduxState) {
  return {
    guest: state.guests.entry
  };
}

export default connect(mapState)(DisplayGuest);
