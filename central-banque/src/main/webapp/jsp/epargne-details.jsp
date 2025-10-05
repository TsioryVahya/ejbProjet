<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Épargne - Système Bancaire</title>
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
                <div class="flex items-center space-x-4">
                    <a href="${pageContext.request.contextPath}/accueil" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
                        <i class="fas fa-home mr-2"></i>Accueil
                    </a>
                    <a href="${pageContext.request.contextPath}/compte/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
                        <i class="fas fa-credit-card mr-2"></i>Comptes
                    </a>
                    <a href="${pageContext.request.contextPath}/epargne/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium bg-blue-700">
                        <i class="fas fa-piggy-bank mr-2"></i>Épargne
                    </a>
                    <a href="${pageContext.request.contextPath}/pret/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
                        <i class="fas fa-hand-holding-usd mr-2"></i>Prêts
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Messages de succès/erreur -->
    <c:if test="${not empty succes}">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-4">
            <div class="bg-green-50 border border-green-200 rounded-md p-4">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="fas fa-check-circle text-green-400"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-green-800">${succes}</p>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty erreur}">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-4">
            <div class="bg-red-50 border border-red-200 rounded-md p-4">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="fas fa-exclamation-circle text-red-400"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-red-800">${erreur}</p>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Contenu principal -->
    <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <div class="px-4 py-6 sm:px-0">
            <!-- En-tête -->
            <div class="mb-6">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Détails de l'Épargne</h1>
                        <p class="mt-2 text-sm text-gray-600">
                            Compte d'épargne 
                            <span class="font-mono font-medium">${compte.numeroCompte}</span>
                        </p>
                    </div>
                    <div class="flex space-x-3">
                        <a href="${pageContext.request.contextPath}/epargne/list" 
                           class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <i class="fas fa-arrow-left mr-2"></i>
                            Retour à la liste
                        </a>
                        <c:if test="${apiDisponible}">
                            <a href="${pageContext.request.contextPath}/epargne/nouveau-depot?idCompte=${compte.idCompte}" 
                               class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                <i class="fas fa-plus mr-2"></i>
                                Nouveau Dépôt
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Statut de l'API -->
            <c:if test="${not apiDisponible}">
                <div class="mb-6 bg-yellow-50 border border-yellow-200 text-yellow-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-exclamation-triangle mr-2"></i>
                    <span class="block sm:inline">Service d'épargne temporairement indisponible. Les informations peuvent ne pas être à jour.</span>
                </div>
            </c:if>

            <!-- Informations du compte -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg mb-6">
                <div class="px-4 py-5 sm:px-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Informations du compte d'épargne</h3>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">Détails et solde du compte d'épargne</p>
                </div>
                <div class="border-t border-gray-200">
                    <dl>
                        <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Numéro de compte</dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 font-mono">${compte.numeroCompte}</dd>
                        </div>
                        <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Solde d'épargne</dt>
                            <dd class="mt-1 text-sm sm:mt-0 sm:col-span-2">
                                <c:choose>
                                    <c:when test="${apiDisponible and not empty soldeEpargne}">
                                        <span class="text-2xl font-bold text-green-600">
                                            <fmt:formatNumber value="${soldeEpargne}" type="currency" currencySymbol="€" />
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray-500 italic">
                                            <i class="fas fa-exclamation-triangle mr-1"></i>
                                            Non disponible
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </dd>
                        </div>
                        <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Type de compte</dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                ${compte.typeCompte.nomTypeCompte}
                                <c:if test="${not empty compte.typeCompte.description}">
                                    <span class="text-gray-500"> - ${compte.typeCompte.description}</span>
                                </c:if>
                            </dd>
                        </div>
                        <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Titulaire</dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                ${compte.client.prenom} ${compte.client.nom}
                            </dd>
                        </div>
                        <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Date de création</dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                ${compte.dateCreation}
                            </dd>
                        </div>
                        <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Statut</dt>
                            <dd class="mt-1 text-sm sm:mt-0 sm:col-span-2">
                                <c:choose>
                                    <c:when test="${compte.actif}">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                            <i class="fas fa-check-circle mr-1"></i>
                                            Actif
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                            <i class="fas fa-times-circle mr-1"></i>
                                            Inactif
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </dd>
                        </div>
                    </dl>
                </div>
            </div>

            <!-- Historique des dépôts d'épargne -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:px-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Historique des dépôts d'épargne</h3>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">
                        <c:choose>
                            <c:when test="${apiDisponible}">
                                <c:choose>
                                    <c:when test="${not empty depots}">
                                        ${depots.size()} dépôt(s) d'épargne trouvé(s)
                                    </c:when>
                                    <c:otherwise>
                                        Aucun dépôt d'épargne trouvé pour ce compte
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                Service d'épargne indisponible
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                
                <c:choose>
                    <c:when test="${not apiDisponible}">
                        <div class="text-center py-12">
                            <i class="fas fa-exclamation-triangle text-yellow-400 text-6xl mb-4"></i>
                            <h3 class="mt-2 text-sm font-medium text-gray-900">Service indisponible</h3>
                            <p class="mt-1 text-sm text-gray-500">Le service d'épargne est temporairement indisponible.</p>
                        </div>
                    </c:when>
                    <c:when test="${not empty depots}">
                        <ul role="list" class="divide-y divide-gray-200">
                            <c:forEach var="depot" items="${depots}">
                                <li class="px-4 py-4 sm:px-6">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0">
                                                <div class="h-10 w-10 rounded-full bg-green-100 flex items-center justify-center">
                                                    <i class="fas fa-piggy-bank text-green-600"></i>
                                                </div>
                                            </div>
                                            <div class="ml-4">
                                                <div class="flex items-center">
                                                    <p class="text-sm font-medium text-gray-900">
                                                        Dépôt d'épargne #${depot.id}
                                                    </p>
                                                </div>
                                                <p class="text-sm text-gray-500">
                                                    Date: ${depot.dateDepot}
                                                </p>
                                                <c:if test="${not empty depot.tauxInteret}">
                                                    <p class="text-xs text-gray-400">
                                                        Taux d'intérêt: ${depot.tauxInteret}%
                                                    </p>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="flex items-center space-x-4">
                                            <div class="text-right">
                                                <span class="text-lg font-semibold text-green-600">
                                                    <fmt:formatNumber value="${depot.montant}" type="currency" currencySymbol="€" />
                                                </span>
                                                <c:if test="${not empty depot.interetsAccumules and depot.interetsAccumules > 0}">
                                                    <p class="text-xs text-green-500">
                                                        +<fmt:formatNumber value="${depot.interetsAccumules}" type="currency" currencySymbol="€" /> d'intérêts
                                                    </p>
                                                </c:if>
                                            </div>
                                            <div class="flex space-x-2">
                                                <a href="${pageContext.request.contextPath}/epargne/nouveau-retrait?idDepot=${depot.id}&idCompte=${compte.idCompte}" 
                                                   class="inline-flex items-center px-3 py-1 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
                                                   title="Effectuer un retrait">
                                                    <i class="fas fa-minus mr-1"></i>
                                                    Retirer
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-12">
                            <i class="fas fa-piggy-bank text-gray-400 text-6xl mb-4"></i>
                            <h3 class="mt-2 text-sm font-medium text-gray-900">Aucun dépôt d'épargne</h3>
                            <p class="mt-1 text-sm text-gray-500">Ce compte n'a encore aucun dépôt d'épargne.</p>
                            <div class="mt-6">
                                <a href="${pageContext.request.contextPath}/epargne/nouveau-depot?idCompte=${compte.idCompte}" 
                                   class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                    <i class="fas fa-plus mr-2"></i>
                                    Créer un dépôt d'épargne
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Actions rapides -->
            <c:if test="${apiDisponible}">
                <div class="mt-8">
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="px-4 py-5 sm:p-6">
                            <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                                <i class="fas fa-bolt mr-2"></i>Actions rapides
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div class="bg-green-50 border border-green-200 rounded-lg p-4">
                                    <div class="flex items-center mb-3">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-plus-circle text-green-600 text-2xl"></i>
                                        </div>
                                        <div class="ml-4">
                                            <h4 class="text-sm font-medium text-green-900">Nouveau dépôt d'épargne</h4>
                                            <p class="text-sm text-green-700">Placer de l'argent sur ce compte d'épargne</p>
                                        </div>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/epargne/nouveau-depot?idCompte=${compte.idCompte}" 
                                       class="w-full inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                        <i class="fas fa-piggy-bank mr-2"></i>
                                        Effectuer un dépôt
                                    </a>
                                </div>

                                <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
                                    <div class="flex items-center mb-3">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-calculator text-blue-600 text-2xl"></i>
                                        </div>
                                        <div class="ml-4">
                                            <h4 class="text-sm font-medium text-blue-900">Calculateur d'intérêts</h4>
                                            <p class="text-sm text-blue-700">Estimer les gains potentiels</p>
                                        </div>
                                    </div>
                                    <button onclick="showCalculateurInterets()" 
                                            class="w-full inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                        <i class="fas fa-chart-line mr-2"></i>
                                        Calculer
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Modal Calculateur d'Intérêts -->
    <div id="calculateurModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full hidden">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
            <div class="mt-3">
                <h3 class="text-lg font-medium text-gray-900 mb-4">
                    <i class="fas fa-calculator mr-2 text-blue-600"></i>Calculateur d'Intérêts
                </h3>
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Montant (€)</label>
                        <input type="number" id="montantCalcul" step="0.01" min="0.01" 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                               placeholder="1000">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Taux annuel (%)</label>
                        <input type="number" id="tauxCalcul" step="0.01" min="0" max="100" 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                               placeholder="2.5">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Durée (jours)</label>
                        <input type="number" id="dureeCalcul" min="1" 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                               placeholder="365">
                    </div>
                    <div id="resultatCalcul" class="p-3 bg-blue-50 rounded-md hidden">
                        <p class="text-sm font-medium text-blue-900">Intérêts estimés :</p>
                        <p id="interetsCalcules" class="text-lg font-bold text-blue-600"></p>
                    </div>
                </div>
                <div class="flex justify-end space-x-3 mt-6">
                    <button type="button" onclick="hideCalculateurModal()" 
                            class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300">
                        Fermer
                    </button>
                    <button type="button" onclick="calculerInterets()" 
                            class="px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded-md hover:bg-blue-700">
                        Calculer
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8 mt-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center">
                <p class="text-sm">© 2025 Système Bancaire - Projet EJB & C# API</p>
                <p class="text-xs text-gray-400 mt-2">Gestion de l'épargne</p>
            </div>
        </div>
    </footer>

    <script>
        function showCalculateurInterets() {
            document.getElementById('calculateurModal').classList.remove('hidden');
        }
        
        function hideCalculateurModal() {
            document.getElementById('calculateurModal').classList.add('hidden');
            document.getElementById('resultatCalcul').classList.add('hidden');
        }
        
        function calculerInterets() {
            const montant = parseFloat(document.getElementById('montantCalcul').value) || 0;
            const taux = parseFloat(document.getElementById('tauxCalcul').value) || 0;
            const duree = parseInt(document.getElementById('dureeCalcul').value) || 0;
            
            if (montant > 0 && taux > 0 && duree > 0) {
                const interetsAnnuels = montant * (taux / 100);
                const interetsJournaliers = interetsAnnuels / 365;
                const interetsTotal = interetsJournaliers * duree;
                
                document.getElementById('interetsCalcules').textContent = 
                    new Intl.NumberFormat('fr-FR', { style: 'currency', currency: 'EUR' }).format(interetsTotal);
                document.getElementById('resultatCalcul').classList.remove('hidden');
            } else {
                alert('Veuillez remplir tous les champs avec des valeurs valides.');
            }
        }
        
        // Fermer modal en cliquant à l'extérieur
        window.onclick = function(event) {
            const modal = document.getElementById('calculateurModal');
            if (event.target == modal) {
                hideCalculateurModal();
            }
        }
    </script>
</body>
</html>
