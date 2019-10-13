import React, { SyntheticEvent } from "react";
import { History } from "history";
import Topbar from "../layout/Topbar";
import client from "../graphql/client";

interface Props extends React.Props<DisplayGuest> {
  history: History;
}

const Row = ({ title, content }: any) => {
  return (
    <tr>
      <th scope="row">{title}</th>
      <td>{content}</td>
    </tr>
  );
};

const QUERY = `
query guest($id: ID!) {
  guest(id: $id) {
    id firstName lastName city residence nationality
    notes email referenceName referenceEmail
  }
}
`;

export default class DisplayGuest extends React.Component<Props> {
  state = {
    guest: null,
    loading: true
  };

  goBack = (e: SyntheticEvent) => {
    e.preventDefault();
    this.props.history.goBack();
  };

  async componentDidMount() {
    try {
      const id = this.props.match.params.id;
      const { guest } = await client.query(QUERY, { id });
      this.setState({ guest, loading: false });
    } catch (e) {
      console.error(e);
    }
  }

  render() {
    const { guest } = this.state;
    const title = guest
      ? `Guest: ${guest.firstName} ${guest.lastName}`
      : "Loading Guest";
    return (
      <>
        <Topbar title={title} />
        {guest ? (
          <div className="card ui display_guest">
            <a onClick={this.goBack}>&lt;&lt; Back to list</a>
            <table className="ui table celled">
              <tbody>
                <Row title="Email:" content={guest.email} />
                <Row title="Nationality:" content={guest.nationality} />
                <Row title="Living in:" content={guest.city} />
                <Row
                  title="Reference"
                  content={`${guest.referenceName} <${guest.referenceEmail}>`}
                />
                {guest.notes ? (
                  <>
                    <tr>
                      <td colSpan={2}>Notes:</td>
                    </tr>
                    <tr>
                      <td colSpan={2}>{guest.notes}</td>
                    </tr>
                  </>
                ) : null}
              </tbody>
            </table>
          </div>
        ) : null}
      </>
    );
  }
}
