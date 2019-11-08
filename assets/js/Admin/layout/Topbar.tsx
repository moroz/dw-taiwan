import React from "react";
import { connect } from "react-redux";
import { IReduxState } from "../reducers";
import Search from "../actions/Search";
import { History } from "history";
import { withRouter } from "react-router";

interface Props {
  term: string;
  location: any;
  history: History;
}

class Topbar extends React.Component<Props> {
  state = {
    term: ""
  };

  handleSubmit = (e: any) => {
    e.preventDefault();
    this.submit();
  };

  submit = () => {
    const { term } = this.state;
    Search.setSearchParams({ term }, this.props.history);
  };

  componentDidMount() {
    const { term } = Search.getInitialParams(this.props.location);
    this.setState({ term });
  }

  handleChange = (e: any) => {
    const { value } = e.target;
    this.setState({ term: value }, () => {
      if (!value) this.submit();
    });
  };

  render() {
    return (
      <div className="admin__topbar">
        <form
          id="searchForm"
          className="topbar__search"
          autoComplete="off"
          onSubmit={this.handleSubmit}
        >
          <input
            type="text"
            name="term"
            placeholder="Search..."
            className="topbar__search__input"
            autoFocus
            autoComplete="off"
            onChange={this.handleChange}
            value={this.state.term}
          ></input>
          <img src="/images/search.svg" className="topbar__search__icon"></img>
        </form>
      </div>
    );
  }
}

function mapState(state: IReduxState) {
  return {
    term: state.guests.params.term
  };
}

export default connect(mapState)(withRouter(Topbar));
