import React from "react";
import ReactPaginate from "react-paginate";
import { Cursor } from "../types/common";
import { History } from "history";

interface Props extends React.Props<GuestPagination> {
  cursor: Cursor | null;
  history: History;
}

export default class GuestPagination extends React.Component<Props> {
  handlePageChange = (data: any) => {
    let page = data.selected;
    if (typeof page !== "number") page = 0;
    this.props.history.push(`/?page=${page + 1}`);
  };

  render() {
    if (!this.props.cursor) return null;

    const { totalPages } = this.props.cursor;
    return (
      <ReactPaginate
        containerClassName="ui pagination menu"
        pageLinkClassName="item"
        activeLinkClassName="active"
        previousLinkClassName="item"
        nextLinkClassName="item"
        breakLinkClassName="item"
        pageCount={totalPages}
        pageRangeDisplayed={15}
        onPageChange={this.handlePageChange}
        marginPagesDisplayed={2}
      />
    );
  }
}
