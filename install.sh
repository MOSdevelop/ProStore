#!/bin/bash

# ProStore macOS App Installer
# Dit maakt een echte macOS app aan

APP_NAME="ProStore"
APP_DIR="$HOME/Applications/$APP_NAME.app"
CONTENTS_DIR="$APP_DIR/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"

# Verwijder oude versie
if [ -d "$APP_DIR" ]; then
    rm -rf "$APP_DIR"
    echo "🗑️  Oude versie verwijderd"
fi

# Maak directory structuur
mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

echo "📁 App structuur aangemaakt..."

# Maak Info.plist
cat > "$CONTENTS_DIR/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>ProStore</string>
    <key>CFBundleIdentifier</key>
    <string>com.mosdevelop.prostore</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>ProStore</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.13</string>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
</dict>
</plist>
EOF

echo "✓ Info.plist aangemaakt"

# Maak launcher script
cat > "$MACOS_DIR/ProStore" << 'EOF'
#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RESOURCES="$DIR/../Resources"
open -a "Google Chrome" "file://$RESOURCES/index.html" || open -a "Safari" "file://$RESOURCES/index.html"
EOF

chmod +x "$MACOS_DIR/ProStore"
echo "✓ Launcher script aangemaakt"

# Download de web app en sla op
cat > "$RESOURCES_DIR/index.html" << 'WEBAPPEOF'
<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProStore - App Store</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        header {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        h1 {
            color: #667eea;
            font-size: 48px;
            margin-bottom: 10px;
        }
        
        .subtitle {
            color: #666;
            font-size: 18px;
        }
        
        .apps-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .app-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .app-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
        }
        
        .app-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
        
        .app-name {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .app-description {
            color: #666;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 15px;
        }
        
        .app-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #eee;
            font-size: 12px;
            color: #999;
        }
        
        .install-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 15px;
        }
        
        .install-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        
        .add-app-section {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .add-app-btn {
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 15px 40px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .add-app-btn:hover {
            background: #764ba2;
            transform: scale(1.05);
        }
        
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal.active {
            display: flex;
        }
        
        .modal-content {
            background: white;
            border-radius: 12px;
            padding: 30px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }
        
        .modal-header {
            font-size: 24px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 500;
        }
        
        input, textarea, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
        }
        
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        
        .modal-buttons {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }
        
        .btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-primary:hover {
            background: #764ba2;
        }
        
        .btn-secondary {
            background: #eee;
            color: #333;
        }
        
        .btn-secondary:hover {
            background: #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>🚀 ProStore</h1>
            <p class="subtitle">Jouw persoonlijke App Store</p>
        </header>
        
        <div class="apps-grid" id="appsGrid">
            <!-- Apps worden hier ingeladen -->
        </div>
        
        <div class="add-app-section">
            <h2 style="margin-bottom: 20px; color: #333;">➕ Voeg een app toe</h2>
            <button class="add-app-btn" onclick="openAddAppModal()">Nieuwe App Toevoegen</button>
        </div>
    </div>
    
    <!-- Modal voor app toevoegen -->
    <div class="modal" id="addAppModal">
        <div class="modal-content">
            <div class="modal-header">Nieuwe App</div>
            <div class="form-group">
                <label>App Naam</label>
                <input type="text" id="appName" placeholder="Bijv: Mijn Cool App">
            </div>
            <div class="form-group">
                <label>Beschrijving</label>
                <textarea id="appDescription" placeholder="Wat doet deze app?"></textarea>
            </div>
            <div class="form-group">
                <label>Icon (emoji)</label>
                <input type="text" id="appIcon" placeholder="Bijv: 📱" maxlength="2">
            </div>
            <div class="form-group">
                <label>Categorie</label>
                <select id="appCategory">
                    <option>Productiviteit</option>
                    <option>Games</option>
                    <option>Tools</option>
                    <option>Educatie</option>
                    <option>Design</option>
                    <option>Web</option>
                    <option>Systeem</option>
                </select>
            </div>
            <div class="form-group">
                <label>Download Link (optioneel)</label>
                <input type="url" id="appLink" placeholder="https://...">
            </div>
            <div class="modal-buttons">
                <button class="btn btn-primary" onclick="addApp()">Toevoegen</button>
                <button class="btn btn-secondary" onclick="closeAddAppModal()">Annuleren</button>
            </div>
        </div>
    </div>

    <script>
        let apps = JSON.parse(localStorage.getItem('prostore_apps')) || [
            {
                id: 1,
                icon: '🎵',
                name: 'Music Player',
                description: 'Luister naar je favoriete nummers',
                version: '1.0.0',
                category: 'Media',
                link: '#'
            },
            {
                id: 2,
                icon: '✏️',
                name: 'Notes App',
                description: 'Snel notities maken en opslaan',
                version: '1.0.0',
                category: 'Productiviteit',
                link: '#'
            },
            {
                id: 3,
                icon: '🎮',
                name: 'Quick Game',
                description: 'Een simpel browser game',
                version: '1.0.0',
                category: 'Games',
                link: '#'
            }
        ];

        function renderApps() {
            const grid = document.getElementById('appsGrid');
            grid.innerHTML = apps.map(app => `
                <div class="app-card">
                    <div class="app-icon">${app.icon}</div>
                    <div class="app-name">${app.name}</div>
                    <div class="app-description">${app.description}</div>
                    <div class="app-meta">
                        <span>${app.category}</span>
                        <span>v${app.version}</span>
                    </div>
                    <button class="install-btn" onclick="installApp('${app.name}')">
                        Installeren
                    </button>
                </div>
            `).join('');
        }

        function openAddAppModal() {
            document.getElementById('addAppModal').classList.add('active');
        }

        function closeAddAppModal() {
            document.getElementById('addAppModal').classList.remove('active');
        }

        function addApp() {
            const name = document.getElementById('appName').value;
            const description = document.getElementById('appDescription').value;
            const icon = document.getElementById('appIcon').value || '📱';
            const category = document.getElementById('appCategory').value;
            const link = document.getElementById('appLink').value || '#';

            if (!name || !description) {
                alert('Vul naam en beschrijving in!');
                return;
            }

            const newApp = {
                id: apps.length + 1,
                icon,
                name,
                description,
                version: '1.0.0',
                category,
                link
            };

            apps.push(newApp);
            localStorage.setItem('prostore_apps', JSON.stringify(apps));
            
            document.getElementById('appName').value = '';
            document.getElementById('appDescription').value = '';
            document.getElementById('appIcon').value = '';
            document.getElementById('appCategory').value = 'Productiviteit';
            document.getElementById('appLink').value = '';
            
            closeAddAppModal();
            renderApps();
            alert(`✅ ${name} toegevoegd!`);
        }

        function installApp(appName) {
            alert(`📥 ${appName} geïnstalleerd!\n\nDit is een demo. In een echte app zou deze hier worden gedownload en geïnstalleerd.`);
        }

        // Sluit modal als je buiten klikt
        document.getElementById('addAppModal').addEventListener('click', function(e) {
            if (e.target === this) closeAddAppModal();
        });

        // Laad apps bij startup
        renderApps();
    </script>
</body>
</html>
WEBAPPEOF

echo "✓ Web app gedownload"

# Maak het app uitvoerbaar
chmod -R 755 "$APP_DIR"

echo ""
echo "✅ ProStore is geïnstalleerd!"
echo "📍 Location: $APP_DIR"
echo ""
echo "🚀 ProStore starten:"
echo "   open $APP_DIR"
echo ""
echo "💡 Je kunt ProStore ook vinden in Spotlight (Cmd+Space) of in Applications"
