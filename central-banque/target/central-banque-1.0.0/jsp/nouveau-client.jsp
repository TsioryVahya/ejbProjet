<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau Client - Système Bancaire</title>
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
                            <h1 class="text-2xl font-semibold text-gray-900">Nouveau Client</h1>
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
    <div class="max-w-4xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- En-tête -->
        <div class="px-4 py-6 sm:px-0">
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Créer un Nouveau Client</h1>
                    <p class="text-gray-600 mt-2">Remplissez les informations pour créer un nouveau client</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/client/list" 
                       class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                        <i class="fas fa-arrow-left mr-2"></i>Retour à la liste
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

            <!-- Formulaire de création -->
            <div class="bg-white shadow rounded-lg">
                <div class="px-4 py-5 sm:p-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900 mb-6">
                        <i class="fas fa-user-plus mr-2 text-blue-600"></i>Informations du Client
                    </h3>

                    <form action="${pageContext.request.contextPath}/client/creer" method="post" class="space-y-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Nom -->
                            <div>
                                <label for="nom" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-user mr-1"></i>Nom *
                                </label>
                                <input type="text" 
                                       id="nom" 
                                       name="nom" 
                                       required 
                                       value="${nom}"
                                       placeholder="Nom de famille"
                                       class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                            </div>

                            <!-- Prénom -->
                            <div>
                                <label for="prenom" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-user mr-1"></i>Prénom *
                                </label>
                                <input type="text" 
                                       id="prenom" 
                                       name="prenom" 
                                       required 
                                       value="${prenom}"
                                       placeholder="Prénom"
                                       class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Email -->
                            <div>
                                <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-envelope mr-1"></i>Email
                                </label>
                                <input type="email" 
                                       id="email" 
                                       name="email" 
                                       value="${email}"
                                       placeholder="exemple@email.com"
                                       class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                <p class="mt-1 text-xs text-gray-500">Adresse email pour les communications</p>
                            </div>

                            <!-- Téléphone -->
                            <div>
                                <label for="telephone" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-phone mr-1"></i>Téléphone
                                </label>
                                <input type="tel" 
                                       id="telephone" 
                                       name="telephone" 
                                       value="${telephone}"
                                       placeholder="01 23 45 67 89"
                                       class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                <p class="mt-1 text-xs text-gray-500">Numéro de téléphone de contact</p>
                            </div>
                        </div>

                        <!-- Boutons d'action -->
                        <div class="flex justify-end space-x-3 pt-6 border-t border-gray-200">
                            <a href="${pageContext.request.contextPath}/client/list" 
                               class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                <i class="fas fa-times mr-2"></i>Annuler
                            </a>
                            <button type="submit" 
                                    class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                <i class="fas fa-plus mr-2"></i>Créer le Client
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Informations supplémentaires -->
            <div class="mt-8 bg-blue-50 border border-blue-200 rounded-lg p-4">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="fas fa-info-circle text-blue-400 text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <h3 class="text-sm font-medium text-blue-800">Informations importantes</h3>
                        <div class="mt-2 text-sm text-blue-700">
                            <ul class="list-disc list-inside space-y-1">
                                <li>Les champs marqués d'un astérisque (*) sont obligatoires</li>
                                <li>L'email et le téléphone sont optionnels mais recommandés pour les communications</li>
                                <li>Après création, vous pourrez créer des comptes pour ce client</li>
                                <li>Les informations peuvent être modifiées ultérieurement</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Actions rapides après création -->
            <div class="mt-6 bg-gray-50 border border-gray-200 rounded-lg p-4">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="fas fa-lightbulb text-yellow-400 text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <h3 class="text-sm font-medium text-gray-800">Prochaines étapes</h3>
                        <div class="mt-2 text-sm text-gray-600">
                            <p>Après avoir créé ce client, vous pourrez :</p>
                            <ul class="list-disc list-inside space-y-1 mt-2">
                                <li>Créer un ou plusieurs comptes bancaires</li>
                                <li>Consulter l'historique des opérations</li>
                                <li>Gérer les produits d'épargne et les prêts</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Validation du formulaire
        document.querySelector('form').addEventListener('submit', function(e) {
            const nom = document.getElementById('nom').value.trim();
            const prenom = document.getElementById('prenom').value.trim();

            if (!nom) {
                e.preventDefault();
                alert('Veuillez saisir le nom du client');
                document.getElementById('nom').focus();
                return;
            }

            if (!prenom) {
                e.preventDefault();
                alert('Veuillez saisir le prénom du client');
                document.getElementById('prenom').focus();
                return;
            }

            // Validation de l'email si fourni
            const email = document.getElementById('email').value.trim();
            if (email && !isValidEmail(email)) {
                e.preventDefault();
                alert('Veuillez saisir une adresse email valide');
                document.getElementById('email').focus();
                return;
            }
        });

        // Fonction de validation email
        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }

        // Auto-focus sur le premier champ
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('nom').focus();
        });

        // Formatage automatique du téléphone
        document.getElementById('telephone').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 0) {
                value = value.match(/.{1,2}/g).join(' ');
                if (value.length > 14) {
                    value = value.substring(0, 14);
                }
            }
            e.target.value = value;
        });

        // Capitalisation automatique des noms
        document.getElementById('nom').addEventListener('blur', function(e) {
            e.target.value = e.target.value.toUpperCase();
        });

        document.getElementById('prenom').addEventListener('blur', function(e) {
            e.target.value = e.target.value.charAt(0).toUpperCase() + e.target.value.slice(1).toLowerCase();
        });
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
