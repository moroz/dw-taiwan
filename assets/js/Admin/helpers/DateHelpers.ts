import dayjs from "dayjs";

export default class DateHelpers {
  static timestamp(date: string) {
    if (!date) return "";
    const parsed = this.parse(date);
    const offset = parsed.utcOffset() / 60;
    return this.parse(date).format("YYYY-MM-DD HH:mm");
  }

  static tzname() {
    return Intl.DateTimeFormat().resolvedOptions().timeZone;
  }

  private static parse(str: string) {
    if (str.match(/Z$/)) {
      return dayjs(str);
    } else {
      return dayjs(`${str}Z`);
    }
  }
}
