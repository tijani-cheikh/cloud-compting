# Projet prêt à tester — demo Node + ngrok

Ce dépôt minimal contient une application Express prête à être testée en local, sur le LAN et via ngrok.

Fichiers inclus
- `index.js` : application Express (routes `/` et `/health`)
- `package.json` : dépendances et script start
- `Dockerfile` : build image Node
- `docker-compose.yml` : pour lancer en container
- `install-ngrok.sh` : installe ngrok (si besoin) et démarre un tunnel vers le port configuré
- `myapp.service` et `ngrok.service` : exemples systemd
- `.env.example` : variables d'environnement

Prérequis
- Node >= 16 (ou Docker)
- Pour ngrok : un compte (https://ngrok.com) et ton authtoken

Exécution locale
1. Installer dépendances
   ```bash
   npm install
   ```
2. Lancer l'app
   ```bash
   npm start
   ```
3. Ouvrir : http://localhost:3000
   - Pour le LAN : trouver l'IP de la VM (`hostname -I`) et ouvrir `http://<IP_VM>:3000`

Docker
1. Construire et lancer
   ```bash
   docker-compose up --build
   ```
2. Accéder : http://localhost:3000 (ou `http://<IP_VM>:3000` si sur VM)

Ngrok (mode démonstration)
1. Récupérer ton authtoken sur https://dashboard.ngrok.com/get-started/your-authtoken
2. Rendre le script exécutable et l'appeler :
   ```bash
   chmod +x install-ngrok.sh
   ./install-ngrok.sh <TON_AUTHTOKEN>
   ```
3. Le script installe ngrok (si absent), configure le token, et démarre `ngrok http 3000`.
4. Ngrok affichera une URL publique HTTPS (ex. https://abcd-1234.ngrok.io). Ouvre-la depuis n’importe où.

Services systemd (optionnel)
- `myapp.service` et `ngrok.service` sont fournis en exemple : adapte `User=`, `WorkingDirectory=`, `ExecStart=` et le token ngrok avant de les copier dans `/etc/systemd/system/`.

Sécurité / bonnes pratiques
- Pour démos publiques : protège le tunnel (ngrok `--auth`) ou limite la durée.
- Ne publie pas de données sensibles en clair.
- Pour usage prolongé, configure un reverse proxy + certificats ou une réservation de domaine ngrok (plan payant).

Besoin d’aide pour push/PR ou pour adapter ce projet à une autre stack ? Dis‑moi et je te guide pas‑à‑pas.
