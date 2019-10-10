import React from "react";
import ReactDOM from "react-dom";
import MahamudraAdmin from "./Admin/index";

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("app");
  container && ReactDOM.render(<MahamudraAdmin />, container);
});
