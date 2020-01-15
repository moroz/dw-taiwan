import { useState, useEffect } from "react";
import gql from "./client";

interface IUseQueryState {
  loading: boolean;
  data: null | any;
}

export default function useQuery(query: string, variables: Object = {}) {
  const [state, setState] = useState({
    data: null,
    loading: true
  });

  useEffect(() => {
    gql.query(query, variables).then(data => {
      setState({ data, loading: false });
    });
  }, []);

  return state as IUseQueryState;
}
