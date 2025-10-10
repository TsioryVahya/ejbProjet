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
                    <a href="${pageContext.request.contextPath}/client/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
                        <i class="fas fa-users mr-2"></i>Clients
                    </a>
                    <a href="${pageContext.request.contextPath}/compte/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium bg-blue-700">
                        <i class="fas fa-credit-card mr-2"></i>Comptes
                    </a>
                    <a href="${pageContext.request.contextPath}/operations/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
                        <i class="fas fa-list-alt mr-2"></i>Opérations
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

            <!-- Barre de recherche et filtres -->
            <div class="bg-white shadow rounded-lg mb-6">
                <div class="px-6 py-4">
                    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between space-y-3 sm:space-y-0">
                        <div class="flex-1 max-w-lg">
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-search text-gray-400"></i>
                                </div>
                                <input type="text" id="searchInput" placeholder="Rechercher par nom, numéro de compte..."
                                       class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md leading-5 bg-white placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-1 focus:ring-blue-500 focus:border-blue-500">
                            </div>
                        </div>
                        <div class="flex items-center space-x-3">
                            <select id="statusFilter" class="px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-1 focus:ring-blue-500">
                                <option value="">Tous les statuts</option>
                                <option value="actif">Actifs</option>
                                <option value="inactif">Inactifs</option>
                            </select>
                            <select id="typeFilter" class="px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-1 focus:ring-blue-500">
                                <option value="">Tous les types</option>
                                <c:forEach var="compte" items="${comptes}">
                                    <option value="${compte.nomTypeCompte}">${compte.nomTypeCompte}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tableau des comptes -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <div class="flex justify-between items-center">
                        <div>
                            <h3 class="text-lg leading-6 font-medium text-gray-900">
                                <i class="fas fa-table mr-2"></i>Liste des Comptes Clients
                            </h3>
                            <p class="mt-1 max-w-2xl text-sm text-gray-500">
                                <span id="comptesCount">${not empty comptes ? comptes.size() : 0}</span> compte(s) trouvé(s)
                            </p>
                        </div>
                        <div class="flex items-center space-x-2">
                            <button onclick="exportToCSV()" class="inline-flex items-center px-3 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                <i class="fas fa-download mr-2"></i>Exporter CSV
                            </button>
                        </div>
                    </div>
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
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200" id="comptesTable">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(0)">
                                            <div class="flex items-center">
                                                N° Compte
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(1)">
                                            <div class="flex items-center">
                                                Client
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(2)">
                                            <div class="flex items-center">
                                                Type de Compte
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(3)">
                                            <div class="flex items-center">
                                                Solde
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(4)">
                                            <div class="flex items-center">
                                                Statut
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(5)">
                                            <div class="flex items-center">
                                                Date de Création
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="compte" items="${comptes}" varStatus="status">
                                        <tr class="hover:bg-gray-50 transition-colors duration-200 ${status.index % 2 == 0 ? 'bg-white' : 'bg-gray-25'}">
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="flex-shrink-0 h-8 w-8">
                                                        <div class="h-8 w-8 rounded-full bg-blue-100 flex items-center justify-center">
                                                            <i class="fas fa-credit-card text-blue-600 text-sm"></i>
                                                        </div>
                                                    </div>
                                                    <div class="ml-3">
                                                        <div class="text-sm font-medium text-gray-900">${compte.numeroCompte}</div>
                                                        <div class="text-xs text-gray-500">ID: ${compte.idCompte}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm font-medium text-gray-900">${compte.nomCompletClient}</div>
                                                <c:if test="${not empty compte.emailClient}">
                                                    <div class="text-xs text-gray-500">
                                                        <i class="fas fa-envelope mr-1"></i>${compte.emailClient}
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty compte.telephoneClient}">
                                                    <div class="text-xs text-gray-500">
                                                        <i class="fas fa-phone mr-1"></i>${compte.telephoneClient}
                                                    </div>
                                                </c:if>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900">${compte.nomTypeCompte}</div>
                                                <c:if test="${not empty compte.descriptionTypeCompte}">
                                                    <div class="text-xs text-gray-500">${compte.descriptionTypeCompte}</div>
                                                </c:if>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm font-semibold ${compte.solde >= 0 ? 'text-green-600' : 'text-red-600'}">
                                                    <fmt:formatNumber value="${compte.solde}" type="currency" currencySymbol="€"/>
                                                </div>
                                                <div class="text-xs text-gray-500">
                                                    ${compte.solde >= 0 ? 'Créditeur' : 'Débiteur'}
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${compte.actif ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                    <span class="w-1.5 h-1.5 mr-1.5 rounded-full ${compte.actif ? 'bg-green-400' : 'bg-red-400'}"></span>
                                                    ${compte.actif ? 'Actif' : 'Inactif'}
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <div class="flex items-center">
                                                    <i class="fas fa-calendar-alt mr-2 text-gray-400"></i>
                                                    <div>
                                                        <div><fmt:formatDate value="${compte.dateCreationAsDate}" pattern="dd/MM/yyyy"/></div>
                                                        <div class="text-xs text-gray-400"><fmt:formatDate value="${compte.dateCreationAsDate}" pattern="HH:mm"/></div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                <div class="flex items-center space-x-2">
                                                    <a href="${pageContext.request.contextPath}/compte/details?id=${compte.idCompte}" 
                                                       class="inline-flex items-center px-2 py-1 border border-gray-300 text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 transition-colors duration-200"
                                                       title="Voir les détails">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/compte/operations?id=${compte.idCompte}" 
                                                       class="inline-flex items-center px-2 py-1 border border-gray-300 text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 transition-colors duration-200"
                                                       title="Voir les opérations">
                                                        <i class="fas fa-list-alt"></i>
                                                    </a>
                                                    <div class="relative inline-block text-left">
                                                        <button onclick="toggleDropdown('${compte.idCompte}')" class="inline-flex items-center px-2 py-1 border border-gray-300 text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 transition-colors duration-200">
                                                            <i class="fas fa-ellipsis-v"></i>
                                                        </button>
                                                        <div id="dropdown-${compte.idCompte}" class="hidden origin-top-right absolute right-0 mt-2 w-48 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 z-10">
                                                            <div class="py-1">
                                                                <button onclick="quickDeposit('${compte.idCompte}', '${compte.numeroCompte}')" class="flex items-center w-full px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                                    <i class="fas fa-plus-circle mr-2 text-green-600"></i>Dépôt rapide
                                                                </button>
                                                                <button onclick="quickWithdraw('${compte.idCompte}', '${compte.numeroCompte}')" class="flex items-center w-full px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                                    <i class="fas fa-minus-circle mr-2 text-red-600"></i>Retrait rapide
                                                                </button>
                                                                <button onclick="quickTransfer('${compte.idCompte}', '${compte.numeroCompte}')" class="flex items-center w-full px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                                    <i class="fas fa-exchange-alt mr-2 text-blue-600"></i>Virement rapide
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
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
    <div id="depotModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full hidden z-50">
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

    <!-- Modal Retrait -->
    <div id="retraitModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full hidden z-50">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
            <div class="mt-3">
                <h3 class="text-lg font-medium text-gray-900 mb-4">
                    <i class="fas fa-minus-circle mr-2 text-red-600"></i>Effectuer un Retrait
                </h3>
                <form action="${pageContext.request.contextPath}/compte/retrait" method="post">
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Compte</label>
                        <select name="idCompte" required class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">Sélectionner un compte</option>
                            <c:forEach var="compte" items="${comptes}">
                                <c:if test="${compte.actif}">
                                    <option value="${compte.idCompte}">${compte.numeroCompte} - ${compte.nomCompletClient} (Solde: <fmt:formatNumber value="${compte.solde}" type="currency" currencySymbol="€"/>)</option>
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
                        <input type="text" name="description" placeholder="Description du retrait"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div class="flex justify-end space-x-3">
                        <button type="button" onclick="hideRetraitModal()" 
                                class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300">
                            Annuler
                        </button>
                        <button type="submit" 
                                class="px-4 py-2 text-sm font-medium text-white bg-red-600 rounded-md hover:bg-red-700">
                            Effectuer le Retrait
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Virement -->
    <div id="virementModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full hidden z-50">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
            <div class="mt-3">
                <h3 class="text-lg font-medium text-gray-900 mb-4">
                    <i class="fas fa-exchange-alt mr-2 text-blue-600"></i>Effectuer un Virement
                </h3>
                <form action="${pageContext.request.contextPath}/compte/virement" method="post">
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Compte Source</label>
                        <select name="idCompteDebiteur" required class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">Sélectionner le compte source</option>
                            <c:forEach var="compte" items="${comptes}">
                                <c:if test="${compte.actif}">
                                    <option value="${compte.idCompte}">${compte.numeroCompte} - ${compte.nomCompletClient} (Solde: <fmt:formatNumber value="${compte.solde}" type="currency" currencySymbol="€"/>)</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Compte Destination</label>
                        <select name="idCompteCrediteur" required class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">Sélectionner le compte destination</option>
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
                        <input type="text" name="description" placeholder="Description du virement"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div class="flex justify-end space-x-3">
                        <button type="button" onclick="hideVirementModal()" 
                                class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300">
                            Annuler
                        </button>
                        <button type="submit" 
                                class="px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded-md hover:bg-blue-700">
                            Effectuer le Virement
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Variables globales
        let currentSortColumn = -1;
        let currentSortDirection = 'asc';
        
        // Initialisation au chargement de la page
        document.addEventListener('DOMContentLoaded', function() {
            initializeSearch();
            initializeFilters();
            removeDuplicateOptions();
        });
        
        // ===== FONCTIONS DE RECHERCHE ET FILTRAGE =====
        
        function initializeSearch() {
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('input', function() {
                    filterTable();
                });
            }
        }
        
        function initializeFilters() {
            const statusFilter = document.getElementById('statusFilter');
            const typeFilter = document.getElementById('typeFilter');
            
            if (statusFilter) {
                statusFilter.addEventListener('change', filterTable);
            }
            if (typeFilter) {
                typeFilter.addEventListener('change', filterTable);
            }
        }
        
        function removeDuplicateOptions() {
            const typeFilter = document.getElementById('typeFilter');
            if (typeFilter) {
                const seen = new Set();
                const options = Array.from(typeFilter.options);
                options.forEach(option => {
                    if (seen.has(option.value) && option.value !== '') {
                        option.remove();
                    } else {
                        seen.add(option.value);
                    }
                });
            }
        }
        
        function filterTable() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value.toLowerCase();
            const typeFilter = document.getElementById('typeFilter').value.toLowerCase();
            
            const table = document.getElementById('comptesTable');
            const tbody = table.querySelector('tbody');
            const rows = tbody.querySelectorAll('tr');
            
            let visibleCount = 0;
            
            rows.forEach(row => {
                const cells = row.querySelectorAll('td');
                if (cells.length === 0) return;
                
                // Extraction des données de la ligne
                const numeroCompte = cells[0].textContent.toLowerCase();
                const client = cells[1].textContent.toLowerCase();
                const typeCompte = cells[2].textContent.toLowerCase();
                const statut = cells[4].textContent.toLowerCase();
                
                // Vérification des critères de recherche
                const matchesSearch = !searchTerm || 
                    numeroCompte.includes(searchTerm) || 
                    client.includes(searchTerm);
                
                const matchesStatus = !statusFilter || statut.includes(statusFilter);
                const matchesType = !typeFilter || typeCompte.includes(typeFilter);
                
                // Affichage/masquage de la ligne
                if (matchesSearch && matchesStatus && matchesType) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            // Mise à jour du compteur
            document.getElementById('comptesCount').textContent = visibleCount;
        }
        
        // ===== FONCTIONS DE TRI =====
        
        function sortTable(columnIndex) {
            const table = document.getElementById('comptesTable');
            const tbody = table.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            
            // Déterminer la direction du tri
            if (currentSortColumn === columnIndex) {
                currentSortDirection = currentSortDirection === 'asc' ? 'desc' : 'asc';
            } else {
                currentSortDirection = 'asc';
                currentSortColumn = columnIndex;
            }
            
            // Trier les lignes
            rows.sort((a, b) => {
                const aValue = getCellValue(a, columnIndex);
                const bValue = getCellValue(b, columnIndex);
                
                let comparison = 0;
                if (columnIndex === 3) { // Colonne solde - tri numérique
                    const aNum = parseFloat(aValue.replace(/[€\s,]/g, '').replace(',', '.'));
                    const bNum = parseFloat(bValue.replace(/[€\s,]/g, '').replace(',', '.'));
                    comparison = aNum - bNum;
                } else if (columnIndex === 5) { // Colonne date - tri par date
                    const aDate = new Date(aValue.split('/').reverse().join('-'));
                    const bDate = new Date(bValue.split('/').reverse().join('-'));
                    comparison = aDate - bDate;
                } else { // Tri alphabétique
                    comparison = aValue.localeCompare(bValue, 'fr', { numeric: true });
                }
                
                return currentSortDirection === 'asc' ? comparison : -comparison;
            });
            
            // Réinsérer les lignes triées
            rows.forEach(row => tbody.appendChild(row));
            
            // Mettre à jour les icônes de tri
            updateSortIcons(columnIndex);
        }
        
        function getCellValue(row, columnIndex) {
            const cell = row.querySelectorAll('td')[columnIndex];
            return cell ? cell.textContent.trim() : '';
        }
        
        function updateSortIcons(activeColumn) {
            const headers = document.querySelectorAll('#comptesTable thead th');
            headers.forEach((header, index) => {
                const icon = header.querySelector('i.fas');
                if (icon) {
                    if (index === activeColumn) {
                        icon.className = currentSortDirection === 'asc' 
                            ? 'fas fa-sort-up ml-1 text-blue-600' 
                            : 'fas fa-sort-down ml-1 text-blue-600';
                    } else {
                        icon.className = 'fas fa-sort ml-1 text-gray-400';
                    }
                }
            });
        }
        
        // ===== FONCTIONS D'EXPORT =====
        
        function exportToCSV() {
            const table = document.getElementById('comptesTable');
            const rows = table.querySelectorAll('tr');
            let csv = [];
            
            // En-têtes
            const headers = Array.from(rows[0].querySelectorAll('th'))
                .slice(0, -1) // Exclure la colonne Actions
                .map(th => th.textContent.trim().replace(/\n/g, ' '));
            csv.push(headers.join(','));
            
            // Données
            for (let i = 1; i < rows.length; i++) {
                const row = rows[i];
                if (row.style.display === 'none') continue; // Ignorer les lignes masquées
                
                const cells = Array.from(row.querySelectorAll('td'))
                    .slice(0, -1) // Exclure la colonne Actions
                    .map(td => {
                        let text = td.textContent.trim().replace(/\n/g, ' ');
                        // Échapper les guillemets et encapsuler si nécessaire
                        if (text.includes(',') || text.includes('"') || text.includes('\n')) {
                            text = '"' + text.replace(/"/g, '""') + '"';
                        }
                        return text;
                    });
                csv.push(cells.join(','));
            }
            
            // Télécharger le fichier
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            const url = URL.createObjectURL(blob);
            link.setAttribute('href', url);
            link.setAttribute('download', 'comptes_clients_' + new Date().toISOString().split('T')[0] + '.csv');
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
        
        // ===== FONCTIONS DE MENU DROPDOWN =====
        
        function toggleDropdown(compteId) {
            // Fermer tous les autres dropdowns
            document.querySelectorAll('[id^="dropdown-"]').forEach(dropdown => {
                if (dropdown.id !== 'dropdown-' + compteId) {
                    dropdown.classList.add('hidden');
                }
            });
            
            // Toggle le dropdown actuel
            const dropdown = document.getElementById('dropdown-' + compteId);
            if (dropdown) {
                dropdown.classList.toggle('hidden');
            }
        }
        
        // Fermer les dropdowns en cliquant à l'extérieur
        document.addEventListener('click', function(event) {
            if (!event.target.closest('.relative')) {
                document.querySelectorAll('[id^="dropdown-"]').forEach(dropdown => {
                    dropdown.classList.add('hidden');
                });
            }
        });
        
        // ===== FONCTIONS D'ACTIONS RAPIDES =====
        
        function quickDeposit(compteId, numeroCompte) {
            const montant = prompt('Montant du dépôt pour le compte ' + numeroCompte + ' (€):');
            if (montant && !isNaN(montant) && parseFloat(montant) > 0) {
                const description = prompt('Description du dépôt (optionnel):') || 'Dépôt rapide';
                
                // Créer et soumettre un formulaire
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/compte/depot';
                
                const inputs = [
                    { name: 'idCompte', value: compteId },
                    { name: 'montant', value: montant },
                    { name: 'description', value: description }
                ];
                
                inputs.forEach(input => {
                    const hiddenInput = document.createElement('input');
                    hiddenInput.type = 'hidden';
                    hiddenInput.name = input.name;
                    hiddenInput.value = input.value;
                    form.appendChild(hiddenInput);
                });
                
                document.body.appendChild(form);
                form.submit();
            }
            toggleDropdown(compteId); // Fermer le dropdown
        }
        
        function quickWithdraw(compteId, numeroCompte) {
            const montant = prompt('Montant du retrait pour le compte ' + numeroCompte + ' (€):');
            if (montant && !isNaN(montant) && parseFloat(montant) > 0) {
                const description = prompt('Description du retrait (optionnel):') || 'Retrait rapide';
                
                // Créer et soumettre un formulaire
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/compte/retrait';
                
                const inputs = [
                    { name: 'idCompte', value: compteId },
                    { name: 'montant', value: montant },
                    { name: 'description', value: description }
                ];
                
                inputs.forEach(input => {
                    const hiddenInput = document.createElement('input');
                    hiddenInput.type = 'hidden';
                    hiddenInput.name = input.name;
                    hiddenInput.value = input.value;
                    form.appendChild(hiddenInput);
                });
                
                document.body.appendChild(form);
                form.submit();
            }
            toggleDropdown(compteId); // Fermer le dropdown
        }
        
        function quickTransfer(compteId, numeroCompte) {
            const compteDestination = prompt('Numéro du compte de destination:');
            if (compteDestination) {
                const montant = prompt('Montant du virement depuis le compte ' + numeroCompte + ' (€):');
                if (montant && !isNaN(montant) && parseFloat(montant) > 0) {
                    const description = prompt('Description du virement (optionnel):') || 'Virement rapide';
                    
                    // Créer et soumettre un formulaire
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/compte/virement';
                    
                    const inputs = [
                        { name: 'idCompteSource', value: compteId },
                        { name: 'compteDestination', value: compteDestination },
                        { name: 'montant', value: montant },
                        { name: 'description', value: description }
                    ];
                    
                    inputs.forEach(input => {
                        const hiddenInput = document.createElement('input');
                        hiddenInput.type = 'hidden';
                        hiddenInput.name = input.name;
                        hiddenInput.value = input.value;
                        form.appendChild(hiddenInput);
                    });
                    
                    document.body.appendChild(form);
                    form.submit();
                }
            }
            toggleDropdown(compteId); // Fermer le dropdown
        }
        
        // ===== FONCTIONS MODALES EXISTANTES =====
        
        function showDepotModal() {
            document.getElementById('depotModal').classList.remove('hidden');
        }
        
        function hideDepotModal() {
            document.getElementById('depotModal').classList.add('hidden');
        }
        
        function showRetraitModal() {
            document.getElementById('retraitModal').classList.remove('hidden');
        }
        
        function hideRetraitModal() {
            document.getElementById('retraitModal').classList.add('hidden');
        }
        
        function showVirementModal() {
            document.getElementById('virementModal').classList.remove('hidden');
        }
        
        function hideVirementModal() {
            document.getElementById('virementModal').classList.add('hidden');
        }
        
        // Fermer modales en cliquant à l'extérieur
        window.onclick = function(event) {
            const depotModal = document.getElementById('depotModal');
            const retraitModal = document.getElementById('retraitModal');
            const virementModal = document.getElementById('virementModal');
            
            if (event.target == depotModal) {
                hideDepotModal();
            } else if (event.target == retraitModal) {
                hideRetraitModal();
            } else if (event.target == virementModal) {
                hideVirementModal();
            }
        }
    </script>
</body>
</html>
