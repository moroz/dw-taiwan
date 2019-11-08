import React from "react";
import { connect } from "react-redux";
import { IReduxState } from "../reducers";
import Message, { LogLevel } from "./Message";

interface Props extends React.Props<FlashMessages> {
  message: string | null;
  success: boolean;
}

class FlashMessages extends React.Component<Props> {
  render() {
    const { message, success } = this.props;
    if (!message) return;
    const level = success ? LogLevel.Success : LogLevel.Error;
    return <Message message={message} level={level} />;
  }
}

function mapState(state: IReduxState) {
  return {
    success: state.status.success,
    message: state.status.message
  };
}

export default connect(mapState)(FlashMessages);
