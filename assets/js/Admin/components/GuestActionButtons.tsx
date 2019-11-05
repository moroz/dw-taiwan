import React from "react";
import Guests from "../actions/Guests";
import {
  Guest,
  GuestStatus,
  GuestActionType,
  EmailType
} from "../types/guests";
import { connect } from "react-redux";
import SendEmailButton from "./SendEmailButton";

interface Props extends React.Props<GuestActionButtons> {
  guest: Guest | null;
}

type ButtonColor =
  | "primary"
  | "secondary"
  | "positive"
  | "negative"
  | "red"
  | "green";

function GuestButton({ toState, guest, className, label, confirm }: any) {
  const handler = () => {
    if (confirm) {
      if (!window.confirm(confirm)) {
        return;
      }
    }
    Guests.transitionGuest(guest.id, toState);
  };

  return (
    <button className={`ui button ${className}`} onClick={handler}>
      {label}
    </button>
  );
}

function AddNoteButton({ guest }: any) {
  return (
    <button className="ui button teal" onClick={() => Guests.addNote(guest.id)}>
      Add note
    </button>
  );
}

function guestButtons(guest: Guest) {
  switch (guest.status) {
    case GuestStatus.Unverified:
      return (
        <>
          <GuestButton
            guest={guest}
            className="positive"
            toState={GuestStatus.Verified}
            label="Mark verified"
          />
          <GuestButton
            guest={guest}
            className="negative"
            label="Cancel registration"
            toState={GuestStatus.Canceled}
            confirm="Are you sure you want to cancel this registration?"
          />
        </>
      );

    case GuestStatus.Verified:
      return (
        <>
          <GuestButton
            guest={guest}
            className="blue"
            toState={GuestStatus.Invited}
            label="Invite!"
          />
          <GuestButton
            guest={guest}
            className="yellow"
            toState={GuestStatus.Backup}
            label="To backup list"
          />
          <GuestButton
            guest={guest}
            className="negative"
            label="Cancel registration"
            toState={GuestStatus.Canceled}
            confirm="Are you sure you want to cancel this registration?"
          />
        </>
      );

    case GuestStatus.Invited:
      return (
        <>
          <GuestButton
            guest={guest}
            className="yellow"
            toState={GuestStatus.Backup}
            label="To backup list"
          />
          <GuestButton
            guest={guest}
            className="negative"
            label="Cancel registration"
            toState={GuestStatus.Canceled}
            confirm="Are you sure you want to cancel this registration?"
          />
          <SendEmailButton emailType={EmailType.Confirmation} />
        </>
      );

    case GuestStatus.Backup:
      return (
        <GuestButton
          guest={guest}
          className="yellow"
          toState={GuestStatus.Invited}
          confirm="Are you sure you want to invite this person?"
          label="Invite!"
        />
      );

    case GuestStatus.Canceled:
      return (
        <GuestButton
          guest={guest}
          label="Revert cancelation"
          className="positive"
          confirm="Are you sure you want to revert cancelation?"
          toState={GuestStatus.Verified}
        />
      );
  }
}

class GuestActionButtons extends React.Component<Props> {
  render() {
    const { guest } = this.props;
    if (!guest) return null;
    return (
      <div className="display_guest__actions">
        {guestButtons(guest)}
        <AddNoteButton guest={guest} />
      </div>
    );
  }
}

function mapState(state: any) {
  return {
    guest: state.guests.entry
  };
}

export default connect(mapState)(GuestActionButtons);
