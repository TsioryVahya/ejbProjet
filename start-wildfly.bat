@echo off
echo ========================================
echo    DEMARRAGE WILDFLY
echo ========================================
echo.

set WILDFLY_HOME=D:\wildfly-37.0.1.Final

if not exist "%WILDFLY_HOME%\bin\standalone.bat" (
    echo ERREUR: WildFly introuvable dans %WILDFLY_HOME%
    echo Vérifiez le chemin vers WildFly
    pause
    exit /b 1
)

echo Démarrage de WildFly...
echo Répertoire: %WILDFLY_HOME%
echo.
echo Une fois WildFly démarré:
echo - Console Admin: http://localhost:9990
echo - Application: http://localhost:8080/central-banque
echo.

cd /d "%WILDFLY_HOME%\bin"
call standalone.bat

pause
