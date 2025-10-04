@echo off 
echo Démarrage des APIs C#... 
echo. 
start "API Epargne" cmd /k "cd /d A:\M.Tahina\ejbProjet\epargne-api && echo Démarrage API Épargne (Port 5001)... && dotnet run" 
timeout /t 3 /nobreak > nul 
start "API Pret" cmd /k "cd /d A:\M.Tahina\ejbProjet\pret-api && echo Démarrage API Prêt (Port 5002)... && dotnet run" 
echo APIs démarrées dans des fenêtres séparées 
echo - API Épargne: http://localhost:5001 
echo - API Prêt: http://localhost:5002 
pause 
