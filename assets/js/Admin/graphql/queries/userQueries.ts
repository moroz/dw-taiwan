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
