import React from "react";
import Topbar from "../layout/Topbar";
import MainWrapper from "../layout/MainWrapper";
import CardSection from "../components/CardSection";

export default function(_props: any) {
  return (
    <div className="card ui help card--normal-size">
      <CardSection padded>
        <h1>Help (updated 2019-10-21)</h1>
        <p>
          This page covers the basic informations that you may find useful when
          using the Taipei Mahamudra Management System.
        </p>
        <h2>Guest verification statuses</h2>
        <p>
          In the single guest view, in the cell named <strong>Status</strong>,
          you may see several different values. It is important that you
          understand what each of these values means. Every time you perform an{" "}
          <strong>action</strong> on a guest record, e.g. confirm that you know
          the person or that they are entitled to purchase tickets, their status
          changes and an <em>audit</em> is stored in the database, along with
          the timestamp, your ID, and a brief description of the changes. These
          records will be displayed in the single guest view in the{" "}
          <strong>History</strong> section.
        </p>
        <p>
          The status is stored in the database as a number, and that number is
          given in brackets next to each state's name.
        </p>
        <p>
          <strong>Unverified (0)</strong> &mdash; this is the default value for
          the status field. It means that as of now, no action whatsoever has
          been performed on this record.
        </p>
        <p>
          <strong>Verified (1)</strong> &mdash; the identity of a potential
          guest has been successfully verified, but they have not yet been
          approved for ticketing.
        </p>
        <p>
          <strong>Invited (2)</strong> &mdash; the identitif of a potential
          guest has been successfully verified, <strong>and</strong> they are
          free to purchase tickets once the ticketing system has been made
          available.
        </p>
        <p>
          <strong>Backup (3)</strong> &mdash; the identity of a potential guest
          has been confirmed, but there is no basis for them to join the course,
          i.e. they are not from the Far East Sangha, they are not going to
          attend the Glentui course, they have not been invited personally by
          Lama Ole, and they are not a guest of special merit. They may still
          purchase a ticket if a place on the waiting list becomes free.
        </p>
        <p>
          <strong>Canceled (4)</strong> &mdash; the potential guest has already
          been invited, but they missed a deadline or rejected the invitation.
        </p>
        <p>
          <strong>Paid (5)</strong> &mdash; identity confirmed, payment
          succesful. Going to the course. The guest may still request a refund
          and cancel their attendance.
        </p>
      </CardSection>
    </div>
  );
}
