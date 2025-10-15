 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Système Bancaire - Accueil</title>
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
                       class="bg-blue-700 text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200 hover:bg-blue-600">
                        <i class="fas fa-home text-blue-200 mr-3 text-lg"></i>
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
                        <a href="${pageContext.request.contextPath}/accueil" class="bg-blue-700 text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
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
                            <h1 class="text-2xl font-semibold text-gray-900">Tableau de Bord</h1>
                        </div>
                        <div class="flex items-center space-x-4">
                            <div class="flex items-center space-x-2">
                                <div class="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center">
                                    <i class="fas fa-user text-gray-600"></i>
                                </div>
                                <span class="text-sm text-gray-700">Administrateur</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Page content -->
            <main class="flex-1 relative pb-8 overflow-y-auto">
                <div class="px-4 sm:px-6 lg:px-8 py-8">
        <!-- En-tête -->
        <div class="px-4 py-6 sm:px-0">
            <div class="text-center mb-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Bienvenue dans votre Système Bancaire</h1>
                <p class="text-lg text-gray-600">Gérez vos comptes, épargne et prêts en toute simplicité</p>
            </div>

            <!-- Statut du système -->
            <div class="mb-8">
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                            <i class="fas fa-server mr-2"></i>Statut du Système
                        </h3>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <!-- Service Comptes -->
                            <div class="flex items-center p-4 rounded-lg ${compteServiceDisponible ? 'bg-green-50 border border-green-200' : 'bg-red-50 border border-red-200'}">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-credit-card text-2xl ${compteServiceDisponible ? 'text-green-600' : 'text-red-600'}"></i>
                                </div>
                                <div class="ml-4">
                                    <p class="text-sm font-medium ${compteServiceDisponible ? 'text-green-800' : 'text-red-800'}">
                                        Service Comptes
                                    </p>
                                    <p class="text-sm ${compteServiceDisponible ? 'text-green-600' : 'text-red-600'}">
                                        ${compteServiceDisponible ? 'Opérationnel' : 'Indisponible'}
                                    </p>
                                </div>
                            </div>

                            <!-- Service Épargne -->
                            <div class="flex items-center p-4 rounded-lg ${epargneApiDisponible ? 'bg-green-50 border border-green-200' : 'bg-red-50 border border-red-200'}">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-piggy-bank text-2xl ${epargneApiDisponible ? 'text-green-600' : 'text-red-600'}"></i>
                                </div>
                                <div class="ml-4">
                                    <p class="text-sm font-medium ${epargneApiDisponible ? 'text-green-800' : 'text-red-800'}">
                                        Service Épargne
                                    </p>
                                    <p class="text-sm ${epargneApiDisponible ? 'text-green-600' : 'text-red-600'}">
                                        ${epargneApiDisponible ? 'Opérationnel' : 'Indisponible'}
                                    </p>
                                </div>
                            </div>

                            <!-- Service Prêts -->
                            <div class="flex items-center p-4 rounded-lg ${pretApiDisponible ? 'bg-green-50 border border-green-200' : 'bg-red-50 border border-red-200'}">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-hand-holding-usd text-2xl ${pretApiDisponible ? 'text-green-600' : 'text-red-600'}"></i>
                                </div>
                                <div class="ml-4">
                                    <p class="text-sm font-medium ${pretApiDisponible ? 'text-green-800' : 'text-red-800'}">
                                        Service Prêts
                                    </p>
                                    <p class="text-sm ${pretApiDisponible ? 'text-green-600' : 'text-red-600'}">
                                        ${pretApiDisponible ? 'Opérationnel' : 'Indisponible'}
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!-- Statut global -->
                        <div class="mt-4 p-4 rounded-lg ${systemeOperationnel ? 'bg-green-50 border border-green-200' : 'bg-yellow-50 border border-yellow-200'}">
                            <div class="flex items-center">
                                <i class="fas ${systemeOperationnel ? 'fa-check-circle text-green-600' : 'fa-exclamation-triangle text-yellow-600'} text-xl mr-3"></i>
                                <p class="text-sm font-medium ${systemeOperationnel ? 'text-green-800' : 'text-yellow-800'}">
                                    ${systemeOperationnel ? 'Tous les services sont opérationnels' : 'Certains services sont indisponibles'}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Statistiques rapides -->
            <c:if test="${compteServiceDisponible}">
                <div class="mb-8">
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="px-4 py-5 sm:p-6">
                            <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                                <i class="fas fa-chart-bar mr-2"></i>Aperçu Rapide
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="text-center p-6 bg-blue-50 rounded-lg">
                                    <div class="text-3xl font-bold text-blue-600">${nombreClients}</div>
                                    <div class="text-sm text-blue-800 mt-2">Clients</div>
                                </div>
                                <div class="text-center p-6 bg-green-50 rounded-lg">
                                    <div class="text-3xl font-bold text-green-600">${nombreComptes}</div>
                                    <div class="text-sm text-green-800 mt-2">Comptes</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Actions rapides -->
            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                <!-- Gestion des Clients -->
                <div class="bg-white overflow-hidden shadow-lg rounded-xl border border-gray-100 hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1">
                    <div class="px-6 py-8">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <div class="w-12 h-12 bg-gradient-to-r from-green-400 to-green-600 rounded-xl flex items-center justify-center">
                                    <i class="fas fa-users text-white text-xl"></i>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <h3 class="text-lg font-semibold text-gray-900">Gestion des Clients</h3>
                                <p class="text-sm text-gray-500 mt-1">Clients & Prospects</p>
                            </div>
                        </div>
                        <div class="mt-6">
                            <a href="${pageContext.request.contextPath}/client/list" 
                               class="w-full flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-lg text-white bg-gradient-to-r from-green-500 to-green-600 hover:from-green-600 hover:to-green-700 transition-all duration-200 shadow-md hover:shadow-lg">
                                <i class="fas fa-arrow-right mr-2"></i>Gérer les Clients
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Gestion des Comptes -->
                <div class="bg-white overflow-hidden shadow-lg rounded-xl border border-gray-100 hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1">
                    <div class="px-6 py-8">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <div class="w-12 h-12 bg-gradient-to-r from-blue-400 to-blue-600 rounded-xl flex items-center justify-center">
                                    <i class="fas fa-credit-card text-white text-xl"></i>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <h3 class="text-lg font-semibold text-gray-900">Gestion des Comptes</h3>
                                <p class="text-sm text-gray-500 mt-1">Comptes Courants</p>
                            </div>
                        </div>
                        <div class="mt-6">
                            <a href="${pageContext.request.contextPath}/compte/list" 
                               class="w-full flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-lg text-white bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 transition-all duration-200 shadow-md hover:shadow-lg">
                                <i class="fas fa-arrow-right mr-2"></i>Voir les Comptes
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Historique des Opérations -->
                <div class="bg-white overflow-hidden shadow-lg rounded-xl border border-gray-100 hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1">
                    <div class="px-6 py-8">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <div class="w-12 h-12 bg-gradient-to-r from-indigo-400 to-indigo-600 rounded-xl flex items-center justify-center">
                                    <i class="fas fa-exchange-alt text-white text-xl"></i>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <h3 class="text-lg font-semibold text-gray-900">Opérations</h3>
                                <p class="text-sm text-gray-500 mt-1">Transactions & Mouvements</p>
                            </div>
                        </div>
                        <div class="mt-6">
                            <a href="${pageContext.request.contextPath}/operations/list" 
                               class="w-full flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-lg text-white bg-gradient-to-r from-indigo-500 to-indigo-600 hover:from-indigo-600 hover:to-indigo-700 transition-all duration-200 shadow-md hover:shadow-lg">
                                <i class="fas fa-arrow-right mr-2"></i>Voir les Opérations
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Gestion de l'Épargne -->
                <div class="bg-white overflow-hidden shadow-lg rounded-xl border border-gray-100 hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1">
                    <div class="px-6 py-8">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <div class="w-12 h-12 bg-gradient-to-r from-emerald-400 to-emerald-600 rounded-xl flex items-center justify-center">
                                    <i class="fas fa-piggy-bank text-white text-xl"></i>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <h3 class="text-lg font-semibold text-gray-900">Épargne</h3>
                                <p class="text-sm text-gray-500 mt-1">Dépôts & Retraits</p>
                            </div>
                        </div>
                        <div class="mt-6">
                            <a href="${pageContext.request.contextPath}/epargne/list" 
                               class="w-full flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-lg text-white bg-gradient-to-r from-emerald-500 to-emerald-600 hover:from-emerald-600 hover:to-emerald-700 transition-all duration-200 shadow-md hover:shadow-lg ${!epargneApiDisponible ? 'opacity-50 cursor-not-allowed' : ''}">
                                <i class="fas fa-arrow-right mr-2"></i>Gérer l'Épargne
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Gestion des Prêts -->
                <div class="bg-white overflow-hidden shadow-lg rounded-xl border border-gray-100 hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1">
                    <div class="px-6 py-8">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <div class="w-12 h-12 bg-gradient-to-r from-purple-400 to-purple-600 rounded-xl flex items-center justify-center">
                                    <i class="fas fa-hand-holding-usd text-white text-xl"></i>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <h3 class="text-lg font-semibold text-gray-900">Prêts</h3>
                                <p class="text-sm text-gray-500 mt-1">Prêts & Remboursements</p>
                            </div>
                        </div>
                        <div class="mt-6">
                            <a href="${pageContext.request.contextPath}/pret/list" 
                               class="w-full flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-lg text-white bg-gradient-to-r from-purple-500 to-purple-600 hover:from-purple-600 hover:to-purple-700 transition-all duration-200 shadow-md hover:shadow-lg ${!pretApiDisponible ? 'opacity-50 cursor-not-allowed' : ''}">
                                <i class="fas fa-arrow-right mr-2"></i>Gérer les Prêts
                            </a>
                        </div>
                    </div>
                </div>
            </div>
                </div>
                </div>
            </main>
        </div>
    </div>

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
</body>
</html>
