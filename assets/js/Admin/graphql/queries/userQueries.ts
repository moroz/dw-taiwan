const USER_DETAILS = `
fragment UserDetails on User {
  id email displayName avatarUrl
  admin human
}`;

export const FETCH_USER_QUERY = `
${USER_DETAILS}
{ currentUser { ...UserDetails } }
`;

export const LIST_USERS_QUERY = `
${USER_DETAILS}
{ listUsers { ...UserDetails } }
`;

export const GET_USER_QUERY = `
${USER_DETAILS}
query getUser($id: ID!) {
  user(id: $id) { ...UserDetails insertedAt updatedAt }
}`;
