# Elektro Achterhoek – website

Statische website (HTML/CSS/JS, geen build-stap nodig), nagebouwd van de WordPress-site elektro-achterhoek.nl.

## Structuur

```
index.html      Home
diensten.html   Diensten
over.html       Over
faq.html        Veelgestelde vragen
contact.html    Contact
boeking.html    Afspraak aanvragen
css/style.css   Alle opmaak (kleuren staan bovenaan als variabelen)
js/main.js      Menu, formulieren en het e-mailadres (EMAIL bovenaan)
images/         Afbeeldingen
```

## Lokaal bekijken

```powershell
powershell -ExecutionPolicy Bypass -File serve.ps1
```

Open daarna http://localhost:8080. Je kunt `index.html` ook direct dubbelklikken.

## Contactformulier

GitHub Pages heeft geen server, dus het formulier opent het e-mailprogramma van de bezoeker met een ingevuld bericht.
Het e-mailadres staat bovenaan in `js/main.js`.

## Publiceren via GitHub Pages

1. Maak een repository aan op GitHub en push deze map.
2. Ga naar **Settings → Pages**, kies **Deploy from a branch**, branch `main`, map `/ (root)`.
3. De site staat na een minuut op `https://<gebruikersnaam>.github.io/<repo>/`.
4. Eigen domein (elektro-achterhoek.nl): vul het in bij **Settings → Pages → Custom domain** en zet bij de domeinprovider de DNS-records zoals GitHub aangeeft.
