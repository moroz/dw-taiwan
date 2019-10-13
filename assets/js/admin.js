import React from "react";
import ReactDOM from "react-dom";
import MahamudraAdmin from "./Admin/index";
import "../css/semantic.less";
import style from "../css/admin/admin.sass";

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("app");
  container && ReactDOM.render(<MahamudraAdmin />, container);
});
