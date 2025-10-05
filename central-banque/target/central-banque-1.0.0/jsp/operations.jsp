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
                <p class="text-sm">© 2025 Système Bancaire - Projet EJB & C# API</p>
                <p class="text-xs text-gray-400 mt-2">Historique des opérations bancaires</p>
            </div>
        </div>
    </footer>
</body>
</html>
