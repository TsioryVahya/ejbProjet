<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du Compte - Système Bancaire</title>
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
        <div class="px-4 py-6 sm:px-0">
            <!-- En-tête -->
            <div class="mb-6">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Détails du Compte</h1>
                        <p class="mt-2 text-sm text-gray-600">Informations détaillées du compte ${compte.numeroCompte}</p>
                    </div>
                    <div class="flex space-x-3">
                        <a href="${pageContext.request.contextPath}/compte/list" 
                           class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <i class="fas fa-arrow-left mr-2"></i>
                            Retour à la liste
                        </a>
                        <a href="${pageContext.request.contextPath}/compte/operations?id=${compte.idCompte}" 
                           class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <i class="fas fa-list mr-2"></i>
                            Voir les opérations
                        </a>
                    </div>
                </div>
            </div>

            <!-- Informations du compte -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg mb-6">
                <div class="px-4 py-5 sm:px-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Informations du compte</h3>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">Détails et informations du compte bancaire</p>
                </div>
                <div class="border-t border-gray-200">
                    <dl>
                        <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Numéro de compte</dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 font-mono">${compte.numeroCompte}</dd>
                        </div>
                        <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Solde actuel</dt>
                            <dd class="mt-1 text-sm sm:mt-0 sm:col-span-2">
                                <span class="text-2xl font-bold ${compte.solde >= 0 ? 'text-green-600' : 'text-red-600'}">
                                    <fmt:formatNumber value="${compte.solde}" type="currency" currencySymbol="€" />
                                </span>
                            </dd>
                        </div>
                        <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Type de compte</dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                ${compte.nomTypeCompte}
                                <c:if test="${not empty compte.descriptionTypeCompte}">
                                    <span class="text-gray-500"> - ${compte.descriptionTypeCompte}</span>
                                </c:if>
                            </dd>
                        </div>
                        <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Date de création</dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                ${compte.dateCreation}
                            </dd>
                        </div>
                        <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Dernière modification</dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                ${compte.dateModification}
                            </dd>
                        </div>
                        <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                            <dt class="text-sm font-medium text-gray-500">Statut</dt>
                            <dd class="mt-1 text-sm sm:mt-0 sm:col-span-2">
                                <c:choose>
                                    <c:when test="${compte.actif}">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                            <i class="fas fa-check-circle mr-1"></i>
                                            Actif
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                            <i class="fas fa-times-circle mr-1"></i>
                                            Inactif
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </dd>
                        </div>
                    </dl>
                </div>
            </div>

            <!-- Informations du client -->
            <c:if test="${not empty compte.nomClient}">
                <div class="bg-white shadow overflow-hidden sm:rounded-lg mb-6">
                    <div class="px-4 py-5 sm:px-6">
                        <h3 class="text-lg leading-6 font-medium text-gray-900">Informations du titulaire</h3>
                        <p class="mt-1 max-w-2xl text-sm text-gray-500">Détails du client propriétaire du compte</p>
                    </div>
                    <div class="border-t border-gray-200">
                        <dl>
                            <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                <dt class="text-sm font-medium text-gray-500">Nom complet</dt>
                                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                    ${compte.prenomClient} ${compte.nomClient}
                                </dd>
                            </div>
                            <c:if test="${not empty compte.emailClient}">
                                <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                    <dt class="text-sm font-medium text-gray-500">Email</dt>
                                    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                        <a href="mailto:${compte.emailClient}" class="text-blue-600 hover:text-blue-500">
                                            ${compte.emailClient}
                                        </a>
                                    </dd>
                                </div>
                            </c:if>
                            <c:if test="${not empty compte.telephoneClient}">
                                <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                    <dt class="text-sm font-medium text-gray-500">Téléphone</dt>
                                    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                        <a href="tel:${compte.telephoneClient}" class="text-blue-600 hover:text-blue-500">
                                            ${compte.telephoneClient}
                                        </a>
                                    </dd>
                                </div>
                            </c:if>
                        </dl>
                    </div>
                </div>
            </c:if>

            <!-- Actions rapides -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:px-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Actions rapides</h3>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">Opérations disponibles pour ce compte</p>
                </div>
                <div class="border-t border-gray-200 px-4 py-5 sm:px-6">
                    <div class="grid grid-cols-1 gap-4 sm:grid-cols-3">
                        <!-- Dépôt -->
                        <div class="bg-green-50 border border-green-200 rounded-lg p-4">
                            <div class="flex items-center">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-plus-circle text-green-600 text-2xl"></i>
                                </div>
                                <div class="ml-4 flex-1">
                                    <h4 class="text-sm font-medium text-green-900">Effectuer un dépôt</h4>
                                    <p class="text-sm text-green-700">Ajouter des fonds au compte</p>
                                </div>
                            </div>
                            <div class="mt-3">
                                <form action="${pageContext.request.contextPath}/compte/depot" method="post" class="space-y-2">
                                    <input type="hidden" name="idCompte" value="${compte.idCompte}">
                                    <input type="number" name="montant" step="0.01" min="0.01" placeholder="Montant" 
                                           class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500 sm:text-sm" required>
                                    <input type="text" name="description" placeholder="Description (optionnel)" 
                                           class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-green-500 focus:border-green-500 sm:text-sm">
                                    <button type="submit" class="w-full inline-flex justify-center items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                        <i class="fas fa-plus mr-2"></i>Déposer
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Retrait -->
                        <div class="bg-red-50 border border-red-200 rounded-lg p-4">
                            <div class="flex items-center">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-minus-circle text-red-600 text-2xl"></i>
                                </div>
                                <div class="ml-4 flex-1">
                                    <h4 class="text-sm font-medium text-red-900">Effectuer un retrait</h4>
                                    <p class="text-sm text-red-700">Retirer des fonds du compte</p>
                                </div>
                            </div>
                            <div class="mt-3">
                                <form action="${pageContext.request.contextPath}/compte/retrait" method="post" class="space-y-2">
                                    <input type="hidden" name="idCompte" value="${compte.idCompte}">
                                    <input type="number" name="montant" step="0.01" min="0.01" max="${compte.solde}" placeholder="Montant" 
                                           class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-red-500 focus:border-red-500 sm:text-sm" required>
                                    <input type="text" name="description" placeholder="Description (optionnel)" 
                                           class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-red-500 focus:border-red-500 sm:text-sm">
                                    <button type="submit" class="w-full inline-flex justify-center items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                                        <i class="fas fa-minus mr-2"></i>Retirer
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Virement -->
                        <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
                            <div class="flex items-center">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-exchange-alt text-blue-600 text-2xl"></i>
                                </div>
                                <div class="ml-4 flex-1">
                                    <h4 class="text-sm font-medium text-blue-900">Effectuer un virement</h4>
                                    <p class="text-sm text-blue-700">Transférer vers un autre compte</p>
                                </div>
                            </div>
                            <div class="mt-3">
                                <form action="${pageContext.request.contextPath}/compte/virement" method="post" class="space-y-2">
                                    <input type="hidden" name="idCompteSource" value="${compte.idCompte}">
                                    <input type="text" name="compteDestination" placeholder="Numéro de compte destinataire" 
                                           class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm" required>
                                    <input type="number" name="montant" step="0.01" min="0.01" max="${compte.solde}" placeholder="Montant" 
                                           class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm" required>
                                    <input type="text" name="description" placeholder="Description (optionnel)" 
                                           class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                                    <button type="submit" class="w-full inline-flex justify-center items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                        <i class="fas fa-paper-plane mr-2"></i>Virer
                                    </button>
                                </form>
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
                <p class="text-xs text-gray-400 mt-2">Gestion des comptes bancaires</p>
            </div>
        </div>
    </footer>
</body>
</html>
