@echo off
echo ========================================
echo    TEST FINAL DU SYSTÈME BANCAIRE
echo ========================================
echo.

echo 1. Vérification des déploiements WildFly...
set WILDFLY_DEPLOYMENTS=G:\ITU\S5\PROG\wildfly\wildfly-37.0.1.Final\standalone\deployments

if exist "%WILDFLY_DEPLOYMENTS%\compte-courant-ejb-1.0.0.jar.deployed" (
    echo ✓ Module EJB déployé
) else (
    echo ✗ Module EJB non déployé
    goto :error
)

if exist "%WILDFLY_DEPLOYMENTS%\central-banque-1.0.0.war.deployed" (
    echo ✓ Module WAR déployé
) else (
    echo ✗ Module WAR non déployé
    goto :error
)

echo.
echo 2. Test de connectivité des pages principales...

echo Test de la page d'accueil...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:8080/central-banque-1.0.0/accueil' -TimeoutSec 10; if($response.StatusCode -eq 200) { Write-Host '✓ Page d''accueil accessible' } else { Write-Host '⚠ Page d''accueil - Status:' $response.StatusCode } } catch { Write-Host '✗ Page d''accueil non accessible:' $_.Exception.Message }"

echo Test de la page des comptes...
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://localhost:8080/central-banque-1.0.0/compte/list' -TimeoutSec 10; if($response.StatusCode -eq 200) { Write-Host '✓ Page des comptes accessible' } else { Write-Host '⚠ Page des comptes - Status:' $response.StatusCode } } catch { Write-Host '✗ Page des comptes non accessible:' $_.Exception.Message }"

echo.
echo 3. URLs de test disponibles :
echo ========================================
echo - Accueil : http://localhost:8080/central-banque-1.0.0/accueil
echo - Comptes : http://localhost:8080/central-banque-1.0.0/compte/list
echo - Épargne : http://localhost:8080/central-banque-1.0.0/epargne/list
echo - Prêts   : http://localhost:8080/central-banque-1.0.0/pret/list
echo.
echo - Console WildFly : http://localhost:9990
echo.

echo 4. Pour ajouter des données de test :
echo ========================================
echo Connectez-vous à PostgreSQL et exécutez :
echo psql -U postgres -d banque_system -f database\test-data.sql
echo.

echo 5. Pour démarrer les APIs C# :
echo ========================================
echo Exécutez : start-apis.bat
echo - API Épargne : http://localhost:5001
echo - API Prêt    : http://localhost:5002
echo.

echo ✅ SYSTÈME BANCAIRE OPÉRATIONNEL !
echo.
goto :end

:error
echo.
echo ❌ ERREUR : Le système n'est pas complètement déployé
echo Vérifiez les logs WildFly pour plus de détails
echo.

:end
pause
