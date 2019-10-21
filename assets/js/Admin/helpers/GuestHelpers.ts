import { Guest, Gender, GuestStatus } from "../types/guests";

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

  static status(guest: Guest) {
    switch (guest.status) {
      case GuestStatus.Unverified:
        return "Not verified";
      case GuestStatus.Verified:
        return "Identity verified";
      case GuestStatus.Invited:
        return "Invited";
      case GuestStatus.Backup:
        return "Backup List";
      case GuestStatus.Canceled:
        return "Rejected or canceled";
      case GuestStatus.Paid:
        return "Paid";
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
