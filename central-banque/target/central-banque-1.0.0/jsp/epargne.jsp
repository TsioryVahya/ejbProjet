<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion de l'Épargne - Système Bancaire</title>
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

    <!-- Contenu principal -->
    <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- En-tête -->
        <div class="px-4 py-6 sm:px-0">
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Gestion de l'Épargne</h1>
                    <p class="text-gray-600 mt-2">Gérez vos comptes d'épargne et livrets</p>
                </div>
                <div class="flex space-x-3">
                    <c:if test="${apiDisponible}">
                        <a href="${pageContext.request.contextPath}/epargne/nouveau-depot" 
                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                            <i class="fas fa-plus mr-2"></i>Nouveau Dépôt
                        </a>
                    </c:if>
                </div>
            </div>

            <!-- Statut de l'API -->
            <c:if test="${not apiDisponible}">
                <div class="mb-6 bg-yellow-50 border border-yellow-200 text-yellow-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-exclamation-triangle mr-2"></i>
                    <span class="block sm:inline">Service d'épargne temporairement indisponible. Certaines fonctionnalités peuvent être limitées.</span>
                </div>
            </c:if>

            <!-- Messages -->
            <c:if test="${not empty succes}">
                <div class="mb-4 bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-check-circle mr-2"></i>
                    <span class="block sm:inline">${succes}</span>
                </div>
            </c:if>

            <c:if test="${not empty erreur}">
                <div class="mb-4 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <span class="block sm:inline">${erreur}</span>
                </div>
            </c:if>

            <!-- Liste des comptes d'épargne -->
            <div class="bg-white shadow overflow-hidden sm:rounded-md">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">
                        <i class="fas fa-piggy-bank mr-2"></i>Comptes d'Épargne
                    </h3>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">
                        ${not empty comptesEpargne ? comptesEpargne.size() : 0} compte(s) d'épargne trouvé(s)
                    </p>
                </div>

                <c:choose>
                    <c:when test="${empty comptesEpargne}">
                        <div class="text-center py-12">
                            <i class="fas fa-piggy-bank text-gray-400 text-6xl mb-4"></i>
                            <h3 class="text-lg font-medium text-gray-900 mb-2">Aucun compte d'épargne trouvé</h3>
                            <p class="text-gray-500 mb-6">Les comptes d'épargne et livrets apparaîtront ici.</p>
                            <a href="${pageContext.request.contextPath}/compte/nouveau" 
                               class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                <i class="fas fa-plus mr-2"></i>Créer un Compte d'Épargne
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <ul class="divide-y divide-gray-200">
                            <c:forEach var="compte" items="${comptesEpargne}">
                                <li class="px-4 py-4 hover:bg-gray-50">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0">
                                                <div class="h-12 w-12 rounded-full bg-green-100 flex items-center justify-center">
                                                    <i class="fas fa-piggy-bank text-green-600 text-lg"></i>
                                                </div>
                                            </div>
                                            <div class="ml-4">
                                                <div class="flex items-center">
                                                    <p class="text-lg font-medium text-gray-900">${compte.numeroCompte}</p>
                                                    <span class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${compte.actif ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                        ${compte.actif ? 'Actif' : 'Inactif'}
                                                    </span>
                                                </div>
                                                <div class="text-sm text-gray-500">
                                                    <i class="fas fa-user mr-1"></i>
                                                    ${compte.client.nom} ${compte.client.prenom}
                                                </div>
                                                <div class="text-sm text-gray-500">
                                                    <i class="fas fa-tag mr-1"></i>
                                                    ${compte.typeCompte.nomTypeCompte}
                                                </div>
                                                <div class="text-xs text-gray-400 mt-1">
                                                    <i class="fas fa-calendar mr-1"></i>
                                                    Créé le ${compte.dateCreation}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="flex items-center space-x-4">
                                            <div class="text-right">
                                                <c:if test="${apiDisponible}">
                                                    <p class="text-lg font-semibold text-green-600">
                                                        <i class="fas fa-coins mr-1"></i>
                                                        Épargne disponible
                                                    </p>
                                                </c:if>
                                                <c:if test="${not apiDisponible}">
                                                    <p class="text-sm text-gray-500">
                                                        <i class="fas fa-exclamation-triangle mr-1"></i>
                                                        Service indisponible
                                                    </p>
                                                </c:if>
                                            </div>
                                            <div class="flex space-x-2">
                                                <a href="${pageContext.request.contextPath}/epargne/details?id=${compte.idCompte}" 
                                                   class="inline-flex items-center px-3 py-1 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 ${not apiDisponible ? 'opacity-50 cursor-not-allowed' : ''}"
                                                   title="Voir les détails d'épargne">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <c:if test="${apiDisponible}">
                                                    <a href="${pageContext.request.contextPath}/epargne/nouveau-retrait?idCompte=${compte.idCompte}" 
                                                       class="inline-flex items-center px-3 py-1 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"
                                                       title="Effectuer un retrait">
                                                        <i class="fas fa-minus-circle"></i>
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Actions rapides -->
            <c:if test="${not empty comptesEpargne and apiDisponible}">
                <div class="mt-8">
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="px-4 py-5 sm:p-6">
                            <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                                <i class="fas fa-bolt mr-2"></i>Actions Rapides
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <a href="${pageContext.request.contextPath}/epargne/nouveau-depot" 
                                   class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                    <i class="fas fa-plus-circle mr-2"></i>Nouveau Dépôt d'Épargne
                                </a>
                                <button onclick="showCalculateurInterets()" 
                                        class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                    <i class="fas fa-calculator mr-2"></i>Calculateur d'Intérêts
                                </button>
                                <a href="${pageContext.request.contextPath}/epargne/statistiques" 
                                   class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700">
                                    <i class="fas fa-chart-line mr-2"></i>Statistiques
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Informations sur l'épargne -->
            <div class="mt-8">
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                            <i class="fas fa-info-circle mr-2"></i>À propos de l'Épargne
                        </h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="bg-blue-50 p-4 rounded-lg">
                                <h4 class="font-medium text-blue-900 mb-2">
                                    <i class="fas fa-percentage mr-2"></i>Taux d'Intérêt
                                </h4>
                                <p class="text-sm text-blue-800">
                                    Les intérêts sont calculés automatiquement selon les taux en vigueur.
                                    Consultez vos gains dans les détails de chaque dépôt.
                                </p>
                            </div>
                            <div class="bg-green-50 p-4 rounded-lg">
                                <h4 class="font-medium text-green-900 mb-2">
                                    <i class="fas fa-shield-alt mr-2"></i>Sécurité
                                </h4>
                                <p class="text-sm text-green-800">
                                    Vos fonds sont sécurisés et les retraits sont possibles à tout moment
                                    selon les conditions de votre contrat d'épargne.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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

    <!-- Scripts -->
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
