@echo off
echo ========================================
echo    VERIFICATION DEPLOIEMENT FINAL
echo ========================================
echo.

set WILDFLY_HOME=D:\wildfly-37.0.1.Final
set WILDFLY_DEPLOYMENTS=%WILDFLY_HOME%\standalone\deployments
set JBOSS_CLI=%WILDFLY_HOME%\bin\jboss-cli.bat

echo 1. Vérification des fichiers de déploiement...
echo ========================================

if exist "%WILDFLY_DEPLOYMENTS%\compte-courant-ejb-1.0.0.jar" (
    echo ✓ EJB JAR présent
) else (
    echo ✗ EJB JAR manquant
)

if exist "%WILDFLY_DEPLOYMENTS%\central-banque-1.0.0.war" (
    echo ✓ WAR présent
) else (
    echo ✗ WAR manquant
)

if exist "%WILDFLY_DEPLOYMENTS%\compte-courant-ejb-1.0.0.jar.deployed" (
    echo ✓ EJB déployé avec succès
) else (
    echo ⚠ EJB non déployé
)

if exist "%WILDFLY_DEPLOYMENTS%\central-banque-1.0.0.war.deployed" (
    echo ✓ WAR déployé avec succès
) else (
    echo ⚠ WAR non déployé
)

if exist "%WILDFLY_DEPLOYMENTS%\*.failed" (
    echo ✗ Échecs de déploiement détectés
    dir "%WILDFLY_DEPLOYMENTS%\*.failed"
) else (
    echo ✓ Aucun échec de déploiement
)

echo.
echo 2. Test de connectivité...
echo ========================================

echo Test de la page d'accueil...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:8080/central-banque' -TimeoutSec 5; Write-Host '✓ Application accessible - Status:' $response.StatusCode } catch { Write-Host '✗ Application non accessible:' $_.Exception.Message }"

echo.
echo Test de la console WildFly...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:9990' -TimeoutSec 5; Write-Host '✓ Console WildFly accessible - Status:' $response.StatusCode } catch { Write-Host '✗ Console WildFly non accessible:' $_.Exception.Message }"

echo.
echo 3. Vérification des services via CLI...
echo ========================================

echo Statut des déploiements:
"%JBOSS_CLI%" --connect --command="deployment-info" 2>nul

echo.
echo 4. URLs d'accès:
echo ========================================
echo - Application principale : http://localhost:8080/central-banque
echo - Gestion des comptes : http://localhost:8080/central-banque/compte/list
echo - Console WildFly : http://localhost:9990
echo - API Épargne : http://localhost:5001 (si démarrée)
echo - API Prêt : http://localhost:5002 (si démarrée)

echo.
echo 5. Logs WildFly:
echo ========================================
echo Pour consulter les logs en cas de problème:
echo %WILDFLY_HOME%\standalone\log\server.log
echo.
pause
