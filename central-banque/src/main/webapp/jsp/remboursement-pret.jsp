<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remboursement de Prêt - Système Bancaire</title>
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
    <div class="max-w-4xl mx-auto py-6 sm:px-6 lg:px-8">
        <div class="px-4 py-6 sm:px-0">
            <!-- En-tête -->
            <div class="mb-6">
                <div class="flex items-center mb-4">
                    <a href="${pageContext.request.contextPath}/pret/list" class="text-blue-600 hover:text-blue-800 mr-4">
                        <i class="fas fa-arrow-left"></i> Retour aux prêts
                    </a>
                </div>
                <h1 class="text-3xl font-bold text-gray-900">Remboursement de Prêt</h1>
                <p class="text-gray-600 mt-2">Effectuez un remboursement pour votre prêt</p>
            </div>

            <!-- Messages -->
            <c:if test="${not empty succes}">
                <div class="mb-6 bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-check-circle mr-2"></i>
                    <span class="block sm:inline">${succes}</span>
                </div>
            </c:if>

            <c:if test="${not empty erreur}">
                <div class="mb-6 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <span class="block sm:inline">${erreur}</span>
                </div>
            </c:if>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Informations du prêt -->
                <div class="lg:col-span-1">
                    <div class="bg-white shadow rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">
                            <i class="fas fa-info-circle mr-2 text-blue-600"></i>Informations du Prêt
                        </h3>
                        
                        <div class="space-y-4">
                            <div class="flex justify-between">
                                <span class="text-sm font-medium text-gray-500">N° Prêt:</span>
                                <span class="text-sm text-gray-900">#${pret.idPret}</span>
                            </div>
                            
                            <div class="flex justify-between">
                                <span class="text-sm font-medium text-gray-500">Montant Initial:</span>
                                <span class="text-sm font-semibold text-purple-600">
                                    <fmt:formatNumber value="${pret.montantInitial}" type="currency" currencySymbol="€"/>
                                </span>
                            </div>
                            
                            <div class="flex justify-between">
                                <span class="text-sm font-medium text-gray-500">Montant Restant:</span>
                                <span class="text-sm font-semibold text-red-600">
                                    <fmt:formatNumber value="${pret.montantRestant}" type="currency" currencySymbol="€"/>
                                </span>
                            </div>
                            
                            <div class="flex justify-between">
                                <span class="text-sm font-medium text-gray-500">Taux:</span>
                                <span class="text-sm text-gray-900">
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
                            
                            <div class="flex justify-between">
                                <span class="text-sm font-medium text-gray-500">Durée:</span>
                                <span class="text-sm text-gray-900">${pret.duree} mois</span>
                            </div>
                            
                            <div class="flex justify-between">
                                <span class="text-sm font-medium text-gray-500">Statut:</span>
                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium 
                                    ${pret.statut == 'ACTIF' ? 'bg-purple-100 text-purple-800' : 
                                      pret.statut == 'REMBOURSE' ? 'bg-green-100 text-green-800' : 
                                      'bg-red-100 text-red-800'}">
                                    ${pret.statut}
                                </span>
                            </div>
                        </div>

                        <!-- Barre de progression -->
                        <c:if test="${pret.montantInitial > 0}">
                            <div class="mt-6">
                                <div class="flex items-center justify-between text-xs text-gray-500 mb-2">
                                    <span>Progression du remboursement</span>
                                    <span>
                                        <fmt:formatNumber value="${(pret.montantInitial - pret.montantRestant) / pret.montantInitial * 100}" pattern="#0"/>%
                                    </span>
                                </div>
                                <div class="w-full bg-gray-200 rounded-full h-3">
                                    <div class="bg-purple-600 h-3 rounded-full transition-all duration-1000" 
                                         style="width: ${(pret.montantInitial - pret.montantRestant) / pret.montantInitial * 100}%"></div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Formulaire de remboursement -->
                <div class="lg:col-span-2">
                    <div class="bg-white shadow rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-6">
                            <i class="fas fa-money-bill-wave mr-2 text-green-600"></i>Effectuer un Remboursement
                        </h3>

                        <form action="${pageContext.request.contextPath}/pret/rembourser" method="post" id="remboursement-form">
                            <input type="hidden" name="idPret" value="${pret.idPret}">
                            
                            <div class="space-y-6">
                                <!-- Montant du remboursement -->
                                <div>
                                    <label for="montant" class="block text-sm font-medium text-gray-700 mb-2">
                                        Montant du remboursement <span class="text-red-500">*</span>
                                    </label>
                                    <div class="relative">
                                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                            <span class="text-gray-500 sm:text-sm">€</span>
                                        </div>
                                        <input type="number" 
                                               id="montant" 
                                               name="montant" 
                                               step="0.01" 
                                               min="0.01" 
                                               max="${pret.montantRestant}"
                                               class="block w-full pl-7 pr-12 py-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent"
                                               placeholder="0.00"
                                               required>
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                            <span class="text-gray-500 sm:text-sm">EUR</span>
                                        </div>
                                    </div>
                                    <p class="mt-1 text-xs text-gray-500">
                                        Montant maximum: <fmt:formatNumber value="${pret.montantRestant}" type="currency" currencySymbol="€"/>
                                    </p>
                                </div>

                                <!-- Boutons de montant rapide -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">
                                        Montants rapides
                                    </label>
                                    <div class="grid grid-cols-2 md:grid-cols-4 gap-2">
                                        <button type="button" 
                                                onclick="setMontant(montantRestant / 4)"
                                                class="px-3 py-2 text-xs font-medium text-gray-700 bg-gray-100 border border-gray-300 rounded-md hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-green-500">
                                            25%
                                        </button>
                                        <button type="button" 
                                                onclick="setMontant(montantRestant / 2)"
                                                class="px-3 py-2 text-xs font-medium text-gray-700 bg-gray-100 border border-gray-300 rounded-md hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-green-500">
                                            50%
                                        </button>
                                        <button type="button" 
                                                onclick="setMontant(montantRestant * 0.75)"
                                                class="px-3 py-2 text-xs font-medium text-gray-700 bg-gray-100 border border-gray-300 rounded-md hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-green-500">
                                            75%
                                        </button>
                                        <button type="button" 
                                                onclick="setMontant(montantRestant)"
                                                class="px-3 py-2 text-xs font-medium text-white bg-green-600 border border-green-600 rounded-md hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500">
                                            Tout
                                        </button>
                                    </div>
                                </div>

                                <!-- Aperçu du remboursement -->
                                <div id="apercu-remboursement" class="hidden bg-blue-50 border border-blue-200 rounded-lg p-4">
                                    <h4 class="text-sm font-medium text-blue-900 mb-2">
                                        <i class="fas fa-calculator mr-2"></i>Aperçu du remboursement
                                    </h4>
                                    <div class="space-y-2 text-sm">
                                        <div class="flex justify-between">
                                            <span class="text-blue-700">Montant à rembourser:</span>
                                            <span class="font-medium text-blue-900" id="apercu-montant">€0.00</span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-blue-700">Nouveau solde restant:</span>
                                            <span class="font-medium text-blue-900" id="apercu-nouveau-solde">€0.00</span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-blue-700">Progression:</span>
                                            <span class="font-medium text-blue-900" id="apercu-progression">0%</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Boutons d'action -->
                                <div class="flex space-x-4 pt-4">
                                    <button type="submit" 
                                            class="flex-1 inline-flex justify-center items-center px-6 py-3 border border-transparent text-base font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 transition-colors duration-200">
                                        <i class="fas fa-money-bill-wave mr-2"></i>
                                        Effectuer le Remboursement
                                    </button>
                                    <a href="${pageContext.request.contextPath}/pret/list" 
                                       class="inline-flex justify-center items-center px-6 py-3 border border-gray-300 text-base font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-gray-500 transition-colors duration-200">
                                        <i class="fas fa-times mr-2"></i>
                                        Annuler
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Informations importantes -->
            <div class="mt-8 bg-yellow-50 border border-yellow-200 rounded-lg p-6">
                <h3 class="text-lg font-medium text-yellow-900 mb-4">
                    <i class="fas fa-exclamation-triangle mr-2"></i>Informations Importantes
                </h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-yellow-800">
                    <div>
                        <h4 class="font-medium mb-2">Remboursement anticipé</h4>
                        <p>Vous pouvez rembourser tout ou partie de votre prêt à tout moment sans pénalité.</p>
                    </div>
                    <div>
                        <h4 class="font-medium mb-2">Traitement</h4>
                        <p>Le remboursement sera traité immédiatement et votre solde sera mis à jour.</p>
                    </div>
                    <div>
                        <h4 class="font-medium mb-2">Confirmation</h4>
                        <p>Vous recevrez une confirmation une fois le remboursement effectué.</p>
                    </div>
                    <div>
                        <h4 class="font-medium mb-2">Historique</h4>
                        <p>Tous vos remboursements sont enregistrés dans l'historique de votre prêt.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        var montantRestant = <fmt:formatNumber value="${pret.montantRestant}" pattern="#0.00"/>;
        var montantInitial = <fmt:formatNumber value="${pret.montantInitial}" pattern="#0.00"/>;
        
        function setMontant(montant) {
            const input = document.getElementById('montant');
            input.value = montant.toFixed(2);
            updateApercu();
        }
        
        function updateApercu() {
            const montantInput = document.getElementById('montant');
            const montant = parseFloat(montantInput.value) || 0;
            
            if (montant > 0) {
                const nouveauSolde = montantRestant - montant;
                const progression = ((montantInitial - nouveauSolde) / montantInitial * 100);
                
                document.getElementById('apercu-montant').textContent = 
                    new Intl.NumberFormat('fr-FR', { style: 'currency', currency: 'EUR' }).format(montant);
                document.getElementById('apercu-nouveau-solde').textContent = 
                    new Intl.NumberFormat('fr-FR', { style: 'currency', currency: 'EUR' }).format(Math.max(0, nouveauSolde));
                document.getElementById('apercu-progression').textContent = 
                    Math.min(100, progression).toFixed(1) + '%';
                
                document.getElementById('apercu-remboursement').classList.remove('hidden');
            } else {
                document.getElementById('apercu-remboursement').classList.add('hidden');
            }
        }
        
        // Validation du formulaire
        document.getElementById('remboursement-form').addEventListener('submit', function(e) {
            const montant = parseFloat(document.getElementById('montant').value);
            
            if (!montant || montant <= 0) {
                e.preventDefault();
                alert('Veuillez saisir un montant valide.');
                return;
            }
            
            if (montant > montantRestant) {
                e.preventDefault();
                alert('Le montant ne peut pas dépasser le solde restant du prêt.');
                return;
            }
            
            if (!confirm('Êtes-vous sûr de vouloir effectuer ce remboursement de ' + 
                        new Intl.NumberFormat('fr-FR', { style: 'currency', currency: 'EUR' }).format(montant) + ' ?')) {
                e.preventDefault();
            }
        });
        
        // Mise à jour de l'aperçu en temps réel
        document.getElementById('montant').addEventListener('input', updateApercu);
        
        // Animation de la barre de progression au chargement
        document.addEventListener('DOMContentLoaded', function() {
            const progressBar = document.querySelector('.bg-purple-600');
            if (progressBar) {
                const width = progressBar.style.width;
                progressBar.style.width = '0%';
                setTimeout(() => {
                    progressBar.style.transition = 'width 1s ease-in-out';
                    progressBar.style.width = width;
                }, 100);
            }
        });
    </script>
</body>
</html>
