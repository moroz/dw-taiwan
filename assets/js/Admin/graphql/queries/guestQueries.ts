export const GUEST_DETAILS = `
fragment GuestDetails on Guest {
  id firstName lastName city residence nationality
  notes email referenceName referenceEmail sex
  status insertedAt confirmationSent backupSent
  audits {
    userName description timestamp
  }
  adminNotes {
    userName body timestamp
  }
}
`;

export const SINGLE_GUEST_QUERY = `
${GUEST_DETAILS}
query guest($id: ID!) {
  guest(id: $id) { ...GuestDetails }
}`;

export const ADD_GUEST_NOTE = `
${GUEST_DETAILS}
mutation createNote($guestId: ID!, $body: String!) {
  createNote(guestId: $guestId, body: $body) {
    success
    guest { ...GuestDetails }
    message
  }
}
`;

export const CHANGE_GUEST_STATUS = `
${GUEST_DETAILS}
  mutation transitionGuestState($id: ID!, $toState: GuestStatus!) {
    transition(id: $id, toState: $toState) {
      success message
      guest { ...GuestDetails }
    }
  }
`;

export const GUEST_LIST_QUERY = `
query guests($params: GuestSearchParams) {
  guests(params: $params) {
    entries {
      firstName lastName id status
      residence nationality city
    }
    cursor {
      totalEntries totalPages page pageSize
    }
  }
}`;

export const SEND_EMAIL = `
${GUEST_DETAILS}
mutation sendEmail($type: EmailType!, $id: ID!, $force: Boolean!) {
  sendEmail(type: $type, id: $id, force: $force) {
    success
    guest { ...GuestDetails }
    message
  }
}`;
