const GRAPHQL_URI = "/api";

export default class GraphQLClient {
  static async query(query: string, variables: Object = {}) {
    try {
      const { data } = await fetch(GRAPHQL_URI, {
        method: "POST",
        credentials: "include",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          query,
          variables
        })
      }).then(res => res.json());
      return data;
    } catch (e) {
      console.error(e);
    }
  }
}
