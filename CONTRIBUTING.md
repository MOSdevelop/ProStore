# 📖 Hoe apps toevoegen aan ProStore

## Stappen

### 1️⃣ Maak een app-map
```bash
mkdir apps/jouw-app-naam
```

### 2️⃣ Voeg app-bestanden toe
- `app.json` - Metadata van je app
- `index.html` - Startpunt (optioneel)
- `README.md` - Documentatie

### 3️⃣ Update apps.json
Voeg je app toe aan `apps.json`:

```json
{
  "id": 2,
  "name": "Jouw App",
  "description": "Beschrijving",
  "version": "1.0.0",
  "author": "Jouw naam",
  "category": "Categorie",
  "path": "apps/jouw-app-naam",
  "icon": "📱"
}
```

### 4️⃣ Commit en push
```bash
git add .
git commit -m "Add: Jouw App"
git push
```

## 📋 App-structuur voorbeeld

```
apps/jouw-app/
├── app.json
├── index.html
├── README.md
├── assets/
│   ├── style.css
│   └── script.js
└── docs/
    └── guide.md
```

## ✅ Checklist

- [ ] App-map aangemaakt
- [ ] app.json ingevuld
- [ ] apps.json geüpdatet
- [ ] README.md geschreven
- [ ] Gecommit en gepusht

Succes! 🎉
