#!/bin/bash

# Script d'installation automatique pour le Backend IPMF
# Ce script doit être exécuté depuis la racine du projet ou le dossier ipmf

echo "--------------------------------------------------"
echo "🚀 Initialisation de l'installation du Backend IPMF"
echo "--------------------------------------------------"

# 1. Vérification du dossier courant
if [ -d "ipmf" ]; then
    cd ipmf
fi

# 2. Création de l'environnement virtuel si nécessaire
if [ ! -d "mon_env" ]; then
    echo "📦 Création de l'environnement virtuel 'mon_env'..."
    python -m venv mon_env
else
    echo "✅ Environnement virtuel 'mon_env' déjà présent."
fi

# 3. Activation de l'environnement virtuel
echo "🔌 Activation de l'environnement virtuel..."
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    source mon_env/Scripts/activate
else
    source mon_env/bin/activate
fi

# 4. Installation des dépendances
echo "📥 Installation des dépendances depuis requirements.txt..."
pip install --upgrade pip
pip install -r requirements.txt

# 5. Création de la base de données (PostgreSQL)
echo "🗄️ Création de la base de données (si PostgreSQL est configuré)..."
python create_db.py

# 6. Exécution des migrations Django
echo "🛠️ Exécution des migrations Django..."
python manage.py migrate

# 7. Création des utilisateurs de test
echo "👤 Création des utilisateurs (admin_test, agent_test)..."
python create_users.py

echo "--------------------------------------------------"
echo "✅ Installation terminée !"
echo "Pour lancer le serveur, exécutez :"
echo "cd ipmf && source mon_env/Scripts/activate && python manage.py runserver"
echo "--------------------------------------------------"
