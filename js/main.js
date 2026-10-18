// ---------------------------------------------------------------
// Instellingen — pas hier het e-mailadres aan waar formulieren
// naartoe moeten. Het formulier opent het e-mailprogramma van de
// bezoeker met een ingevuld bericht (werkt zonder server, dus ook
// op GitHub Pages).
// ---------------------------------------------------------------
const EMAIL = "info@elektro-achterhoek.nl";

// Mobiel menu
const toggle = document.querySelector(".nav-toggle");
const nav = document.querySelector(".nav");
if (toggle && nav) {
  toggle.addEventListener("click", () => {
    const open = nav.classList.toggle("open");
    toggle.setAttribute("aria-expanded", open);
  });
}

// Huidige pagina markeren in het menu
const here = location.pathname.split("/").pop() || "index.html";
document.querySelectorAll(".nav a").forEach((a) => {
  if (a.getAttribute("href") === here) a.setAttribute("aria-current", "page");
});

// E-mailadres invullen waar nodig
document.querySelectorAll("[data-email]").forEach((el) => {
  el.textContent = EMAIL;
  el.href = "mailto:" + EMAIL;
});

// Formulieren -> mailto
document.querySelectorAll("form.contact").forEach((form) => {
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const data = new FormData(form);
    const lines = [];
    for (const [key, value] of data.entries()) {
      if (key !== "onderwerp" && value) lines.push(`${key}: ${value}`);
    }
    const subject = data.get("onderwerp") || "Bericht via website";
    location.href =
      `mailto:${EMAIL}?subject=${encodeURIComponent(subject)}` +
      `&body=${encodeURIComponent(lines.join("\n"))}`;
  });
});

// Jaartal in footer
document.querySelectorAll("[data-year]").forEach((el) => (el.textContent = new Date().getFullYear()));
