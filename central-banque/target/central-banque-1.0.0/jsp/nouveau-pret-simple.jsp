<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau Prêt - Test Simple</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50 min-h-screen">
    <!-- Navigation -->
    <nav class="bg-blue-600 shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <i class="fas fa-university text-white text-2xl"></i>
                    </div>
                    <div class="ml-4">
                        <h1 class="text-white text-xl font-bold">Système Bancaire</h1>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Contenu principal -->
    <div class="max-w-4xl mx-auto py-6 sm:px-6 lg:px-8">
        <div class="px-4 py-6 sm:px-0">
            <h1 class="text-3xl font-bold text-gray-900 mb-6">Test Simple - Nouveau Prêt</h1>

            <!-- Messages -->
            <c:if test="${not empty erreur}">
                <div class="mb-4 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    ${erreur}
                </div>
            </c:if>

            <!-- Formulaire simplifié -->
            <div class="bg-white shadow rounded-lg p-6">
                <h3 class="text-lg font-medium text-gray-900 mb-6">Créer un Prêt</h3>

                <form action="${pageContext.request.contextPath}/pret/creer" method="post">
                    <!-- Sélection du compte -->
                    <div class="mb-4">
                        <label for="idCompte" class="block text-sm font-medium text-gray-700 mb-2">
                            Compte Bénéficiaire *
                        </label>
                        <select id="idCompte" name="idCompte" required 
                                class="block w-full px-3 py-2 border border-gray-300 rounded-md">
                            <option value="">Sélectionner un compte</option>
                            <c:forEach var="compte" items="${comptes}">
                                <option value="${compte.idCompte}">
                                    ${compte.numeroCompte} - ${compte.client.nom} ${compte.client.prenom}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Montant -->
                    <div class="mb-4">
                        <label for="montant" class="block text-sm font-medium text-gray-700 mb-2">
                            Montant (€) *
                        </label>
                        <input type="number" id="montant" name="montant" required 
                               step="0.01" min="100" max="500000"
                               class="block w-full px-3 py-2 border border-gray-300 rounded-md">
                    </div>

                    <!-- Durée -->
                    <div class="mb-4">
                        <label for="duree" class="block text-sm font-medium text-gray-700 mb-2">
                            Durée (mois) *
                        </label>
                        <select id="duree" name="duree" required 
                                class="block w-full px-3 py-2 border border-gray-300 rounded-md">
                            <option value="">Sélectionner la durée</option>
                            <option value="12">12 mois</option>
                            <option value="24">24 mois</option>
                            <option value="36">36 mois</option>
                            <option value="60">60 mois</option>
                        </select>
                    </div>

                    <!-- Taux d'intérêt -->
                    <div class="mb-6">
                        <label for="idTaux" class="block text-sm font-medium text-gray-700 mb-2">
                            Taux d'Intérêt *
                        </label>
                        <select id="idTaux" name="idTaux" required 
                                class="block w-full px-3 py-2 border border-gray-300 rounded-md">
                            <option value="">Chargement des taux...</option>
                        </select>
                        <div id="tauxError" class="hidden mt-2 text-red-600 text-sm">
                            Erreur: Impossible de charger les taux d'intérêt
                        </div>
                    </div>

                    <!-- Boutons -->
                    <div class="flex justify-end space-x-3">
                        <a href="${pageContext.request.contextPath}/pret/list" 
                           class="px-4 py-2 border border-gray-300 rounded-md text-gray-700 bg-white hover:bg-gray-50">
                            Annuler
                        </a>
                        <button type="submit" 
                                class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700">
                            Créer le Prêt
                        </button>
                    </div>
                </form>
            </div>

            <!-- Zone de debug -->
            <div class="mt-8 bg-gray-100 p-4 rounded-lg">
                <h4 class="font-medium text-gray-900 mb-2">Debug Info</h4>
                <div id="debugInfo" class="text-sm text-gray-600">
                    Chargement...
                </div>
            </div>
        </div>
    </div>

    <!-- Script simplifié -->
    <script>
        console.log('=== SCRIPT SIMPLE CHARGE ===');
        
        // Variables globales
        let tauxCharges = false;
        
        // Fonction de debug
        function updateDebug(message) {
            const debugDiv = document.getElementById('debugInfo');
            const timestamp = new Date().toLocaleTimeString();
            debugDiv.innerHTML += `<br>[${timestamp}] ${message}`;
        }
        
        // Chargement des taux
        function chargerTaux() {
            updateDebug('Début chargement des taux...');
            
            const selectTaux = document.getElementById('idTaux');
            const errorDiv = document.getElementById('tauxError');
            
            const url = '${pageContext.request.contextPath}/pret/api?action=taux';
            updateDebug('URL: ' + url);
            
            fetch(url)
                .then(response => {
                    updateDebug('Réponse reçue: ' + response.status);
                    if (!response.ok) {
                        throw new Error('HTTP ' + response.status);
                    }
                    return response.text();
                })
                .then(data => {
                    updateDebug('Données brutes: ' + data.substring(0, 100) + '...');
                    
                    let taux;
                    try {
                        taux = JSON.parse(data);
                    } catch (e) {
                        throw new Error('JSON invalide: ' + e.message);
                    }
                    
                    if (Array.isArray(taux) && taux.length > 0) {
                        selectTaux.innerHTML = '<option value="">Sélectionner un taux</option>';
                        
                        taux.forEach(t => {
                            const option = document.createElement('option');
                            option.value = t.idTaux;
                            option.textContent = t.pourcentage + '% - Standard';
                            selectTaux.appendChild(option);
                        });
                        
                        updateDebug('✅ ' + taux.length + ' taux chargés avec succès');
                        tauxCharges = true;
                        errorDiv.classList.add('hidden');
                    } else {
                        throw new Error('Aucun taux trouvé');
                    }
                })
                .catch(error => {
                    updateDebug('❌ Erreur: ' + error.message);
                    selectTaux.innerHTML = '<option value="">Erreur de chargement</option>';
                    errorDiv.classList.remove('hidden');
                });
        }
        
        // Validation du formulaire
        document.querySelector('form').addEventListener('submit', function(e) {
            if (!tauxCharges) {
                e.preventDefault();
                alert('Les taux ne sont pas encore chargés. Veuillez patienter.');
                return false;
            }
            
            const idTaux = document.getElementById('idTaux').value;
            if (!idTaux) {
                e.preventDefault();
                alert('Veuillez sélectionner un taux d\'intérêt');
                return false;
            }
            
            return true;
        });
        
        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            updateDebug('Page chargée, début initialisation...');
            chargerTaux();
        });
    </script>
</body>
</html>
