import React from "react";
import { Guest, EmailType, GuestStatus } from "../types/guests";
import Emails from "../actions/Emails";
import { connect } from "react-redux";
import GuestHelpers from "../helpers/GuestHelpers";
import { IReduxState } from "../reducers";

interface Props extends React.Props<IssuePaymentButton> {
  guest: Guest | null;
  sending: boolean;
}

class IssuePaymentButton extends React.Component<Props> {
  emailSent = () => {
    return GuestHelpers.emailSent(this.props.guest as Guest, EmailType.Payment);
  };

  handleClick = () => {
    const { guest } = this.props;
    return Emails.issuePayment(guest as Guest);
  };

  render() {
    const { guest, sending } = this.props;
    if (!guest) return null;
    return (
      <button
        className="ui button green"
        onClick={this.handleClick}
        disabled={sending}
      >
        Payment link
      </button>
    );
  }
}

function mapState(state: IReduxState) {
  return {
    guest: state.guests.entry,
    sending: state.guests.emailSending
  };
}

export default connect(mapState)(IssuePaymentButton);
