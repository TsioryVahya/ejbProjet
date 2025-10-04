# Système Bancaire - Architecture Distribuée

## 📋 Description du Projet

Système de gestion bancaire distribué utilisant une architecture multi-technologies :
- **Module Central** : Java EE (WildFly) avec servlets/JSP et Tailwind CSS
- **Module Compte Courant** : EJB + JPA (JAR déployable à distance)
- **Module Épargne** : API REST en C# ASP.NET Core
- **Module Prêt** : API REST en C# ASP.NET Core
- **Base de données** : PostgreSQL

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    MODULE CENTRAL                           │
│              (Java EE - WildFly)                           │
│    ┌─────────────────┐  ┌─────────────────┐               │
│    │   Servlets      │  │      JSP        │               │
│    │   Controllers   │  │   + Tailwind    │               │
│    └─────────────────┘  └─────────────────┘               │
└─────────────────────────────────────────────────────────────┘
           │                    │                    │
           ▼                    ▼                    ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│  COMPTE COURANT │  │     ÉPARGNE     │  │      PRÊT       │
│   (EJB Remote)  │  │   (C# API)      │  │   (C# API)      │
│   Port: EJB     │  │   Port: 5001    │  │   Port: 5002    │
└─────────────────┘  └─────────────────┘  └─────────────────┘
           │                    │                    │
           └────────────────────┼────────────────────┘
                               ▼
                    ┌─────────────────┐
                    │   PostgreSQL    │
                    │   Port: 5432    │
                    └─────────────────┘
```

## 🛠️ Prérequis

### Logiciels requis :
- **Java JDK 11+**
- **Maven 3.6+**
- **WildFly 26+**
- **.NET 6 SDK**
- **PostgreSQL 13+**

### Configuration de la base de données :
1. Installer PostgreSQL
2. Créer la base de données `banque_system`
3. Utilisateur : `postgres` / Mot de passe : `admin`
4. Exécuter le script `database/init.sql`

## 🚀 Instructions de Déploiement

### 1. Configuration de WildFly

#### A. Configuration du driver PostgreSQL
```bash
# Créer le répertoire du module
mkdir -p $WILDFLY_HOME/modules/org/postgresql/main

# Copier le driver PostgreSQL
cp postgresql-42.7.3.jar $WILDFLY_HOME/modules/org/postgresql/main/

# Créer module.xml
```

Contenu de `module.xml` :
```xml
<?xml version="1.0" encoding="UTF-8"?>
<module xmlns="urn:jboss:module:1.3" name="org.postgresql">
    <resources>
        <resource-root path="postgresql-42.7.3.jar"/>
    </resources>
    <dependencies>
        <module name="javax.api"/>
        <module name="javax.transaction.api"/>
    </dependencies>
</module>
```

#### B. Configuration de la datasource
Ajouter dans `standalone.xml` :
```xml
<datasource jndi-name="java:jboss/datasources/BanqueDS" pool-name="BanqueDS" enabled="true">
    <connection-url>jdbc:postgresql://localhost:5432/banque_system</connection-url>
    <driver>postgresql</driver>
    <security user-name="postgres" password="admin"/>
</datasource>

<driver name="postgresql" module="org.postgresql">
    <xa-datasource-class>org.postgresql.xa.PGXADataSource</xa-datasource-class>
</driver>
```

### 2. Déploiement du Module Compte Courant (EJB)

```bash
cd compte-courant-ejb
mvn clean package
cp target/compte-courant-ejb-1.0.0.jar $WILDFLY_HOME/standalone/deployments/
```

### 3. Déploiement des APIs C#

#### API Épargne (Port 5001)
```bash
cd epargne-api
dotnet restore
dotnet build
dotnet run
```

#### API Prêt (Port 5002)
```bash
cd pret-api
dotnet restore
dotnet build
dotnet run
```

### 4. Déploiement du Module Central

```bash
cd central-banque
mvn clean package
cp target/central-banque-1.0.0.war $WILDFLY_HOME/standalone/deployments/
```

### 5. Démarrage des Services

```bash
# 1. Démarrer PostgreSQL
sudo systemctl start postgresql

# 2. Démarrer WildFly
$WILDFLY_HOME/bin/standalone.sh

# 3. Démarrer l'API Épargne (terminal séparé)
cd epargne-api && dotnet run

# 4. Démarrer l'API Prêt (terminal séparé)
cd pret-api && dotnet run
```

## 🌐 URLs d'Accès

- **Application Principale** : http://localhost:8080/central-banque
- **API Épargne** : http://localhost:5001 (Swagger disponible)
- **API Prêt** : http://localhost:5002 (Swagger disponible)
- **Console WildFly** : http://localhost:9990

## 📊 Base de Données

### Tables principales :
- `client` - Informations clients
- `compte` - Comptes bancaires
- `operations` - Opérations sur comptes courants
- `depotepargne` / `retraitepargne` - Gestion épargne
- `prets` / `remboursement` - Gestion prêts

### Fonctions PostgreSQL :
- `calculer_solde(idCompte)` - Calcul automatique des soldes
- `creer_compte_avec_solde()` - Création de compte avec solde initial

## 🔧 Fonctionnalités

### Module Compte Courant (EJB)
- ✅ Gestion des clients
- ✅ Création/gestion des comptes
- ✅ Opérations : dépôts, retraits, virements
- ✅ Calcul automatique des soldes
- ✅ Historique des opérations

### Module Épargne (C# API)
- ✅ Dépôts d'épargne avec taux d'intérêt
- ✅ Retraits d'épargne
- ✅ Calcul automatique des intérêts
- ✅ Statistiques d'épargne
- ✅ API REST complète

### Module Prêt (C# API)
- ✅ Demande de prêts
- ✅ Simulation de prêts
- ✅ Calcul d'échéanciers
- ✅ Gestion des remboursements
- ✅ Vérification d'éligibilité
- ✅ Statistiques de prêts

### Interface Web (JSP + Tailwind)
- ✅ Interface moderne et responsive
- ✅ Tableau de bord avec statut des services
- ✅ Gestion complète des comptes
- ✅ Interface épargne intuitive
- ✅ Gestion des prêts avec visualisations
- ✅ Gestion d'erreurs centralisée

## 🧪 Tests et Validation

### Vérification du déploiement :
1. **Base de données** : Vérifier la connexion PostgreSQL
2. **EJB** : Tester l'accès aux services de compte
3. **APIs C#** : Vérifier les endpoints Swagger
4. **Interface** : Naviguer sur l'application web

### Endpoints de santé :
- API Épargne : `GET /api/Epargne/health`
- API Prêt : `GET /api/Pret/health`

## 🐛 Résolution de Problèmes

### Problèmes courants :

#### 1. Erreur de connexion base de données
```bash
# Vérifier PostgreSQL
sudo systemctl status postgresql
# Vérifier les credentials dans standalone.xml
```

#### 2. EJB non trouvé
```bash
# Vérifier le déploiement
ls $WILDFLY_HOME/standalone/deployments/
# Consulter les logs WildFly
tail -f $WILDFLY_HOME/standalone/log/server.log
```

#### 3. APIs C# indisponibles
```bash
# Vérifier les ports
netstat -an | grep -E "5001|5002"
# Redémarrer les APIs
dotnet run --urls="http://localhost:5001"
```

#### 4. Problèmes d'encodage
- Vérifier que le filtre `CharacterEncodingFilter` est actif
- S'assurer que PostgreSQL utilise UTF-8

## 📁 Structure du Projet

```
ejbProjet/
├── compte-courant-ejb/          # Module EJB (JAR)
│   ├── src/main/java/
│   ├── src/main/resources/
│   └── pom.xml
├── epargne-api/                 # API C# Épargne
│   ├── Controllers/
│   ├── Models/
│   ├── Services/
│   └── epargne-api.csproj
├── pret-api/                    # API C# Prêt
│   ├── Controllers/
│   ├── Models/
│   ├── Services/
│   └── pret-api.csproj
├── central-banque/              # Module Central (WAR)
│   ├── src/main/java/
│   ├── src/main/webapp/
│   └── pom.xml
├── database/                    # Scripts SQL
│   ├── init.sql
│   └── structure.txt
└── README.md
```

## 👥 Équipe de Développement

Projet développé dans le cadre du cours de Programmation Distribuée - ITU S5.

## 📄 Licence

Projet académique - ITU 2025

---

**Note** : Ce projet démontre une architecture distribuée moderne combinant Java EE, .NET Core et PostgreSQL avec une interface web responsive utilisant Tailwind CSS.
