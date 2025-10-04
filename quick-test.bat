@echo off
echo ========================================
echo    TEST RAPIDE DEPLOIEMENT
echo ========================================
echo.

set WILDFLY_DEPLOYMENTS=G:\ITU\S5\PROG\wildfly\wildfly-37.0.1.Final\standalone\deployments

echo Vérification des fichiers de déploiement...
if exist "%WILDFLY_DEPLOYMENTS%\compte-courant-ejb-1.0.0.jar.deployed" (
    echo ✓ EJB déployé
) else (
    echo ✗ EJB non déployé
)

if exist "%WILDFLY_DEPLOYMENTS%\central-banque-1.0.0.war.deployed" (
    echo ✓ WAR déployé
) else (
    echo ⚠ WAR en cours de déploiement...
    timeout /t 10 /nobreak > nul
    if exist "%WILDFLY_DEPLOYMENTS%\central-banque-1.0.0.war.deployed" (
        echo ✓ WAR déployé avec succès
    ) else (
        echo ✗ WAR non déployé
    )
)

if exist "%WILDFLY_DEPLOYMENTS%\*.failed" (
    echo ✗ Échecs de déploiement:
    dir "%WILDFLY_DEPLOYMENTS%\*.failed" /b
) else (
    echo ✓ Aucun échec de déploiement
)

echo.
echo Test de connectivité...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:8080/central-banque/accueil' -TimeoutSec 5; Write-Host '✓ Application accessible - Status:' $response.StatusCode } catch { Write-Host '⚠ Application non accessible:' $_.Exception.Message }"

echo.
echo URLs de test:
echo - Accueil : http://localhost:8080/central-banque/accueil
echo - Comptes : http://localhost:8080/central-banque/compte/list
echo.
pause
