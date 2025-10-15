<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Opérations du Compte - Système Bancaire</title>
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
                       class="bg-blue-700 text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200 hover:bg-blue-600">
                        <i class="fas fa-exchange-alt text-blue-200 mr-3 text-lg"></i>
                        <span>Opérations</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/epargne/list" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-piggy-bank text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Épargne</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/pret/list" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-hand-holding-usd text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
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
                        <a href="${pageContext.request.contextPath}/operations/list" class="bg-blue-700 text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-exchange-alt mr-3"></i>Opérations
                        </a>
                        <a href="${pageContext.request.contextPath}/epargne/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-piggy-bank mr-3"></i>Épargne
                        </a>
                        <a href="${pageContext.request.contextPath}/pret/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
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
                            <h1 class="text-2xl font-semibold text-gray-900">Opérations du Compte</h1>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Page content -->
            <main class="flex-1 relative pb-8 overflow-y-auto">
                <div class="px-4 sm:px-6 lg:px-8 py-8">
        <div class="px-4 py-6 sm:px-0">
            <!-- En-tête -->
            <div class="mb-6">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Opérations du Compte</h1>
                        <p class="mt-2 text-sm text-gray-600">
                            Historique des opérations pour le compte 
                            <span class="font-mono font-medium">${compte.numeroCompte}</span>
                        </p>
                    </div>
                    <div class="flex space-x-3">
                        <a href="${pageContext.request.contextPath}/compte/details?id=${compte.idCompte}" 
                           class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <i class="fas fa-info-circle mr-2"></i>
                            Détails du compte
                        </a>
                        <a href="${pageContext.request.contextPath}/compte/list" 
                           class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <i class="fas fa-arrow-left mr-2"></i>
                            Retour à la liste
                        </a>
                    </div>
                </div>
            </div>

            <!-- Informations du compte -->
            <div class="bg-white shadow sm:rounded-lg mb-6">
                <div class="px-4 py-5 sm:p-6">
                    <div class="grid grid-cols-1 gap-5 sm:grid-cols-3">
                        <div class="bg-gray-50 overflow-hidden shadow rounded-lg">
                            <div class="p-5">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0">
                                        <i class="fas fa-credit-card text-gray-400 text-2xl"></i>
                                    </div>
                                    <div class="ml-5 w-0 flex-1">
                                        <dl>
                                            <dt class="text-sm font-medium text-gray-500 truncate">Numéro de compte</dt>
                                            <dd class="text-lg font-medium text-gray-900 font-mono">${compte.numeroCompte}</dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="bg-gray-50 overflow-hidden shadow rounded-lg">
                            <div class="p-5">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0">
                                        <i class="fas fa-user text-gray-400 text-2xl"></i>
                                    </div>
                                    <div class="ml-5 w-0 flex-1">
                                        <dl>
                                            <dt class="text-sm font-medium text-gray-500 truncate">Titulaire</dt>
                                            <dd class="text-lg font-medium text-gray-900">
                                                <c:choose>
                                                    <c:when test="${not empty compte.client}">
                                                        ${compte.client.prenom} ${compte.client.nom}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Non disponible
                                                    </c:otherwise>
                                                </c:choose>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="bg-gray-50 overflow-hidden shadow rounded-lg">
                            <div class="p-5">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0">
                                        <i class="fas fa-euro-sign text-gray-400 text-2xl"></i>
                                    </div>
                                    <div class="ml-5 w-0 flex-1">
                                        <dl>
                                            <dt class="text-sm font-medium text-gray-500 truncate">Solde actuel</dt>
                                            <dd class="text-lg font-medium text-gray-900">
                                                <c:choose>
                                                    <c:when test="${compte.solde != null}">
                                                        <fmt:formatNumber value="${compte.solde}" type="currency" currencySymbol="€" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        0,00 €
                                                    </c:otherwise>
                                                </c:choose>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Liste des opérations -->
            <div class="bg-white shadow overflow-hidden sm:rounded-md">
                <div class="px-4 py-5 sm:px-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Historique des opérations</h3>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">
                        <c:choose>
                            <c:when test="${not empty operations}">
                                ${operations.size()} opération(s) trouvée(s)
                            </c:when>
                            <c:otherwise>
                                Aucune opération trouvée pour ce compte
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                
                <c:choose>
                    <c:when test="${not empty operations}">
                        <ul role="list" class="divide-y divide-gray-200">
                            <c:forEach var="operation" items="${operations}">
                                <li class="px-4 py-4 sm:px-6">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0">
                                                <c:choose>
                                                    <c:when test="${operation.typeOperation == 'DEPOT' || operation.typeOperation == 'VIREMENT_CREDIT' || operation.typeOperation == 'SOLDE_INITIAL'}">
                                                        <div class="h-10 w-10 rounded-full bg-green-100 flex items-center justify-center">
                                                            <i class="fas fa-plus text-green-600"></i>
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${operation.typeOperation == 'RETRAIT' || operation.typeOperation == 'VIREMENT_DEBIT'}">
                                                        <div class="h-10 w-10 rounded-full bg-red-100 flex items-center justify-center">
                                                            <i class="fas fa-minus text-red-600"></i>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="h-10 w-10 rounded-full bg-gray-100 flex items-center justify-center">
                                                            <i class="fas fa-exchange-alt text-gray-600"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="ml-4">
                                                <div class="flex items-center">
                                                    <p class="text-sm font-medium text-gray-900">
                                                        ${operation.typeOperation}
                                                    </p>
                                                    <c:if test="${not empty operation.descriptionTypeOperation}">
                                                        <span class="ml-2 text-xs text-gray-500">
                                                            (${operation.descriptionTypeOperation})
                                                        </span>
                                                    </c:if>
                                                </div>
                                                <p class="text-sm text-gray-500">
                                                    <c:choose>
                                                        <c:when test="${not empty operation.description}">
                                                            ${operation.description}
                                                        </c:when>
                                                        <c:otherwise>
                                                            Aucune description
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <p class="text-xs text-gray-400">
                                                    ${operation.dateOperation}
                                                </p>
                                            </div>
                                        </div>
                                        <div class="flex items-center">
                                            <c:choose>
                                                <c:when test="${operation.typeOperation == 'DEPOT' || operation.typeOperation == 'VIREMENT_CREDIT' || operation.typeOperation == 'SOLDE_INITIAL'}">
                                                    <span class="text-lg font-semibold text-green-600">
                                                        +<fmt:formatNumber value="${operation.montant}" type="currency" currencySymbol="€" />
                                                    </span>
                                                </c:when>
                                                <c:when test="${operation.typeOperation == 'RETRAIT' || operation.typeOperation == 'VIREMENT_DEBIT'}">
                                                    <span class="text-lg font-semibold text-red-600">
                                                        -<fmt:formatNumber value="${operation.montant}" type="currency" currencySymbol="€" />
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-lg font-semibold text-gray-600">
                                                        <fmt:formatNumber value="${operation.montant}" type="currency" currencySymbol="€" />
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-12">
                            <i class="fas fa-receipt text-gray-400 text-6xl mb-4"></i>
                            <h3 class="mt-2 text-sm font-medium text-gray-900">Aucune opération</h3>
                            <p class="mt-1 text-sm text-gray-500">Ce compte n'a encore aucune opération enregistrée.</p>
                            <div class="mt-6">
                                <a href="${pageContext.request.contextPath}/compte/details?id=${compte.idCompte}" 
                                   class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    <i class="fas fa-plus mr-2"></i>
                                    Effectuer une opération
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8 mt-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center">
                <p class="text-sm"> 2025 Système Bancaire - Projet EJB & C# API</p>
                <p class="text-xs text-gray-400 mt-2">Historique des opérations bancaires</p>
            </div>
        </div>
    </footer>
    <script>
        // Mobile sidebar functionality
        function toggleMobileSidebar() {
            const sidebar = document.getElementById('mobile-sidebar');
            sidebar.classList.toggle('hidden');
        }

        // Mobile menu button functionality
        document.getElementById('mobile-menu-button').addEventListener('click', toggleMobileSidebar);

        // Close mobile sidebar when clicking outside
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('mobile-sidebar');
            const menuButton = document.getElementById('mobile-menu-button');
            
            if (!sidebar.contains(event.target) && !menuButton.contains(event.target)) {
                sidebar.classList.add('hidden');
            }
        });
    </script>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
