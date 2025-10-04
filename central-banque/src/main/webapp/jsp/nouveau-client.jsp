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
                    <a href="${pageContext.request.contextPath}/client/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium bg-blue-700">
                        <i class="fas fa-users mr-2"></i>Clients
                    </a>
                    <a href="${pageContext.request.contextPath}/compte/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
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
</body>
</html>
