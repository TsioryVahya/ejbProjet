<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Prêts - Système Bancaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'bank-blue': '#1e40af',
                        'bank-light': '#3b82f6',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-100 font-sans">
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <div class="hidden md:flex md:w-64 md:flex-col">
            <div class="flex flex-col flex-grow pt-5 overflow-y-auto bg-gradient-to-b from-bank-blue to-blue-800 shadow-xl">
                <!-- Logo -->
                <div class="flex items-center flex-shrink-0 px-6 py-4">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center">
                                <i class="fas fa-university text-bank-blue text-xl"></i>
                            </div>
                        </div>
                        <div class="ml-3">
                            <h1 class="text-white text-lg font-bold">BankSystem</h1>
                            <p class="text-blue-200 text-xs">Gestion Bancaire</p>
                        </div>
                    </div>
                </div>

                <!-- Navigation -->
                <nav class="mt-8 flex-1 px-3 space-y-1">
                    <a href="${pageContext.request.contextPath}/accueil" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-home text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Tableau de Bord</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/client/list" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-users text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Clients</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/compte/list" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-credit-card text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Comptes</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/operations/list" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-exchange-alt text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Opérations</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/epargne/list" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-piggy-bank text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Épargne</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/pret/list" 
                       class="bg-blue-700 text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200 hover:bg-blue-600">
                        <i class="fas fa-hand-holding-usd text-blue-200 mr-3 text-lg"></i>
                        <span>Prêts</span>
                    </a>
                </nav>

                <!-- Footer Sidebar -->
                <div class="flex-shrink-0 p-4 border-t border-blue-600">
                    <div class="text-center">
                        <p class="text-xs text-blue-200">© 2025 BankSystem</p>
                        <p class="text-xs text-blue-300 mt-1">v2.0.0</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Mobile menu button -->
        <div class="md:hidden">
            <button id="mobile-menu-button" class="fixed top-4 left-4 z-50 bg-bank-blue text-white p-2 rounded-lg shadow-lg">
                <i class="fas fa-bars"></i>
            </button>
        </div>

        <!-- Mobile sidebar -->
        <div id="mobile-sidebar" class="fixed inset-0 z-40 md:hidden hidden">
            <div class="fixed inset-0 bg-gray-600 bg-opacity-75" onclick="toggleMobileSidebar()"></div>
            <div class="relative flex-1 flex flex-col max-w-xs w-full bg-gradient-to-b from-bank-blue to-blue-800">
                <div class="absolute top-0 right-0 -mr-12 pt-2">
                    <button onclick="toggleMobileSidebar()" class="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white">
                        <i class="fas fa-times text-white"></i>
                    </button>
                </div>
                <div class="flex-1 h-0 pt-5 pb-4 overflow-y-auto">
                    <div class="flex-shrink-0 flex items-center px-4">
                        <div class="w-8 h-8 bg-white rounded-lg flex items-center justify-center">
                            <i class="fas fa-university text-bank-blue"></i>
                        </div>
                        <h1 class="ml-2 text-white text-lg font-bold">BankSystem</h1>
                    </div>
                    <nav class="mt-5 px-2 space-y-1">
                        <a href="${pageContext.request.contextPath}/accueil" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-home mr-3"></i>Tableau de Bord
                        </a>
                        <a href="${pageContext.request.contextPath}/client/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-users mr-3"></i>Clients
                        </a>
                        <a href="${pageContext.request.contextPath}/compte/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-credit-card mr-3"></i>Comptes
                        </a>
                        <a href="${pageContext.request.contextPath}/operations/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-exchange-alt mr-3"></i>Opérations
                        </a>
                        <a href="${pageContext.request.contextPath}/epargne/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-piggy-bank mr-3"></i>Épargne
                        </a>
                        <a href="${pageContext.request.contextPath}/pret/list" class="bg-blue-700 text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-hand-holding-usd mr-3"></i>Prêts
                        </a>
                    </nav>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="flex-1 overflow-auto focus:outline-none">
            <!-- Top bar -->
            <div class="bg-white shadow-sm border-b border-gray-200">
                <div class="px-4 sm:px-6 lg:px-8">
                    <div class="flex justify-between h-16">
                        <div class="flex items-center">
                            <h1 class="text-2xl font-semibold text-gray-900">Gestion des Prêts</h1>
                        </div>
                        <div class="flex items-center space-x-4">
                            <a href="${pageContext.request.contextPath}/pret/nouveau" 
                               class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-lg text-white bg-gradient-to-r from-indigo-500 to-indigo-600 hover:from-indigo-600 hover:to-indigo-700 shadow-md hover:shadow-lg transition-all duration-200">
                                <i class="fas fa-plus mr-2"></i>Nouveau Prêt
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Page content -->
            <main class="flex-1 relative pb-8 overflow-y-auto">
                <div class="px-4 sm:px-6 lg:px-8 py-8">
    <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- En-tête -->
        <div class="px-4 py-6 sm:px-0">
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Gestion des Prêts</h1>
                    <p class="text-gray-600 mt-2">Gérez vos prêts et remboursements</p>
                </div>
                <div class="flex space-x-3">
                    <c:if test="${apiDisponible}">
                        <a href="${pageContext.request.contextPath}/pret/simulation" 
                           class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                            <i class="fas fa-calculator mr-2"></i>Simuler un Prêt
                        </a>
                        <a href="${pageContext.request.contextPath}/pret/nouveau" 
                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700">
                            <i class="fas fa-plus mr-2"></i>Nouveau Prêt
                        </a>
                    </c:if>
                </div>
            </div>

            <!-- Statut de l'API -->
            <c:if test="${not apiDisponible}">
                <div class="mb-6 bg-yellow-50 border border-yellow-200 text-yellow-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-exclamation-triangle mr-2"></i>
                    <span class="block sm:inline">Service de prêt temporairement indisponible. Certaines fonctionnalités peuvent être limitées.</span>
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

            <!-- Tableau des prêts -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <div class="flex justify-between items-center">
                        <div>
                            <h3 class="text-lg leading-6 font-medium text-gray-900">
                                <i class="fas fa-hand-holding-usd mr-2"></i>Prêts Actifs
                            </h3>
                            <p class="mt-1 max-w-2xl text-sm text-gray-500">
                                <span id="resultat-count">${not empty prets ? prets.size() : 0}</span> prêt(s) trouvé(s)
                            </p>
                        </div>
                        <div class="flex space-x-2">
                            <button onclick="exportToCSV()" class="inline-flex items-center px-3 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                <i class="fas fa-download mr-2"></i>Export CSV
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Barre de recherche et filtres -->
                <div class="px-4 py-3 border-b border-gray-200 bg-gray-50">
                    <div class="flex flex-wrap gap-4">
                        <div class="flex-1 min-w-64">
                            <input type="text" id="search-input" placeholder="Rechercher par numéro de prêt, compte..." 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent">
                        </div>
                        <div class="flex space-x-2">
                            <select id="statut-filter" class="px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-purple-500">
                                <option value="">Tous les statuts</option>
                                <option value="ACTIF">Actif</option>
                                <option value="REMBOURSE">Remboursé</option>
                                <option value="SUSPENDU">Suspendu</option>
                            </select>
                            <select id="duree-filter" class="px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-purple-500">
                                <option value="">Toutes les durées</option>
                                <option value="12">12 mois</option>
                                <option value="24">24 mois</option>
                                <option value="36">36 mois</option>
                                <option value="60">60 mois</option>
                            </select>
                        </div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty prets}">
                        <div class="text-center py-12">
                            <i class="fas fa-hand-holding-usd text-gray-400 text-6xl mb-4"></i>
                            <h3 class="text-lg font-medium text-gray-900 mb-2">Aucun prêt trouvé</h3>
                            <p class="text-gray-500 mb-6">
                                <c:choose>
                                    <c:when test="${apiDisponible}">
                                        Commencez par simuler ou demander votre premier prêt.
                                    </c:when>
                                    <c:otherwise>
                                        Le service de prêt est temporairement indisponible.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <c:if test="${apiDisponible}">
                                <div class="space-x-3">
                                    <a href="${pageContext.request.contextPath}/pret/simulation" 
                                       class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                        <i class="fas fa-calculator mr-2"></i>Simuler un Prêt
                                    </a>
                                    <a href="${pageContext.request.contextPath}/pret/nouveau" 
                                       class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700">
                                        <i class="fas fa-plus mr-2"></i>Demander un Prêt
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200" id="prets-table">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(0)">
                                            N° Prêt <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(1)">
                                            Compte <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(2)">
                                            Montant Initial <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(3)">
                                            Restant Dû <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(4)">
                                            Taux <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(5)">
                                            Durée <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(6)">
                                            Statut <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(7)">
                                            Date Création <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Remboursement
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200" id="prets-tbody">
                                    <c:forEach var="pret" items="${prets}">
                                        <tr class="hover:bg-gray-50 transition-colors duration-200" data-statut="${pret.statut}" data-duree="${pret.duree}">
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="flex-shrink-0 h-8 w-8">
                                                        <div class="h-8 w-8 rounded-full ${pret.actif ? 'bg-purple-100' : 'bg-green-100'} flex items-center justify-center">
                                                            <i class="fas ${pret.actif ? 'fa-hand-holding-usd text-purple-600' : 'fa-check-circle text-green-600'} text-sm"></i>
                                                        </div>
                                                    </div>
                                                    <div class="ml-3">
                                                        <div class="text-sm font-medium text-gray-900">#${pret.idPret}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900">
                                                    <c:choose>
                                                        <c:when test="${not empty pret.numeroCompte}">
                                                            ${pret.numeroCompte}
                                                        </c:when>
                                                        <c:otherwise>
                                                            Compte #${pret.idCompte}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <c:if test="${not empty pret.nomClient and not empty pret.prenomClient}">
                                                    <div class="text-xs text-gray-500">${pret.prenomClient} ${pret.nomClient}</div>
                                                </c:if>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm font-semibold text-purple-600" data-montant="${pret.montantInitial}">
                                                    <fmt:formatNumber value="${pret.montantInitial}" type="currency" currencySymbol="€"/>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm font-semibold ${pret.montantRestant > 0 ? 'text-red-600' : 'text-green-600'}" data-montant="${pret.montantRestant}">
                                                    <fmt:formatNumber value="${pret.montantRestant}" type="currency" currencySymbol="€"/>
                                                </div>
                                                <!-- Barre de progression -->
                                                <c:if test="${pret.montantInitial > 0}">
                                                    <div class="mt-1">
                                                        <div class="w-full bg-gray-200 rounded-full h-1.5">
                                                            <div class="bg-purple-600 h-1.5 rounded-full transition-all duration-1000 progress-bar" 
                                                                 data-progress="${(pret.montantInitial - pret.montantRestant) / pret.montantInitial * 100}"></div>
                                                        </div>
                                                        <div class="text-xs text-gray-500 mt-1">
                                                            <fmt:formatNumber value="${(pret.montantInitial - pret.montantRestant) / pret.montantInitial * 100}" pattern="#0"/>% remboursé
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900" data-taux="${pret.tauxPourcentage}">
                                                    <c:choose>
                                                        <c:when test="${not empty pret.tauxPourcentage}">
                                                            <fmt:formatNumber value="${pret.tauxPourcentage}" pattern="#0.00"/>%
                                                        </c:when>
                                                        <c:otherwise>
                                                            N/A
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900">${pret.duree} mois</div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium 
                                                    ${pret.statut == 'ACTIF' ? 'bg-purple-100 text-purple-800' : 
                                                      pret.statut == 'REMBOURSE' ? 'bg-green-100 text-green-800' : 
                                                      'bg-red-100 text-red-800'}">
                                                    ${pret.statut}
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900" data-date="<fmt:formatDate value="${pret.datePretAsDate}" pattern="yyyy-MM-dd"/>">
                                                    <fmt:formatDate value="${pret.datePretAsDate}" pattern="dd/MM/yyyy"/>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-center">
                                                <c:choose>
                                                    <c:when test="${pret.actif and apiDisponible}">
                                                        <a href="${pageContext.request.contextPath}/pret/remboursement?idPret=${pret.idPret}" 
                                                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 transition-colors duration-200">
                                                            <i class="fas fa-money-bill-wave mr-2"></i>Rembourser
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-400">
                                                            <c:choose>
                                                                <c:when test="${not pret.actif}">
                                                                    <i class="fas fa-check-circle mr-2"></i>Remboursé
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-exclamation-triangle mr-2"></i>Indisponible
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
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
            <c:if test="${apiDisponible}">
                <div class="mt-8">
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="px-4 py-5 sm:p-6">
                            <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                                <i class="fas fa-bolt mr-2"></i>Actions Rapides
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <a href="${pageContext.request.contextPath}/pret/simulation" 
                                   class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                    <i class="fas fa-calculator mr-2"></i>Simuler un Prêt
                                </a>
                                <a href="${pageContext.request.contextPath}/pret/nouveau" 
                                   class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700">
                                    <i class="fas fa-plus-circle mr-2"></i>Demander un Prêt
                                </a>
                                <a href="${pageContext.request.contextPath}/pret/statistiques" 
                                   class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                    <i class="fas fa-chart-line mr-2"></i>Statistiques
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Informations sur les prêts -->
            <div class="mt-8">
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                            <i class="fas fa-info-circle mr-2"></i>Informations sur les Prêts
                        </h3>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div class="bg-blue-50 p-4 rounded-lg">
                                <h4 class="font-medium text-blue-900 mb-2">
                                    <i class="fas fa-percentage mr-2"></i>Taux Compétitifs
                                </h4>
                                <p class="text-sm text-blue-800">
                                    Bénéficiez de taux d'intérêt compétitifs adaptés à votre profil
                                    et à la durée de votre prêt.
                                </p>
                            </div>
                            <div class="bg-purple-50 p-4 rounded-lg">
                                <h4 class="font-medium text-purple-900 mb-2">
                                    <i class="fas fa-calendar-alt mr-2"></i>Flexibilité
                                </h4>
                                <p class="text-sm text-purple-800">
                                    Choisissez la durée qui vous convient et effectuez des
                                    remboursements anticipés sans pénalité.
                                </p>
                            </div>
                            <div class="bg-green-50 p-4 rounded-lg">
                                <h4 class="font-medium text-green-900 mb-2">
                                    <i class="fas fa-shield-alt mr-2"></i>Sécurité
                                </h4>
                                <p class="text-sm text-green-800">
                                    Tous vos prêts sont sécurisés et suivent les réglementations
                                    bancaires en vigueur.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        let sortDirection = {};
        let allRows = [];
        
        // Fonction pour formater les montants
        function formatCurrency(amount) {
            return new Intl.NumberFormat('fr-FR', { 
                style: 'currency', 
                currency: 'EUR' 
            }).format(amount);
        }
        
        
        // Fonction de tri du tableau
        function sortTable(columnIndex) {
            const table = document.getElementById('prets-table');
            const tbody = document.getElementById('prets-tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            
            // Déterminer la direction du tri
            const currentDirection = sortDirection[columnIndex] || 'asc';
            const newDirection = currentDirection === 'asc' ? 'desc' : 'asc';
            sortDirection[columnIndex] = newDirection;
            
            // Mettre à jour les icônes de tri
            document.querySelectorAll('th i.fas').forEach(icon => {
                icon.className = 'fas fa-sort ml-1';
            });
            const currentIcon = document.querySelector('th:nth-child(' + (columnIndex + 1) + ') i');
            currentIcon.className = 'fas fa-sort-' + (newDirection === 'asc' ? 'up' : 'down') + ' ml-1';
            
            // Trier les lignes
            rows.sort((a, b) => {
                let aValue, bValue;
                
                switch(columnIndex) {
                    case 0: // N° Prêt
                        aValue = parseInt(a.cells[0].textContent.replace('#', ''));
                        bValue = parseInt(b.cells[0].textContent.replace('#', ''));
                        break;
                    case 1: // Compte
                        aValue = a.cells[1].textContent.trim();
                        bValue = b.cells[1].textContent.trim();
                        break;
                    case 2: // Montant Initial
                    case 3: // Restant Dû
                        aValue = parseFloat(a.cells[columnIndex].querySelector('[data-montant]').getAttribute('data-montant'));
                        bValue = parseFloat(b.cells[columnIndex].querySelector('[data-montant]').getAttribute('data-montant'));
                        break;
                    case 4: // Taux
                        aValue = parseFloat(a.cells[4].querySelector('[data-taux]').getAttribute('data-taux')) || 0;
                        bValue = parseFloat(b.cells[4].querySelector('[data-taux]').getAttribute('data-taux')) || 0;
                        break;
                    case 5: // Durée
                        aValue = parseInt(a.cells[5].textContent.replace(' mois', ''));
                        bValue = parseInt(b.cells[5].textContent.replace(' mois', ''));
                        break;
                    case 6: // Statut
                        aValue = a.cells[6].textContent.trim();
                        bValue = b.cells[6].textContent.trim();
                        break;
                    case 7: // Date
                        aValue = new Date(a.cells[7].querySelector('[data-date]').getAttribute('data-date'));
                        bValue = new Date(b.cells[7].querySelector('[data-date]').getAttribute('data-date'));
                        break;
                    default:
                        aValue = a.cells[columnIndex].textContent.trim();
                        bValue = b.cells[columnIndex].textContent.trim();
                }
                
                if (typeof aValue === 'string') {
                    aValue = aValue.toLowerCase();
                    bValue = bValue.toLowerCase();
                }
                
                if (newDirection === 'asc') {
                    return aValue > bValue ? 1 : aValue < bValue ? -1 : 0;
                } else {
                    return aValue < bValue ? 1 : aValue > bValue ? -1 : 0;
                }
            });
            
            // Réinsérer les lignes triées
            rows.forEach(row => tbody.appendChild(row));
        }
        
        // Fonction de recherche et filtrage
        function filterTable() {
            const searchTerm = document.getElementById('search-input').value.toLowerCase();
            const statutFilter = document.getElementById('statut-filter').value;
            const dureeFilter = document.getElementById('duree-filter').value;
            
            const rows = document.querySelectorAll('#prets-tbody tr');
            let visibleCount = 0;
            
            rows.forEach(row => {
                const pretId = row.cells[0].textContent.toLowerCase();
                const compte = row.cells[1].textContent.toLowerCase();
                const statut = row.getAttribute('data-statut');
                const duree = row.getAttribute('data-duree');
                
                // Vérifier les critères de recherche
                const matchesSearch = pretId.includes(searchTerm) || compte.includes(searchTerm);
                const matchesStatut = !statutFilter || statut === statutFilter;
                const matchesDuree = !dureeFilter || duree === dureeFilter;
                
                if (matchesSearch && matchesStatut && matchesDuree) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            // Mettre à jour le compteur
            document.getElementById('resultat-count').textContent = visibleCount;
        }
        
        // Fonction d'export CSV
        function exportToCSV() {
            const table = document.getElementById('prets-table');
            const rows = table.querySelectorAll('tr');
            const csvContent = [];
            
            // En-têtes
            const headers = [];
            rows[0].querySelectorAll('th').forEach((th, index) => {
                if (index < 8) { // Exclure la colonne Remboursement
                    headers.push('"' + th.textContent.replace(/\s+/g, ' ').trim().replace('"', '""') + '"');
                }
            });
            csvContent.push(headers.join(','));
            
            // Données (seulement les lignes visibles)
            const visibleRows = Array.from(document.querySelectorAll('#prets-tbody tr')).filter(row => row.style.display !== 'none');
            visibleRows.forEach(row => {
                const rowData = [];
                for (let i = 0; i < 8; i++) { // Exclure la colonne Remboursement
                    let cellText = row.cells[i].textContent.replace(/\s+/g, ' ').trim();
                    // Nettoyer le texte pour le CSV
                    cellText = cellText.replace(/"/g, '""');
                    rowData.push('"' + cellText + '"');
                }
                csvContent.push(rowData.join(','));
            });
            
            // Télécharger le fichier
            const blob = new Blob([csvContent.join('\n')], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            const url = URL.createObjectURL(blob);
            link.setAttribute('href', url);
            link.setAttribute('download', 'prets_' + new Date().toISOString().split('T')[0] + '.csv');
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
        
        // Initialisation au chargement de la page
        document.addEventListener('DOMContentLoaded', function() {
            // Sauvegarder toutes les lignes pour le filtrage
            allRows = Array.from(document.querySelectorAll('#prets-tbody tr'));
            
            // Ajouter les écouteurs d'événements pour la recherche et les filtres
            document.getElementById('search-input').addEventListener('input', filterTable);
            document.getElementById('statut-filter').addEventListener('change', filterTable);
            document.getElementById('duree-filter').addEventListener('change', filterTable);
            
            // Animation des barres de progression
            const progressBars = document.querySelectorAll('.progress-bar');
            progressBars.forEach(bar => {
                const progress = bar.getAttribute('data-progress');
                if (progress) {
                    bar.style.width = '0%';
                    setTimeout(() => {
                        bar.style.transition = 'width 1s ease-in-out';
                        bar.style.width = progress + '%';
                    }, 100);
                }
            });

            // Mobile menu button event listener
            const mobileMenuButton = document.getElementById('mobile-menu-button');
            if (mobileMenuButton) {
                mobileMenuButton.addEventListener('click', toggleMobileSidebar);
            }
        });

        // Mobile sidebar toggle
        function toggleMobileSidebar() {
            const sidebar = document.getElementById('mobile-sidebar');
            sidebar.classList.toggle('hidden');
        }
    </script>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
