import { Guest, Gender } from "../types/guests";

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
