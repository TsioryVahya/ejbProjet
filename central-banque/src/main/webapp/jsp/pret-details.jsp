<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails du Prêt #${pret.idPret} - Système Bancaire</title>
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
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center">
                        <a href="${pageContext.request.contextPath}/pret/list" class="text-blue-600 hover:text-blue-800 mr-4">
                            <i class="fas fa-arrow-left"></i> Retour aux prêts
                        </a>
                        <h1 class="text-3xl font-bold text-gray-900">Détails du Prêt #${pret.idPret}</h1>
                    </div>
                    <div class="flex space-x-3">
                        <c:if test="${pret.statut == 'ACTIF'}">
                            <a href="${pageContext.request.contextPath}/pret/remboursement?id=${pret.idPret}" 
                               class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500">
                                <i class="fas fa-money-bill-wave mr-2"></i>
                                Effectuer un Remboursement
                            </a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/pret/echeancier?id=${pret.idPret}" 
                           class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <i class="fas fa-calendar-alt mr-2"></i>
                            Voir l'Échéancier
                        </a>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Informations principales du prêt -->
                <div class="lg:col-span-2 space-y-6">
                    <!-- Carte principale -->
                    <div class="bg-white shadow rounded-lg overflow-hidden">
                        <div class="px-6 py-4 bg-gradient-to-r from-blue-600 to-blue-700">
                            <h3 class="text-lg font-medium text-white">
                                <i class="fas fa-hand-holding-usd mr-2"></i>Informations du Prêt
                            </h3>
                        </div>
                        <div class="px-6 py-4">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <h4 class="text-sm font-medium text-gray-500 mb-3">Détails Financiers</h4>
                                    <div class="space-y-3">
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">Montant Initial:</span>
                                            <span class="text-sm font-semibold text-purple-600">
                                                <fmt:formatNumber value="${pret.montantInitial}" type="currency" currencySymbol="€"/>
                                            </span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">Montant Restant:</span>
                                            <span class="text-sm font-semibold text-red-600">
                                                <fmt:formatNumber value="${pret.montantRestant}" type="currency" currencySymbol="€"/>
                                            </span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">Montant Remboursé:</span>
                                            <span class="text-sm font-semibold text-green-600">
                                                <fmt:formatNumber value="${pret.montantInitial - pret.montantRestant}" type="currency" currencySymbol="€"/>
                                            </span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">Taux d'Intérêt:</span>
                                            <span class="text-sm font-semibold text-gray-900">
                                                <c:choose>
                                                    <c:when test="${not empty pret.tauxPourcentage}">
                                                        <fmt:formatNumber value="${pret.tauxPourcentage}" pattern="#0.00"/>%
                                                    </c:when>
                                                    <c:otherwise>
                                                        N/A
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <h4 class="text-sm font-medium text-gray-500 mb-3">Informations Générales</h4>
                                    <div class="space-y-3">
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">Durée:</span>
                                            <span class="text-sm font-semibold text-gray-900">${pret.duree} mois</span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">Date de Création:</span>
                                            <span class="text-sm font-semibold text-gray-900">
                                                <c:choose>
                                                    <c:when test="${not empty pret.datePret}">
                                                        ${pret.datePret.toString().substring(0, 10)}
                                                    </c:when>
                                                    <c:otherwise>
                                                        N/A
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">Statut:</span>
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium 
                                                ${pret.statut == 'ACTIF' ? 'bg-purple-100 text-purple-800' : 
                                                  pret.statut == 'REMBOURSE' ? 'bg-green-100 text-green-800' : 
                                                  'bg-red-100 text-red-800'}">
                                                ${pret.statut}
                                            </span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">N° Compte:</span>
                                            <span class="text-sm font-semibold text-gray-900">
                                                <c:choose>
                                                    <c:when test="${not empty pret.numeroCompte}">
                                                        ${pret.numeroCompte}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Compte #${pret.idCompte}
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Barre de progression -->
                            <c:if test="${pret.montantInitial > 0}">
                                <div class="mt-6">
                                    <div class="flex items-center justify-between text-sm text-gray-600 mb-2">
                                        <span>Progression du remboursement</span>
                                        <span class="font-semibold">
                                            <fmt:formatNumber value="${(pret.montantInitial - pret.montantRestant) / pret.montantInitial * 100}" pattern="#0"/>%
                                        </span>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-4">
                                        <div class="bg-gradient-to-r from-purple-500 to-purple-600 h-4 rounded-full transition-all duration-1000" 
                                             style="width: ${(pret.montantInitial - pret.montantRestant) / pret.montantInitial * 100}%"></div>
                                    </div>
                                    <div class="flex justify-between text-xs text-gray-500 mt-1">
                                        <span>0%</span>
                                        <span>100%</span>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Historique des remboursements -->
                    <div class="bg-white shadow rounded-lg overflow-hidden">
                        <div class="px-6 py-4 bg-gradient-to-r from-green-600 to-green-700">
                            <h3 class="text-lg font-medium text-white">
                                <i class="fas fa-history mr-2"></i>Historique des Remboursements
                            </h3>
                        </div>
                        <div class="px-6 py-4">
                            <c:choose>
                                <c:when test="${not empty remboursements}">
                                    <div class="overflow-x-auto">
                                        <table class="min-w-full divide-y divide-gray-200">
                                            <thead class="bg-gray-50">
                                                <tr>
                                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Date
                                                    </th>
                                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        Montant
                                                    </th>
                                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                        N° Remboursement
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-gray-200">
                                                <c:forEach var="remboursement" items="${remboursements}">
                                                    <tr class="hover:bg-gray-50">
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                            <c:choose>
                                                                <c:when test="${not empty remboursement.dateRemboursement}">
                                                                    ${remboursement.dateRemboursement.toString().substring(0, 16).replace('T', ' ')}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    N/A
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-green-600">
                                                            <fmt:formatNumber value="${remboursement.montantRembourser}" type="currency" currencySymbol="€"/>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                            #${remboursement.idRemboursement}
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-8">
                                        <i class="fas fa-inbox text-gray-400 text-4xl mb-4"></i>
                                        <p class="text-gray-500">Aucun remboursement effectué pour ce prêt.</p>
                                        <c:if test="${pret.statut == 'ACTIF'}">
                                            <a href="${pageContext.request.contextPath}/pret/remboursement?id=${pret.idPret}" 
                                               class="inline-flex items-center mt-4 px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                                <i class="fas fa-plus mr-2"></i>
                                                Effectuer le Premier Remboursement
                                            </a>
                                        </c:if>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Sidebar avec informations du compte -->
                <div class="lg:col-span-1">
                    <div class="bg-white shadow rounded-lg overflow-hidden">
                        <div class="px-6 py-4 bg-gradient-to-r from-indigo-600 to-indigo-700">
                            <h3 class="text-lg font-medium text-white">
                                <i class="fas fa-user mr-2"></i>Informations du Compte
                            </h3>
                        </div>
                        <div class="px-6 py-4">
                            <c:choose>
                                <c:when test="${not empty compte}">
                                    <div class="space-y-4">
                                        <div>
                                            <h4 class="text-sm font-medium text-gray-500 mb-2">Titulaire</h4>
                                            <p class="text-sm font-semibold text-gray-900">
                                                <c:choose>
                                                    <c:when test="${not empty pret.nomClient and not empty pret.prenomClient}">
                                                        ${pret.prenomClient} ${pret.nomClient}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Client du compte #${pret.idCompte}
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                        <div>
                                            <h4 class="text-sm font-medium text-gray-500 mb-2">N° de Compte</h4>
                                            <p class="text-sm font-mono text-gray-900">
                                                <c:choose>
                                                    <c:when test="${not empty compte.numeroCompte}">
                                                        ${compte.numeroCompte}
                                                    </c:when>
                                                    <c:when test="${not empty pret.numeroCompte}">
                                                        ${pret.numeroCompte}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Compte #${pret.idCompte}
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                        <div>
                                            <h4 class="text-sm font-medium text-gray-500 mb-2">Type de Compte</h4>
                                            <p class="text-sm text-gray-900">
                                                Compte Courant
                                            </p>
                                        </div>
                                        <div>
                                            <h4 class="text-sm font-medium text-gray-500 mb-2">Solde Actuel</h4>
                                            <p class="text-sm font-semibold text-gray-600">
                                                <i class="fas fa-info-circle mr-1"></i>Consultez la page du compte pour le solde actuel
                                            </p>
                                        </div>
                                        <div>
                                            <h4 class="text-sm font-medium text-gray-500 mb-2">Contact</h4>
                                            <div class="space-y-1">
                                                <p class="text-sm text-gray-600">
                                                    <i class="fas fa-info-circle mr-1"></i>Informations disponibles via le compte
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-4">
                                        <i class="fas fa-exclamation-triangle text-yellow-400 text-2xl mb-2"></i>
                                        <p class="text-sm text-gray-500">Informations du compte non disponibles</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Actions rapides -->
                    <div class="mt-6 bg-white shadow rounded-lg overflow-hidden">
                        <div class="px-6 py-4 bg-gradient-to-r from-gray-600 to-gray-700">
                            <h3 class="text-lg font-medium text-white">
                                <i class="fas fa-bolt mr-2"></i>Actions Rapides
                            </h3>
                        </div>
                        <div class="px-6 py-4">
                            <div class="space-y-3">
                                <c:if test="${pret.statut == 'ACTIF'}">
                                    <a href="${pageContext.request.contextPath}/pret/remboursement?id=${pret.idPret}" 
                                       class="w-full inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                        <i class="fas fa-money-bill-wave mr-2"></i>
                                        Rembourser
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/pret/echeancier?id=${pret.idPret}" 
                                   class="w-full inline-flex justify-center items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                    <i class="fas fa-calendar-alt mr-2"></i>
                                    Échéancier
                                </a>
                                <a href="${pageContext.request.contextPath}/compte/details?id=${pret.idCompte}" 
                                   class="w-full inline-flex justify-center items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                    <i class="fas fa-user mr-2"></i>
                                    Voir le Compte
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Animation de la barre de progression au chargement
        document.addEventListener('DOMContentLoaded', function() {
            const progressBar = document.querySelector('.bg-gradient-to-r.from-purple-500');
            if (progressBar) {
                const width = progressBar.style.width;
                progressBar.style.width = '0%';
                setTimeout(() => {
                    progressBar.style.transition = 'width 1.5s ease-in-out';
                    progressBar.style.width = width;
                }, 200);
            }
        });
    </script>
</body>
</html>
