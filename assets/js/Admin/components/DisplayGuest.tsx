import React, { SyntheticEvent } from "react";
import { History } from "history";
import Topbar from "../layout/Topbar";

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

export default class DisplayGuest extends React.Component<Props> {
  goBack = (e: SyntheticEvent) => {
    e.preventDefault();
    this.props.history.goBack();
  };

  render() {
    return (
      <>
        <Topbar title={`Guest: George Soros`} />
        <div className="card ui display_guest">
          <a onClick={this.goBack}>&lt;&lt; Back to list</a>
          <table className="ui table celled">
            <tbody>
              <Row title="Email:" content="george@soros.eu" />
              <Row title="Nationality:" content="Hungary" />
              <Row title="Living in:" content="Moscow" />
              <Row title="Reference" content="Dupa" />
              <tr>
                <td colSpan={2}>Notes:</td>
              </tr>
              <tr>
                <td colSpan={2}>I am the golden god!</td>
              </tr>
            </tbody>
          </table>
        </div>
      </>
    );
  }
}
