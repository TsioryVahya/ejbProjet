<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du Client - Système Bancaire</title>
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
                       class="bg-blue-700 text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200 hover:bg-blue-600">
                        <i class="fas fa-users text-blue-200 mr-3 text-lg"></i>
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
                        <a href="${pageContext.request.contextPath}/accueil" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-home mr-3"></i>Tableau de Bord
                        </a>
                        <a href="${pageContext.request.contextPath}/client/list" class="bg-blue-700 text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
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
                            <h1 class="text-2xl font-semibold text-gray-900">Détails du Client</h1>
                        </div>
                        <div class="flex items-center space-x-4">
                            <a href="${pageContext.request.contextPath}/client/list" 
                               class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-lg text-gray-700 bg-white hover:bg-gray-50 shadow-sm transition-all duration-200">
                                <i class="fas fa-arrow-left mr-2"></i>Retour à la liste
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Page content -->
            <main class="flex-1 relative pb-8 overflow-y-auto">
                <div class="px-4 sm:px-6 lg:px-8 py-8">

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
                        <h1 class="text-3xl font-bold text-gray-900">Détails du Client</h1>
                        <p class="mt-2 text-sm text-gray-600">Informations détaillées de ${client.prenom} ${client.nom}</p>
                    </div>
                    <div class="flex space-x-3">
                        <a href="${pageContext.request.contextPath}/client/list" 
                           class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <i class="fas fa-arrow-left mr-2"></i>
                            Retour à la liste
                        </a>
                        <button onclick="toggleEditMode()" 
                                class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <i class="fas fa-edit mr-2"></i>
                            Modifier
                        </button>
                    </div>
                </div>
            </div>

            <!-- Informations du client -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg mb-6">
                <div class="px-4 py-5 sm:px-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Informations personnelles</h3>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">Détails et coordonnées du client</p>
                </div>
                <div class="border-t border-gray-200">
                    <!-- Mode affichage -->
                    <div id="displayMode">
                        <dl>
                            <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                <dt class="text-sm font-medium text-gray-500">ID Client</dt>
                                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">#${client.idClient}</dd>
                            </div>
                            <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                <dt class="text-sm font-medium text-gray-500">Nom complet</dt>
                                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 font-medium">
                                    ${client.prenom} ${client.nom}
                                </dd>
                            </div>
                            <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                <dt class="text-sm font-medium text-gray-500">Email</dt>
                                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                    <c:choose>
                                        <c:when test="${not empty client.email}">
                                            <a href="mailto:${client.email}" class="text-blue-600 hover:text-blue-500">
                                                ${client.email}
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-gray-400 italic">Non renseigné</span>
                                        </c:otherwise>
                                    </c:choose>
                                </dd>
                            </div>
                            <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                <dt class="text-sm font-medium text-gray-500">Téléphone</dt>
                                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                    <c:choose>
                                        <c:when test="${not empty client.telephone}">
                                            <a href="tel:${client.telephone}" class="text-blue-600 hover:text-blue-500">
                                                ${client.telephone}
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-gray-400 italic">Non renseigné</span>
                                        </c:otherwise>
                                    </c:choose>
                                </dd>
                            </div>
                            <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                <dt class="text-sm font-medium text-gray-500">Date de création</dt>
                                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                    ${client.dateCreation}
                                </dd>
                            </div>
                        </dl>
                    </div>

                    <!-- Mode édition -->
                    <div id="editMode" class="hidden">
                        <form action="${pageContext.request.contextPath}/client/modifier" method="post" class="p-6">
                            <input type="hidden" name="idClient" value="${client.idClient}">
                            <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
                                <div>
                                    <label for="nom" class="block text-sm font-medium text-gray-700">Nom *</label>
                                    <input type="text" name="nom" id="nom" value="${client.nom}" required
                                           class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                                </div>
                                <div>
                                    <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom *</label>
                                    <input type="text" name="prenom" id="prenom" value="${client.prenom}" required
                                           class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                                </div>
                                <div>
                                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                                    <input type="email" name="email" id="email" value="${client.email}"
                                           class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                                </div>
                                <div>
                                    <label for="telephone" class="block text-sm font-medium text-gray-700">Téléphone</label>
                                    <input type="tel" name="telephone" id="telephone" value="${client.telephone}"
                                           class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                                </div>
                            </div>
                            <div class="mt-6 flex justify-end space-x-3">
                                <button type="button" onclick="toggleEditMode()" 
                                        class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    Annuler
                                </button>
                                <button type="submit" 
                                        class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    <i class="fas fa-save mr-2"></i>
                                    Enregistrer
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Comptes du client -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:px-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Comptes bancaires</h3>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">
                        <c:choose>
                            <c:when test="${not empty comptes}">
                                ${comptes.size()} compte(s) associé(s) à ce client
                            </c:when>
                            <c:otherwise>
                                Aucun compte associé à ce client
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                
                <c:choose>
                    <c:when test="${not empty comptes}">
                        <div class="border-t border-gray-200">
                            <ul role="list" class="divide-y divide-gray-200">
                                <c:forEach var="compte" items="${comptes}">
                                    <li class="px-4 py-4 sm:px-6">
                                        <div class="flex items-center justify-between">
                                            <div class="flex items-center">
                                                <div class="flex-shrink-0">
                                                    <div class="h-10 w-10 rounded-full bg-blue-100 flex items-center justify-center">
                                                        <i class="fas fa-credit-card text-blue-600"></i>
                                                    </div>
                                                </div>
                                                <div class="ml-4">
                                                    <div class="flex items-center">
                                                        <p class="text-sm font-medium text-gray-900 font-mono">
                                                            ${compte.numeroCompte}
                                                        </p>
                                                        <c:choose>
                                                            <c:when test="${compte.actif}">
                                                                <span class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                                    <i class="fas fa-check-circle mr-1"></i>
                                                                    Actif
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                                                    <i class="fas fa-times-circle mr-1"></i>
                                                                    Inactif
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <p class="text-sm text-gray-500">
                                                        <c:choose>
                                                            <c:when test="${not empty compte.typeCompte}">
                                                                ${compte.typeCompte.nomTypeCompte}
                                                            </c:when>
                                                            <c:otherwise>
                                                                Type non défini
                                                            </c:otherwise>
                                                        </c:choose>
                                                        • Créé le ${compte.dateCreation}
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="flex items-center space-x-2">
                                                <a href="${pageContext.request.contextPath}/compte/details?id=${compte.idCompte}" 
                                                   class="inline-flex items-center px-3 py-1 border border-transparent text-sm leading-4 font-medium rounded-md text-blue-700 bg-blue-100 hover:bg-blue-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                                    <i class="fas fa-eye mr-1"></i>
                                                    Détails
                                                </a>
                                                <a href="${pageContext.request.contextPath}/compte/operations?id=${compte.idCompte}" 
                                                   class="inline-flex items-center px-3 py-1 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-700 bg-gray-100 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500">
                                                    <i class="fas fa-list mr-1"></i>
                                                    Opérations
                                                </a>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-12">
                            <i class="fas fa-credit-card text-gray-400 text-6xl mb-4"></i>
                            <h3 class="mt-2 text-sm font-medium text-gray-900">Aucun compte</h3>
                            <p class="mt-1 text-sm text-gray-500">Ce client n'a encore aucun compte bancaire.</p>
                            <div class="mt-6">
                                <a href="${pageContext.request.contextPath}/compte/nouveau?clientId=${client.idClient}" 
                                   class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    <i class="fas fa-plus mr-2"></i>
                                    Créer un compte
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
                <p class="text-sm">© 2025 Système Bancaire - Projet EJB & C# API</p>
                <p class="text-xs text-gray-400 mt-2">Gestion des clients</p>
            </div>
        </div>
    </footer>

    <script>
        function toggleEditMode() {
            const displayMode = document.getElementById('displayMode');
            const editMode = document.getElementById('editMode');
            
            if (displayMode.classList.contains('hidden')) {
                displayMode.classList.remove('hidden');
                editMode.classList.add('hidden');
            } else {
                displayMode.classList.add('hidden');
                editMode.classList.remove('hidden');
            }
        }
    </script>
    <script>
        // Mobile sidebar toggle
        function toggleMobileSidebar() {
            const sidebar = document.getElementById('mobile-sidebar');
            sidebar.classList.toggle('hidden');
        }

        // Mobile menu button event listener
        document.addEventListener('DOMContentLoaded', function() {
            const mobileMenuButton = document.getElementById('mobile-menu-button');
            if (mobileMenuButton) {
                mobileMenuButton.addEventListener('click', toggleMobileSidebar);
            }
        });
    </script>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
