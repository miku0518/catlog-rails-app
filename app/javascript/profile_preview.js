document.addEventListener("DOMContentLoaded", () => {
  const avatarInput = document.getElementById("avatar-input");
  const avatarPreview = document.getElementById("avatar-preview");

  if (!avatarInput || !avatarPreview) return;

  avatarInput.addEventListener("change", (e) => {
    const file = e.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (ev) => {
      avatarPreview.src = ev.target.result;
    };
    reader.readAsDataURL(file);
  });
});
