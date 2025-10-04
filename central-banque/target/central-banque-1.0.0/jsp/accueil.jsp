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
                    <a href="${pageContext.request.contextPath}/accueil" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium bg-blue-700">
                        <i class="fas fa-home mr-2"></i>Accueil
                    </a>
                    <a href="${pageContext.request.contextPath}/compte/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
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
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- Gestion des Comptes -->
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-credit-card text-3xl text-blue-600"></i>
                            </div>
                            <div class="ml-5 w-0 flex-1">
                                <dl>
                                    <dt class="text-sm font-medium text-gray-500 truncate">Gestion des Comptes</dt>
                                    <dd class="text-lg font-medium text-gray-900">Comptes Courants</dd>
                                </dl>
                            </div>
                        </div>
                        <div class="mt-5">
                            <div class="rounded-md shadow">
                                <a href="${pageContext.request.contextPath}/compte/list" 
                                   class="w-full flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                    Voir les Comptes
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Gestion de l'Épargne -->
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-piggy-bank text-3xl text-green-600"></i>
                            </div>
                            <div class="ml-5 w-0 flex-1">
                                <dl>
                                    <dt class="text-sm font-medium text-gray-500 truncate">Gestion de l'Épargne</dt>
                                    <dd class="text-lg font-medium text-gray-900">Dépôts & Retraits</dd>
                                </dl>
                            </div>
                        </div>
                        <div class="mt-5">
                            <div class="rounded-md shadow">
                                <a href="${pageContext.request.contextPath}/epargne/list" 
                                   class="w-full flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-white bg-green-600 hover:bg-green-700 ${!epargneApiDisponible ? 'opacity-50 cursor-not-allowed' : ''}">
                                    Gérer l'Épargne
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Gestion des Prêts -->
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-hand-holding-usd text-3xl text-purple-600"></i>
                            </div>
                            <div class="ml-5 w-0 flex-1">
                                <dl>
                                    <dt class="text-sm font-medium text-gray-500 truncate">Gestion des Prêts</dt>
                                    <dd class="text-lg font-medium text-gray-900">Prêts & Remboursements</dd>
                                </dl>
                            </div>
                        </div>
                        <div class="mt-5">
                            <div class="rounded-md shadow">
                                <a href="${pageContext.request.contextPath}/pret/list" 
                                   class="w-full flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700 ${!pretApiDisponible ? 'opacity-50 cursor-not-allowed' : ''}">
                                    Gérer les Prêts
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8 mt-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center">
                <p class="text-sm">© 2025 Système Bancaire - Projet EJB & C# API</p>
                <p class="text-xs text-gray-400 mt-2">Architecture: Java EE (WildFly) + C# APIs + PostgreSQL</p>
            </div>
        </div>
    </footer>
</body>
</html>
