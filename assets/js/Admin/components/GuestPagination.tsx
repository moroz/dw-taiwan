import React from "react";
import ReactPaginate from "react-paginate";
import { Cursor } from "../types/common";
import { History } from "history";
import Search from "../actions/Search";

interface Props extends React.Props<GuestPagination> {
  cursor: Cursor | null;
  history: History;
}

export default class GuestPagination extends React.Component<Props> {
  handlePageChange = (data: any) => {
    let page = data.selected;
    if (typeof page !== "number") page = 0;
    Search.setSearchParams({ page: page + 1 }, this.props.history);
  };

  render() {
    if (!this.props.cursor) return null;

    const { totalPages, page: pageNumber } = this.props.cursor;
    return (
      <ReactPaginate
        containerClassName="ui pagination menu"
        pageLinkClassName="item"
        activeLinkClassName="active"
        previousLinkClassName="item"
        nextLinkClassName="item"
        forcePage={pageNumber - 1}
        breakLinkClassName="item"
        initialPage={pageNumber - 1}
        pageCount={totalPages}
        pageRangeDisplayed={12}
        onPageChange={this.handlePageChange}
        marginPagesDisplayed={2}
      />
    );
  }
}
