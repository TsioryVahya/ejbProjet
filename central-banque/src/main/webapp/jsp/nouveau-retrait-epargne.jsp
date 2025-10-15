<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau Retrait d'Épargne - Système Bancaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-50 min-h-screen">
    <!-- Navigation -->
    <nav class="bg-blue-600 text-white p-4 shadow-lg">
        <div class="container mx-auto flex justify-between items-center">
            <div class="flex items-center space-x-4">
                <i class="fas fa-university text-2xl"></i>
                <h1 class="text-xl font-bold">Système Bancaire</h1>
            </div>
            <div class="flex items-center space-x-4">
                <a href="${pageContext.request.contextPath}/dashboard" class="hover:text-blue-200">
                    <i class="fas fa-home mr-2"></i>Accueil
                </a>
                <a href="${pageContext.request.contextPath}/epargne/details?idCompte=${param.idCompte}" class="hover:text-blue-200">
                    <i class="fas fa-arrow-left mr-2"></i>Retour
                </a>
            </div>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        <!-- En-tête -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-2xl font-bold text-gray-800 mb-2">
                        <i class="fas fa-minus-circle text-red-600 mr-2"></i>
                        Nouveau Retrait d'Épargne
                    </h2>
                    <p class="text-gray-600">Effectuer un retrait sur votre compte d'épargne</p>
                </div>
                <div class="text-right">
                    <div class="text-sm text-gray-500">Compte N°</div>
                    <div class="text-xl font-bold text-blue-600">${compte.numeroCompte}</div>
                </div>
            </div>
        </div>

        <!-- Informations du dépôt -->
        <c:if test="${not empty depots}">
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">
                    <i class="fas fa-info-circle text-blue-600 mr-2"></i>
                    Dépôts d'Épargne Disponibles
                </h3>
                <div class="space-y-4">
                    <c:forEach var="depot" items="${depots}">
                        <div class="border border-gray-200 rounded-lg p-4">
                            <div class="flex justify-between items-center">
                                <div>
                                    <h4 class="font-medium text-gray-900">Dépôt #${depot.idDepotEpargne}</h4>
                                    <p class="text-sm text-gray-500">Date: ${depot.dateEpargne}</p>
                                    <p class="text-sm text-gray-500">Taux: ${depot.tauxEpargne}%</p>
                                </div>
                                <div class="text-right">
                                    <div class="text-lg font-semibold text-green-600">
                                        <fmt:formatNumber value="${depot.montantEpargne}" type="currency" currencySymbol="€"/>
                                    </div>
                                    <c:if test="${not empty depot.montantDisponible}">
                                        <div class="text-sm text-gray-500">
                                            Disponible: <fmt:formatNumber value="${depot.montantDisponible}" type="currency" currencySymbol="€"/>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Formulaire de retrait -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <h3 class="text-lg font-semibold text-gray-800 mb-6">
                <i class="fas fa-money-bill-wave text-red-600 mr-2"></i>
                Formulaire de Retrait
            </h3>

            <form action="${pageContext.request.contextPath}/epargne/nouveau-retrait" method="post" onsubmit="return confirmerRetrait()">
                <input type="hidden" name="idCompte" value="${param.idCompte}">
                <input type="hidden" name="idDepot" value="${param.idDepot}">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Montant du retrait -->
                    <div>
                        <label for="montant" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-euro-sign text-red-600 mr-1"></i>
                            Montant du retrait (€) *
                        </label>
                        <input type="number" 
                               id="montant" 
                               name="montant" 
                               step="0.01" 
                               min="0.01" 
                               required
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-red-500"
                               placeholder="Montant à retirer">
                        <p class="mt-1 text-xs text-gray-500">Montant minimum: 0,01 €</p>
                    </div>

                    <!-- Motif du retrait -->
                    <div>
                        <label for="motif" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="fas fa-comment text-gray-600 mr-1"></i>
                            Motif du retrait
                        </label>
                        <select id="motif" 
                                name="motif" 
                                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-red-500">
                            <option value="">Sélectionner un motif</option>
                            <option value="PERSONNEL">Usage personnel</option>
                            <option value="URGENCE">Urgence</option>
                            <option value="INVESTISSEMENT">Investissement</option>
                            <option value="AUTRE">Autre</option>
                        </select>
                    </div>
                </div>

                <!-- Description optionnelle -->
                <div class="mt-6">
                    <label for="description" class="block text-sm font-medium text-gray-700 mb-2">
                        <i class="fas fa-file-alt text-gray-600 mr-1"></i>
                        Description (optionnelle)
                    </label>
                    <textarea id="description" 
                              name="description" 
                              rows="3" 
                              class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-red-500"
                              placeholder="Détails supplémentaires sur le retrait..."></textarea>
                </div>

                <!-- Boutons d'action -->
                <div class="mt-8 flex flex-col sm:flex-row gap-4">
                    <button type="submit" 
                            class="flex-1 bg-red-600 hover:bg-red-700 text-white font-medium py-3 px-6 rounded-lg transition-colors focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2">
                        <i class="fas fa-minus-circle mr-2"></i>
                        Effectuer le Retrait
                    </button>
                    <a href="${pageContext.request.contextPath}/epargne/details?idCompte=${param.idCompte}" 
                       class="flex-1 bg-gray-600 hover:bg-gray-700 text-white font-medium py-3 px-6 rounded-lg transition-colors text-center focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2">
                        <i class="fas fa-times mr-2"></i>
                        Annuler
                    </a>
                </div>
            </form>
        </div>

        <!-- Informations importantes -->
        <div class="mt-6 bg-yellow-50 border border-yellow-200 rounded-lg p-4">
            <div class="flex">
                <div class="flex-shrink-0">
                    <i class="fas fa-exclamation-triangle text-yellow-400"></i>
                </div>
                <div class="ml-3">
                    <h3 class="text-sm font-medium text-yellow-800">Informations importantes</h3>
                    <div class="mt-2 text-sm text-yellow-700">
                        <ul class="list-disc list-inside space-y-1">
                            <li>Les retraits sont soumis aux conditions générales de votre contrat d'épargne</li>
                            <li>Certains retraits peuvent affecter le calcul des intérêts</li>
                            <li>Vérifiez les montants disponibles avant d'effectuer un retrait</li>
                            <li>Cette opération est irréversible une fois confirmée</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function confirmerRetrait() {
            const montant = document.getElementById('montant').value;
            const motif = document.getElementById('motif').value;
            
            if (!montant || parseFloat(montant) <= 0) {
                alert('Veuillez saisir un montant valide.');
                return false;
            }
            
            const montantFormate = parseFloat(montant).toFixed(2) + ' €';
            const motifTexte = motif ? ` (Motif: ${motif})` : '';
            
            return confirm(`Êtes-vous sûr de vouloir effectuer un retrait de ${montantFormate}${motifTexte} ?\n\nCette opération est irréversible.`);
        }

        // Validation en temps réel
        document.getElementById('montant').addEventListener('input', function() {
            const montant = parseFloat(this.value);
            const submitBtn = document.querySelector('button[type="submit"]');
            
            if (montant && montant > 0) {
                submitBtn.disabled = false;
                submitBtn.classList.remove('opacity-50', 'cursor-not-allowed');
            } else {
                submitBtn.disabled = true;
                submitBtn.classList.add('opacity-50', 'cursor-not-allowed');
            }
        });

        // Initialiser l'état du bouton
        document.addEventListener('DOMContentLoaded', function() {
            const montantInput = document.getElementById('montant');
            const submitBtn = document.querySelector('button[type="submit"]');
            
            if (!montantInput.value) {
                submitBtn.disabled = true;
                submitBtn.classList.add('opacity-50', 'cursor-not-allowed');
            }
        });
    </script>
</body>
</html>
