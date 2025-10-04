<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Comptes - Système Bancaire</title>
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
                    <a href="${pageContext.request.contextPath}/compte/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium bg-blue-700">
                        <i class="fas fa-credit-card mr-2"></i>Comptes
                    </a>
                    <a href="${pageContext.request.contextPath}/epargne/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
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
                    <h1 class="text-3xl font-bold text-gray-900">Gestion des Comptes</h1>
                    <p class="text-gray-600 mt-2">Gérez tous les comptes bancaires</p>
                </div>
                <div class="flex space-x-3">
                    <a href="${pageContext.request.contextPath}/compte/nouveau" 
                       class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                        <i class="fas fa-plus mr-2"></i>Nouveau Compte
                    </a>
                </div>
            </div>

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

            <!-- Liste des comptes -->
            <div class="bg-white shadow overflow-hidden sm:rounded-md">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">
                        <i class="fas fa-list mr-2"></i>Liste des Comptes
                    </h3>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">
                        ${not empty comptes ? comptes.size() : 0} compte(s) trouvé(s)
                    </p>
                </div>

                <c:choose>
                    <c:when test="${empty comptes}">
                        <div class="text-center py-12">
                            <i class="fas fa-credit-card text-gray-400 text-6xl mb-4"></i>
                            <h3 class="text-lg font-medium text-gray-900 mb-2">Aucun compte trouvé</h3>
                            <p class="text-gray-500 mb-6">Commencez par créer votre premier compte bancaire.</p>
                            <a href="${pageContext.request.contextPath}/compte/nouveau" 
                               class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                <i class="fas fa-plus mr-2"></i>Créer un Compte
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <ul class="divide-y divide-gray-200">
                            <c:forEach var="compte" items="${comptes}">
                                <li class="px-4 py-4 hover:bg-gray-50">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0">
                                                <div class="h-12 w-12 rounded-full bg-blue-100 flex items-center justify-center">
                                                    <i class="fas fa-credit-card text-blue-600 text-lg"></i>
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
                                                    ${compte.nomCompletClient}
                                                </div>
                                                <div class="text-sm text-gray-500">
                                                    <i class="fas fa-tag mr-1"></i>
                                                    ${compte.nomTypeCompte}
                                                </div>
                                                <div class="text-xs text-gray-400 mt-1">
                                                    <i class="fas fa-calendar mr-1"></i>
                                                    Créé le <fmt:formatDate value="${compte.dateCreationAsDate}" pattern="dd/MM/yyyy à HH:mm"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="flex items-center space-x-4">
                                            <div class="text-right">
                                                <p class="text-lg font-semibold ${compte.solde >= 0 ? 'text-green-600' : 'text-red-600'}">
                                                    <fmt:formatNumber value="${compte.solde}" type="currency" currencySymbol="€"/>
                                                </p>
                                                <p class="text-xs text-gray-500">Solde</p>
                                            </div>
                                            <div class="flex space-x-2">
                                                <a href="${pageContext.request.contextPath}/compte/details?id=${compte.idCompte}" 
                                                   class="inline-flex items-center px-3 py-1 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"
                                                   title="Voir les détails">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/compte/operations?id=${compte.idCompte}" 
                                                   class="inline-flex items-center px-3 py-1 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"
                                                   title="Voir les opérations">
                                                    <i class="fas fa-list-alt"></i>
                                                </a>
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
            <c:if test="${not empty comptes}">
                <div class="mt-8">
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="px-4 py-5 sm:p-6">
                            <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                                <i class="fas fa-bolt mr-2"></i>Actions Rapides
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <button onclick="showDepotModal()" 
                                        class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                    <i class="fas fa-plus-circle mr-2"></i>Effectuer un Dépôt
                                </button>
                                <button onclick="showRetraitModal()" 
                                        class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700">
                                    <i class="fas fa-minus-circle mr-2"></i>Effectuer un Retrait
                                </button>
                                <button onclick="showVirementModal()" 
                                        class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                    <i class="fas fa-exchange-alt mr-2"></i>Effectuer un Virement
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Modal Dépôt -->
    <div id="depotModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full hidden">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
            <div class="mt-3">
                <h3 class="text-lg font-medium text-gray-900 mb-4">
                    <i class="fas fa-plus-circle mr-2 text-green-600"></i>Effectuer un Dépôt
                </h3>
                <form action="${pageContext.request.contextPath}/compte/depot" method="post">
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Compte</label>
                        <select name="idCompte" required class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">Sélectionner un compte</option>
                            <c:forEach var="compte" items="${comptes}">
                                <c:if test="${compte.actif}">
                                    <option value="${compte.idCompte}">${compte.numeroCompte} - ${compte.nomCompletClient}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Montant (€)</label>
                        <input type="number" name="montant" step="0.01" min="0.01" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Description</label>
                        <input type="text" name="description" placeholder="Description du dépôt"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div class="flex justify-end space-x-3">
                        <button type="button" onclick="hideDepotModal()" 
                                class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300">
                            Annuler
                        </button>
                        <button type="submit" 
                                class="px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-md hover:bg-green-700">
                            Effectuer le Dépôt
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        function showDepotModal() {
            document.getElementById('depotModal').classList.remove('hidden');
        }
        
        function hideDepotModal() {
            document.getElementById('depotModal').classList.add('hidden');
        }
        
        function showRetraitModal() {
            // Implémenter modal retrait
            alert('Modal retrait à implémenter');
        }
        
        function showVirementModal() {
            // Implémenter modal virement
            alert('Modal virement à implémenter');
        }
        
        // Fermer modal en cliquant à l'extérieur
        window.onclick = function(event) {
            const modal = document.getElementById('depotModal');
            if (event.target == modal) {
                hideDepotModal();
            }
        }
    </script>
</body>
</html>
