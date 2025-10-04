<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Prêts - Système Bancaire</title>
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
                    <a href="${pageContext.request.contextPath}/pret/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium bg-blue-700">
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
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Gestion des Prêts</h1>
                    <p class="text-gray-600 mt-2">Gérez vos prêts et remboursements</p>
                </div>
                <div class="flex space-x-3">
                    <c:if test="${apiDisponible}">
                        <a href="${pageContext.request.contextPath}/pret/simulation" 
                           class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                            <i class="fas fa-calculator mr-2"></i>Simuler un Prêt
                        </a>
                        <a href="${pageContext.request.contextPath}/pret/nouveau" 
                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700">
                            <i class="fas fa-plus mr-2"></i>Nouveau Prêt
                        </a>
                    </c:if>
                </div>
            </div>

            <!-- Statut de l'API -->
            <c:if test="${not apiDisponible}">
                <div class="mb-6 bg-yellow-50 border border-yellow-200 text-yellow-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-exclamation-triangle mr-2"></i>
                    <span class="block sm:inline">Service de prêt temporairement indisponible. Certaines fonctionnalités peuvent être limitées.</span>
                </div>
            </c:if>

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

            <!-- Liste des prêts -->
            <div class="bg-white shadow overflow-hidden sm:rounded-md">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">
                        <i class="fas fa-hand-holding-usd mr-2"></i>Prêts Actifs
                    </h3>
                    <p class="mt-1 max-w-2xl text-sm text-gray-500">
                        ${not empty prets ? prets.size() : 0} prêt(s) trouvé(s)
                    </p>
                </div>

                <c:choose>
                    <c:when test="${empty prets}">
                        <div class="text-center py-12">
                            <i class="fas fa-hand-holding-usd text-gray-400 text-6xl mb-4"></i>
                            <h3 class="text-lg font-medium text-gray-900 mb-2">Aucun prêt trouvé</h3>
                            <p class="text-gray-500 mb-6">
                                <c:choose>
                                    <c:when test="${apiDisponible}">
                                        Commencez par simuler ou demander votre premier prêt.
                                    </c:when>
                                    <c:otherwise>
                                        Le service de prêt est temporairement indisponible.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <c:if test="${apiDisponible}">
                                <div class="space-x-3">
                                    <a href="${pageContext.request.contextPath}/pret/simulation" 
                                       class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                        <i class="fas fa-calculator mr-2"></i>Simuler un Prêt
                                    </a>
                                    <a href="${pageContext.request.contextPath}/pret/nouveau" 
                                       class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700">
                                        <i class="fas fa-plus mr-2"></i>Demander un Prêt
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <ul class="divide-y divide-gray-200">
                            <c:forEach var="pret" items="${prets}">
                                <li class="px-4 py-4 hover:bg-gray-50">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0">
                                                <div class="h-12 w-12 rounded-full ${pret.actif ? 'bg-purple-100' : 'bg-green-100'} flex items-center justify-center">
                                                    <i class="fas ${pret.actif ? 'fa-hand-holding-usd text-purple-600' : 'fa-check-circle text-green-600'} text-lg"></i>
                                                </div>
                                            </div>
                                            <div class="ml-4">
                                                <div class="flex items-center">
                                                    <p class="text-lg font-medium text-gray-900">Prêt #${pret.idPret}</p>
                                                    <span class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium 
                                                        ${pret.statut == 'ACTIF' ? 'bg-purple-100 text-purple-800' : 
                                                          pret.statut == 'REMBOURSE' ? 'bg-green-100 text-green-800' : 
                                                          'bg-red-100 text-red-800'}">
                                                        ${pret.statut}
                                                    </span>
                                                </div>
                                                <div class="text-sm text-gray-500">
                                                    <i class="fas fa-credit-card mr-1"></i>
                                                    Compte: ${pret.numeroCompte}
                                                </div>
                                                <div class="text-sm text-gray-500">
                                                    <i class="fas fa-calendar mr-1"></i>
                                                    Durée: ${pret.duree} mois
                                                    <span class="ml-4">
                                                        <i class="fas fa-percentage mr-1"></i>
                                                        Taux: <fmt:formatNumber value="${pret.tauxPret}" pattern="#0.00"/>%
                                                    </span>
                                                </div>
                                                <div class="text-xs text-gray-400 mt-1">
                                                    <i class="fas fa-clock mr-1"></i>
                                                    Accordé le <fmt:formatDate value="${pret.datePret}" pattern="dd/MM/yyyy"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="flex items-center space-x-6">
                                            <div class="text-right">
                                                <p class="text-lg font-semibold text-purple-600">
                                                    <fmt:formatNumber value="${pret.montantInitial}" type="currency" currencySymbol="€"/>
                                                </p>
                                                <p class="text-xs text-gray-500">Montant initial</p>
                                            </div>
                                            <div class="text-right">
                                                <p class="text-lg font-semibold ${pret.montantRestant > 0 ? 'text-red-600' : 'text-green-600'}">
                                                    <fmt:formatNumber value="${pret.montantRestant}" type="currency" currencySymbol="€"/>
                                                </p>
                                                <p class="text-xs text-gray-500">Restant dû</p>
                                            </div>
                                            <div class="flex space-x-2">
                                                <a href="${pageContext.request.contextPath}/pret/details?id=${pret.idPret}" 
                                                   class="inline-flex items-center px-3 py-1 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"
                                                   title="Voir les détails">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <c:if test="${pret.actif and apiDisponible}">
                                                    <a href="${pageContext.request.contextPath}/pret/remboursement?idPret=${pret.idPret}" 
                                                       class="inline-flex items-center px-3 py-1 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"
                                                       title="Effectuer un remboursement">
                                                        <i class="fas fa-money-bill-wave"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/pret/echeancier?id=${pret.idPret}" 
                                                       class="inline-flex items-center px-3 py-1 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"
                                                       title="Voir l'échéancier">
                                                        <i class="fas fa-calendar-alt"></i>
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Barre de progression -->
                                    <c:if test="${pret.montantInitial > 0}">
                                        <div class="mt-3 ml-16">
                                            <div class="flex items-center justify-between text-xs text-gray-500 mb-1">
                                                <span>Progression du remboursement</span>
                                                <span>
                                                    <fmt:formatNumber value="${(pret.montantInitial - pret.montantRestant) / pret.montantInitial * 100}" pattern="#0"/>%
                                                </span>
                                            </div>
                                            <div class="w-full bg-gray-200 rounded-full h-2">
                                                <div class="bg-purple-600 h-2 rounded-full" 
                                                     style="width: ${(pret.montantInitial - pret.montantRestant) / pret.montantInitial * 100}%"></div>
                                            </div>
                                        </div>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Actions rapides -->
            <c:if test="${apiDisponible}">
                <div class="mt-8">
                    <div class="bg-white overflow-hidden shadow rounded-lg">
                        <div class="px-4 py-5 sm:p-6">
                            <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                                <i class="fas fa-bolt mr-2"></i>Actions Rapides
                            </h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <a href="${pageContext.request.contextPath}/pret/simulation" 
                                   class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                    <i class="fas fa-calculator mr-2"></i>Simuler un Prêt
                                </a>
                                <a href="${pageContext.request.contextPath}/pret/nouveau" 
                                   class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700">
                                    <i class="fas fa-plus-circle mr-2"></i>Demander un Prêt
                                </a>
                                <a href="${pageContext.request.contextPath}/pret/statistiques" 
                                   class="flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                    <i class="fas fa-chart-line mr-2"></i>Statistiques
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Informations sur les prêts -->
            <div class="mt-8">
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                            <i class="fas fa-info-circle mr-2"></i>Informations sur les Prêts
                        </h3>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div class="bg-blue-50 p-4 rounded-lg">
                                <h4 class="font-medium text-blue-900 mb-2">
                                    <i class="fas fa-percentage mr-2"></i>Taux Compétitifs
                                </h4>
                                <p class="text-sm text-blue-800">
                                    Bénéficiez de taux d'intérêt compétitifs adaptés à votre profil
                                    et à la durée de votre prêt.
                                </p>
                            </div>
                            <div class="bg-purple-50 p-4 rounded-lg">
                                <h4 class="font-medium text-purple-900 mb-2">
                                    <i class="fas fa-calendar-alt mr-2"></i>Flexibilité
                                </h4>
                                <p class="text-sm text-purple-800">
                                    Choisissez la durée qui vous convient et effectuez des
                                    remboursements anticipés sans pénalité.
                                </p>
                            </div>
                            <div class="bg-green-50 p-4 rounded-lg">
                                <h4 class="font-medium text-green-900 mb-2">
                                    <i class="fas fa-shield-alt mr-2"></i>Sécurité
                                </h4>
                                <p class="text-sm text-green-800">
                                    Tous vos prêts sont sécurisés et suivent les réglementations
                                    bancaires en vigueur.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Fonction pour formater les montants
        function formatCurrency(amount) {
            return new Intl.NumberFormat('fr-FR', { 
                style: 'currency', 
                currency: 'EUR' 
            }).format(amount);
        }
        
        // Animation des barres de progression
        document.addEventListener('DOMContentLoaded', function() {
            const progressBars = document.querySelectorAll('.bg-purple-600');
            progressBars.forEach(bar => {
                const width = bar.style.width;
                bar.style.width = '0%';
                setTimeout(() => {
                    bar.style.transition = 'width 1s ease-in-out';
                    bar.style.width = width;
                }, 100);
            });
        });
    </script>
</body>
</html>
