# Script d'installation automatique pour le Backend IPMF (PowerShell)

Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host "🚀 Initialisation de l'installation du Backend IPMF" -ForegroundColor Cyan
Write-Host "--------------------------------------------------" -ForegroundColor Cyan

# 1. Vérification du dossier courant
if (Test-Path "ipmf") {
    Set-Location "ipmf"
}

# 2. Création de l'environnement virtuel si nécessaire
if (-not (Test-Path "mon_env")) {
    Write-Host "📦 Création de l'environnement virtuel 'mon_env'..." -ForegroundColor Yellow
    python -m venv mon_env
} else {
    Write-Host "✅ Environnement virtuel 'mon_env' déjà présent." -ForegroundColor Green
}

# 3. Activation de l'environnement virtuel
Write-Host "🔌 Activation de l'environnement virtuel..." -ForegroundColor Yellow
.\mon_env\Scripts\activate.ps1

# 4. Installation des dépendances
Write-Host "📥 Installation des dépendances depuis requirements.txt..." -ForegroundColor Yellow
python -m pip install --upgrade pip
pip install -r requirements.txt

# 5. Création de la base de données (PostgreSQL)
Write-Host "🗄️ Création de la base de données (si PostgreSQL est configuré)..." -ForegroundColor Yellow
python create_db.py

# 6. Exécution des migrations Django
Write-Host "🛠️ Exécution des migrations Django..." -ForegroundColor Yellow
python manage.py migrate

# 7. Création des utilisateurs de test
Write-Host "👤 Création des utilisateurs (admin_test, agent_test)..." -ForegroundColor Yellow
python create_users.py

Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host "✅ Installation terminée !" -ForegroundColor Green
Write-Host "Pour lancer le serveur, exécutez :" -ForegroundColor White
Write-Host "cd ipmf; .\mon_env\Scripts\activate; python manage.py runserver" -ForegroundColor White
Write-Host "--------------------------------------------------" -ForegroundColor Cyan
