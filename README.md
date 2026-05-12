# 🏥 Intubation App - Gestion de Bloc Opératoire

**Intubation App** est une application mobile développée avec le framework **Flutter**. Elle est spécialement conçue pour assister le personnel médical au bloc opératoire dans la gestion, le suivi, et l'archivage des procédures d'intubation.

Ce projet a été réalisé dans le cadre de l'examen TP (Mini-Projet) pour le module de développement Mobile.

---

## ✨ Fonctionnalités Principales

L'application couvre l'ensemble du flux de travail médical, de l'identification du patient à la génération du compte-rendu PDF :

*   **🔐 Authentification Sécurisée** : Système de création de compte et de connexion avec hachage des mots de passe (SHA-256).
*   **👥 Gestion des Patients (CRUD)** : Création et recherche filtrée de patients. Chaque dossier inclut le nom, le sexe, la date de naissance et le calcul du BMI.
*   **📝 Formulaire d'Intubation (6 Étapes)** :
    *   **Étape 1 : Antécédents** (SAOS, Diabète, Goitre, autres).
    *   **Étape 2 : Évaluation** (Score ASA, Mallampati, DTM, Ouverture buccale).
    *   **Étape 3 : Risque** (Évaluation de la difficulté prévue).
    *   **Étape 4 : Per-intubation** (Type d'intubation, tentatives, utilisation du vidéo-laryngoscope, Score de Cormack).
    *   **Étape 5 : Complications** (Déclaration d'intubation difficile, champ libre).
    *   **Étape 6 : Données Multimédias** (Intégration d'appareil photo pour archiver des photos cliniques, simulation de mémo vocal).
*   **💾 Persistance des Données Hors-Ligne** : Intégration complète d'une base de données locale **SQLite** garantissant le fonctionnement sans connexion internet (indispensable dans les environnements hospitaliers).
*   **📄 Génération de Rapports PDF** : Création automatique d'un rapport PDF clinique résumant toutes les données saisies, consultable directement depuis l'application via le package `printing`.

---

## 🛠️ Architecture Technique

Le projet adopte le pattern de gestion d'état **Provider** pour une séparation propre entre l'interface (UI) et la logique métier.

*   **Modèles (`/models`)** : `User`, `Patient`, `Intubation`.
*   **Fournisseurs d'état (`/providers`)** : `AuthProvider`, `PatientProvider`, `IntubationProvider`.
*   **Services (`/services`)** : `DatabaseService` (SQLite), `AuthService` (Crypto), `PdfService` (Génération PDF).
*   **Interface (`/screens`)** : Tableaux de bord dynamiques, formulaires interactifs segmentés, validation des données avec le widget `Form`.

---

## 📦 Dépendances Utilisées

Ce projet s'appuie sur plusieurs paquets clés :
*   `provider`: Gestion d'état.
*   `sqflite` & `sqflite_common_ffi_web`: Base de données locale compatible Mobile, Desktop et Web.
*   `pdf` & `printing`: Mise en page graphique et visualisation des rapports PDF interactifs.
*   `image_picker`: Accès sécurisé à la caméra de l'appareil.
*   `crypto`: Sécurisation et hachage des accès utilisateurs.

---

## 🚀 Comment exécuter l'application ?

Le projet est configuré de façon à pouvoir tourner sur les navigateurs Web (Chrome), ce qui facilite la correction et la présentation, mais reste 100% compatible Android/iOS.

1. **Cloner le projet**
   ```bash
   git clone https://github.com/ademlasmer/Projet_Mobile.git
   cd Projet_Mobile
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Générer les "Web Workers" pour SQLite (requis pour le Web)**
   ```bash
   dart run sqflite_common_ffi_web:setup
   ```

4. **Lancer l'application**
   ```bash
   flutter run -d chrome
   ```

---

## 👤 Auteur
**Adem Lasmer**
Projet d'Examen TP - Développement Mobile (ISIMG)
