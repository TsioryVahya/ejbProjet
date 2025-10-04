@echo off
echo ========================================
echo    DEPLOIEMENT SYSTEME BANCAIRE
echo ========================================
echo.

REM Configuration des chemins
set WILDFLY_DEPLOYMENTS=D:\wildfly-37.0.1.Final\standalone\deployments
set PROJECT_ROOT=%~dp0
set EJB_MODULE=%PROJECT_ROOT%compte-courant-ejb
set CENTRAL_MODULE=%PROJECT_ROOT%central-banque
set EPARGNE_API=%PROJECT_ROOT%epargne-api
set PRET_API=%PROJECT_ROOT%pret-api

echo Configuration:
echo - WildFly Deployments: %WILDFLY_DEPLOYMENTS%
echo - Projet: %PROJECT_ROOT%
echo.

REM Vérifier que WildFly existe
if not exist "%WILDFLY_DEPLOYMENTS%" (
    echo ERREUR: Répertoire WildFly introuvable: %WILDFLY_DEPLOYMENTS%
    echo Vérifiez le chemin vers WildFly
    pause
    exit /b 1
)

echo ========================================
echo 1. COMPILATION DU MODULE EJB
echo ========================================
cd /d "%EJB_MODULE%"
echo Compilation du module compte-courant-ejb...
call mvn clean install
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Échec de la compilation du module EJB
    pause
    exit /b 1
)
echo ✓ Module EJB compilé avec succès
echo.

echo ========================================
echo 2. COMPILATION DU MODULE CENTRAL
echo ========================================
cd /d "%CENTRAL_MODULE%"
echo Compilation du module central-banque...
call mvn clean package
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Échec de la compilation du module Central
    pause
    exit /b 1
)
echo ✓ Module Central compilé avec succès
echo.

echo ========================================
echo 3. DEPLOIEMENT SUR WILDFLY
echo ========================================

REM Supprimer les anciens déploiements
echo Nettoyage des anciens déploiements...
if exist "%WILDFLY_DEPLOYMENTS%\compte-courant-ejb-1.0.0.jar" (
    del "%WILDFLY_DEPLOYMENTS%\compte-courant-ejb-1.0.0.jar"
    echo ✓ Ancien EJB supprimé
)
if exist "%WILDFLY_DEPLOYMENTS%\central-banque-1.0.0.war" (
    del "%WILDFLY_DEPLOYMENTS%\central-banque-1.0.0.war"
    echo ✓ Ancien WAR supprimé
)

REM Déployer le module EJB
echo Déploiement du module EJB...
if exist "%EJB_MODULE%\target\compte-courant-ejb-1.0.0.jar" (
    copy "%EJB_MODULE%\target\compte-courant-ejb-1.0.0.jar" "%WILDFLY_DEPLOYMENTS%\"
    echo ✓ Module EJB déployé: compte-courant-ejb-1.0.0.jar
) else (
    echo ERREUR: Fichier EJB introuvable: %EJB_MODULE%\target\compte-courant-ejb-1.0.0.jar
    pause
    exit /b 1
)

REM Déployer le module Central
echo Déploiement du module Central...
if exist "%CENTRAL_MODULE%\target\central-banque-1.0.0.war" (
    copy "%CENTRAL_MODULE%\target\central-banque-1.0.0.war" "%WILDFLY_DEPLOYMENTS%\"
    echo ✓ Module Central déployé: central-banque-1.0.0.war
) else (
    echo ERREUR: Fichier WAR introuvable: %CENTRAL_MODULE%\target\central-banque-1.0.0.war
    pause
    exit /b 1
)

echo.
echo ========================================
echo 4. COMPILATION DES APIS C#
echo ========================================

REM Compilation API Épargne
echo Compilation de l'API Épargne...
cd /d "%EPARGNE_API%"
call dotnet restore
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Échec de la restauration des packages pour l'API Épargne
    pause
    exit /b 1
)
call dotnet build
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Échec de la compilation de l'API Épargne
    pause
    exit /b 1
)
echo ✓ API Épargne compilée avec succès

REM Compilation API Prêt
echo Compilation de l'API Prêt...
cd /d "%PRET_API%"
call dotnet restore
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Échec de la restauration des packages pour l'API Prêt
    pause
    exit /b 1
)
call dotnet build
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Échec de la compilation de l'API Prêt
    pause
    exit /b 1
)
echo ✓ API Prêt compilée avec succès

echo.
echo ========================================
echo 5. CREATION DES SCRIPTS DE LANCEMENT
echo ========================================

REM Créer le script de lancement des APIs
cd /d "%PROJECT_ROOT%"
echo @echo off > start-apis.bat
echo echo Démarrage des APIs C#... >> start-apis.bat
echo echo. >> start-apis.bat
echo start "API Epargne" cmd /k "cd /d %EPARGNE_API% && echo Démarrage API Épargne (Port 5001)... && dotnet run" >> start-apis.bat
echo timeout /t 3 /nobreak ^> nul >> start-apis.bat
echo start "API Pret" cmd /k "cd /d %PRET_API% && echo Démarrage API Prêt (Port 5002)... && dotnet run" >> start-apis.bat
echo echo APIs démarrées dans des fenêtres séparées >> start-apis.bat
echo echo - API Épargne: http://localhost:5001 >> start-apis.bat
echo echo - API Prêt: http://localhost:5002 >> start-apis.bat
echo pause >> start-apis.bat

echo ✓ Script start-apis.bat créé

echo.
echo ========================================
echo ✓ DEPLOIEMENT TERMINE AVEC SUCCES
echo ========================================
echo.
echo Modules déployés sur WildFly:
echo - compte-courant-ejb-1.0.0.jar
echo - central-banque-1.0.0.war
echo.
echo APIs C# compilées:
echo - epargne-api (Port 5001)
echo - pret-api (Port 5002)
echo.
echo PROCHAINES ETAPES:
echo 1. Démarrer WildFly: wildfly\bin\standalone.bat
echo 2. Lancer les APIs: start-apis.bat
echo 3. Accéder à l'application: http://localhost:8080/central-banque
echo.
echo IMPORTANT: Assurez-vous que PostgreSQL est démarré avec la base 'banque_system'
echo.
pause

REM Retourner au répertoire initial
cd /d "%PROJECT_ROOT%"
