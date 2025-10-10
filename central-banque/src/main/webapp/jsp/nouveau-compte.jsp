<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau Compte - Système Bancaire</title>
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
    <div class="max-w-4xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- En-tête -->
        <div class="px-4 py-6 sm:px-0">
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Créer un Nouveau Compte</h1>
                    <p class="text-gray-600 mt-2">Remplissez les informations pour créer un nouveau compte bancaire</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/compte/list" 
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
                        <i class="fas fa-plus-circle mr-2 text-blue-600"></i>Informations du Compte
                    </h3>

                    <form action="${pageContext.request.contextPath}/compte/creer" method="post" class="space-y-6">
                        <!-- Numéro de compte -->
                        <div>
                            <label for="numeroCompte" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-hashtag mr-1"></i>Numéro de Compte *
                            </label>
                            <div class="relative">
                                <input type="text" 
                                       id="numeroCompte" 
                                       name="numeroCompte" 
                                       required 
                                       placeholder="Ex: CC-2024-001"
                                       class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                <div class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                    <button type="button" onclick="genererNumeroCompte()" class="text-blue-600 hover:text-blue-800 text-sm">
                                        <i class="fas fa-magic mr-1"></i>Générer
                                    </button>
                                </div>
                            </div>
                            <p class="mt-1 text-xs text-gray-500">Le numéro de compte doit être unique</p>
                        </div>

                        <!-- Sélection du client -->
                        <div>
                            <label for="idClient" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-user mr-1"></i>Client *
                            </label>
                            <select id="idClient" 
                                    name="idClient" 
                                    required 
                                    class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                <option value="">Sélectionner un client</option>
                                <c:forEach var="client" items="${clients}">
                                    <option value="${client.idClient}">
                                        ${client.nom} ${client.prenom}
                                        <c:if test="${not empty client.email}"> - ${client.email}</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                            <c:if test="${empty clients}">
                                <p class="mt-1 text-xs text-red-500">Aucun client disponible. Veuillez d'abord créer un client.</p>
                            </c:if>
                        </div>

                        <!-- Type de compte -->
                        <div>
                            <label for="idTypeCompte" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-tag mr-1"></i>Type de Compte *
                            </label>
                            <select id="idTypeCompte" 
                                    name="idTypeCompte" 
                                    required 
                                    class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                <option value="">Sélectionner un type de compte</option>
                                <c:forEach var="typeCompte" items="${typesCompte}">
                                    <option value="${typeCompte.idTypeCompte}">
                                        ${typeCompte.nomTypeCompte}
                                        <c:if test="${not empty typeCompte.description}"> - ${typeCompte.description}</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                            <c:if test="${empty typesCompte}">
                                <p class="mt-1 text-xs text-red-500">Aucun type de compte disponible.</p>
                            </c:if>
                        </div>

                        <!-- Solde initial -->
                        <div>
                            <label for="soldeInitial" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-euro-sign mr-1"></i>Solde Initial (€)
                            </label>
                            <input type="number" 
                                   id="soldeInitial" 
                                   name="soldeInitial" 
                                   step="0.01" 
                                   min="0" 
                                   value="0.00"
                                   placeholder="0.00"
                                   class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                            <p class="mt-1 text-xs text-gray-500">Montant initial à déposer sur le compte (optionnel)</p>
                        </div>

                        <!-- Boutons d'action -->
                        <div class="flex justify-end space-x-3 pt-6 border-t border-gray-200">
                            <a href="${pageContext.request.contextPath}/compte/list" 
                               class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                <i class="fas fa-times mr-2"></i>Annuler
                            </a>
                            <button type="submit" 
                                    class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                <i class="fas fa-plus mr-2"></i>Créer le Compte
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
                                <li>Le numéro de compte doit être unique dans le système</li>
                                <li>Le solde initial peut être de 0€ ou plus</li>
                                <li>Le compte sera automatiquement activé après création</li>
                                <li>Une opération "Solde Initial" sera créée si le montant est supérieur à 0€</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Fonction pour générer un numéro de compte automatique
        function genererNumeroCompte() {
            const now = new Date();
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0');
            const day = String(now.getDate()).padStart(2, '0');
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            
            const numeroCompte = `CC-${year}${month}${day}-${hours}${minutes}${seconds}`;
            document.getElementById('numeroCompte').value = numeroCompte;
        }

        // Validation du formulaire
        document.querySelector('form').addEventListener('submit', function(e) {
            const numeroCompte = document.getElementById('numeroCompte').value.trim();
            const idClient = document.getElementById('idClient').value;
            const idTypeCompte = document.getElementById('idTypeCompte').value;

            if (!numeroCompte) {
                e.preventDefault();
                alert('Veuillez saisir un numéro de compte');
                document.getElementById('numeroCompte').focus();
                return;
            }

            if (!idClient) {
                e.preventDefault();
                alert('Veuillez sélectionner un client');
                document.getElementById('idClient').focus();
                return;
            }

            if (!idTypeCompte) {
                e.preventDefault();
                alert('Veuillez sélectionner un type de compte');
                document.getElementById('idTypeCompte').focus();
                return;
            }
        });

        // Auto-focus sur le premier champ
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('numeroCompte').focus();
        });
    </script>
</body>
</html>
