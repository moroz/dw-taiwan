// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.sass";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

function setNavbarOpacityClass() {
  const navigation = document.getElementById("navbar");
  if (navigation && window.pageYOffset > navigation.clientHeight) {
    navigation.classList.add("navbar--opaque");
  } else {
    navigation.classList.remove("navbar--opaque");
  }
}

function setOffCanvasOpenClass(e) {
  if (!e || !e.target) return;
  const offcanvas = document.getElementById("offcanvas");
  offcanvas &&
    offcanvas.classList.toggle("navbar__menu--open", e.target.checked);
  const navigation = document.getElementById("navbar");
  if (e.target.checked && navigation)
    navigation.classList.toggle("navbar--opaque", e.target.checked);
  else setNavbarOpacityClass();
}

document.addEventListener("DOMContentLoaded", () => {
  window.addEventListener("scroll", setNavbarOpacityClass);
  setNavbarOpacityClass();
  const hamburger = document.getElementById("hamburgerToggle");
  hamburger && hamburger.addEventListener("change", setOffCanvasOpenClass);
});
