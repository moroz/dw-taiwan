import React from "react";
import { Guest, EmailType, GuestStatus } from "../types/guests";
import Emails from "../actions/Emails";
import { connect } from "react-redux";
import GuestHelpers from "../helpers/GuestHelpers";
import { IReduxState } from "../reducers";

interface Props extends React.Props<SendEmailButton> {
  guest: Guest | null;
  sending: boolean;
  emailType: EmailType;
}

class SendEmailButton extends React.Component<Props> {
  label = () => {
    const { emailType } = this.props;
    const typeLabel = emailType.toLowerCase();
    if (this.emailSent()) {
      return `Resend ${typeLabel}`;
    } else {
      return `Send ${typeLabel}`;
    }
  };

  colorClass = () => {
    return this.emailSent() ? "ui button orange" : "ui button blue";
  };

  emailSent = () => {
    const { guest, emailType } = this.props;
    return GuestHelpers.emailSent(guest as Guest, emailType);
  };

  handleClick = () => {
    const { guest, emailType } = this.props;
    return Emails.sendEmail(guest as Guest, emailType);
  };

  render() {
    const { guest, sending } = this.props;
    if (!guest || guest.status !== GuestStatus.Invited) return null;
    return (
      <button
        className={this.colorClass()}
        onClick={this.handleClick}
        disabled={sending}
      >
        {this.label()}
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

export default connect(mapState)(SendEmailButton);
