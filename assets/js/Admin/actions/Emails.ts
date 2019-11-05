import GuestHelpers from "../helpers/GuestHelpers";
import { Guest, EmailType, GuestActionType } from "../types/guests";
import store from "../store";
import client from "../graphql/client";
import Guests from "./Guests";
import { SEND_EMAIL } from "../graphql/queries/guestQueries";

export default class Emails {
  static shouldSend(sent: boolean) {
    if (sent)
      return window.confirm("Are you sure you want to resend this email?");
    return true;
  }

  static async sendEmail(guest: Guest, type: EmailType) {
    try {
      const sent = GuestHelpers.emailSent(guest, type);
      let force = false;
      if (!this.shouldSend(sent)) return;
      if (sent) force = true;
      store.dispatch({ type: GuestActionType.TriggerEmailSend });
      const { sendEmail } = await client.query(SEND_EMAIL, {
        type,
        force,
        id: guest.id
      });
      store.dispatch({ type: GuestActionType.EmailSent, payload: sendEmail });
    } catch (e) {
      Guests.handleError(e);
    }
  }
}
