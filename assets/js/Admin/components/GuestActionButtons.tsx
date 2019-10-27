import React from "react";
import Guests from "../actions/Guests";
import { Guest, GuestStatus } from "../types/guests";
import { connect } from "react-redux";

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

function GuestButton({ toState, guest, className, label }: any) {
  const handler = () => Guests.transitionGuest(guest.id, toState);

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

class GuestActionButtons extends React.Component<Props> {
  render() {
    const { guest } = this.props;
    if (!guest) return null;
    let buttons = null;
    switch (guest.status) {
      case GuestStatus.Unverified:
        buttons = (
          <GuestButton
            guest={guest}
            className="positive"
            toState={GuestStatus.Verified}
            label="Mark verified"
          />
        );
    }

    if (!buttons) return null;
    return (
      <div className="display_guest__actions">
        {buttons}
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
