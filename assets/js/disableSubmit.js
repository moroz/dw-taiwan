export default function disableSubmit() {
  document.querySelectorAll("form").forEach(form => {
    const submit = form.querySelector("input[type='submit'], button[type='submit']");
    form.addEventListener("submit", () => {
      submit.disabled = true;
    })
  })
}
