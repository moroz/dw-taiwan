import { useState, useEffect } from "react";
import gql from "./client";

export interface IWithQueryParams {
  query: string;
  variables: Object;
}

export default function withQuery({ query, variables }: IWithQueryParams) {
  const [state, setState] = useState({
    data: null,
    loading: true
  });

  useEffect(() => {
    gql.query(query, variables).then(data => {
      setState({ data, loading: false });
    });
  }, [query, variables]);

  return state;
}
