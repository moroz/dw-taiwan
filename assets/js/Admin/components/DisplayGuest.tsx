import React, { SyntheticEvent } from "react";
import { History } from "history";
import Topbar from "../layout/Topbar";
import MainWrapper from "../layout/MainWrapper";
import GuestCard from "./GuestCard";
import { match } from "react-router";
import Guests from "../actions/Guests";

interface Props extends React.Props<DisplayGuest> {
  history: History;
  match: match;
}

export default class DisplayGuest extends React.Component<Props> {
  state = {
    guest: null,
    loading: true
  };

  goBack = (e: SyntheticEvent) => {
    e.preventDefault();
    this.props.history.goBack();
  };

  async componentDidMount() {
    try {
      const id = this.props.match.params.id;
      const { guest } = await Guests.fetchGuest(id);
      this.setState({ guest, loading: false });
    } catch (e) {
      console.error(e);
    }
  }

  render() {
    const { guest }: any = this.state;
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
