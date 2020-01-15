import { useState, useEffect } from "react";
import gql from "./client";

export default function withQuery(query: string, variables: Object = {}) {
  const [state, setState] = useState({
    data: null,
    loading: true
  });

  useEffect(() => {
    gql.query(query, variables).then(data => {
      setState({ data, loading: false });
    });
  }, []);

  return state;
}
