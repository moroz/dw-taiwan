import { Guest, Gender, GuestStatus, EmailType } from "../types/guests";

export default class GuestHelpers {
  static formatUnsafeNotes(unsafe: string): string {
    return unsafe
      .trim()
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#039;")
      .replace(/\n/g, "<br/>");
  }

  static emailSent(guest: Guest, type: EmailType) {
    const key = `${type.toLowerCase()}Sent` as keyof Guest;
    return guest[key] as boolean;
  }

  static displayName(guest: Guest) {
    return `${guest.firstName} ${guest.lastName}`;
  }

  static status(guest: Guest) {
    switch (guest.status) {
      case GuestStatus.Unverified:
        return "Not verified";
      case GuestStatus.Verified:
        return "Verified";
      case GuestStatus.Invited:
        return "Invited";
      case GuestStatus.Backup:
        return "Backup";
      case GuestStatus.Canceled:
        return "Canceled";
      case GuestStatus.Paid:
        return "Paid";
    }
  }

  static statusClass(guest: Guest) {
    switch (guest.status) {
      case GuestStatus.Verified:
      case GuestStatus.Invited:
      case GuestStatus.Paid:
        return "positive";
      case GuestStatus.Canceled:
        return "negative";
    }
  }

  static sex(guest: Guest) {
    switch (guest.sex) {
      case Gender.Female:
        return "Female";
      case Gender.Male:
        return "Male";
      default:
        return "Apache Helicopter";
    }
  }
}
