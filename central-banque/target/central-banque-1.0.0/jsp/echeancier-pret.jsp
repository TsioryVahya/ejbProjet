<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Échéancier du Prêt - Système Bancaire</title>
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
                <a href="${pageContext.request.contextPath}/pret/list" class="hover:text-blue-200">
                    <i class="fas fa-list mr-2"></i>Liste des Prêts
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
                        <i class="fas fa-calendar-alt text-blue-600 mr-2"></i>
                        Échéancier du Prêt
                    </h2>
                    <p class="text-gray-600">Détail des mensualités et du plan de remboursement</p>
                </div>
                <div class="text-right">
                    <div class="text-sm text-gray-500">Prêt N°</div>
                    <div class="text-xl font-bold text-blue-600">${pret.idPret}</div>
                </div>
            </div>
        </div>

        <!-- Informations du prêt -->
        <c:if test="${not empty pret}">
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">
                    <i class="fas fa-info-circle text-blue-600 mr-2"></i>
                    Informations du Prêt
                </h3>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                    <div class="bg-blue-50 p-4 rounded-lg">
                        <div class="text-sm text-gray-600">Montant Initial</div>
                        <div class="text-xl font-bold text-blue-600">
                            <fmt:formatNumber value="${pret.montantInitial}" type="currency" currencySymbol="€"/>
                        </div>
                    </div>
                    <div class="bg-green-50 p-4 rounded-lg">
                        <div class="text-sm text-gray-600">Montant Restant</div>
                        <div class="text-xl font-bold text-green-600">
                            <fmt:formatNumber value="${pret.montantRestant}" type="currency" currencySymbol="€"/>
                        </div>
                    </div>
                    <div class="bg-yellow-50 p-4 rounded-lg">
                        <div class="text-sm text-gray-600">Durée</div>
                        <div class="text-xl font-bold text-yellow-600">${pret.duree} mois</div>
                    </div>
                    <div class="bg-purple-50 p-4 rounded-lg">
                        <div class="text-sm text-gray-600">Statut</div>
                        <div class="text-xl font-bold ${pret.statut == 'ACTIF' ? 'text-green-600' : pret.statut == 'REMBOURSE' ? 'text-blue-600' : 'text-red-600'}">
                            ${pret.statut}
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Échéancier -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">
                <i class="fas fa-table text-blue-600 mr-2"></i>
                Plan de Remboursement
            </h3>
            
            <c:choose>
                <c:when test="${not empty echeancier}">
                    <div class="overflow-x-auto">
                        <div id="echeancier-content" class="space-y-4">
                            <!-- Le contenu sera généré par JavaScript -->
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-8">
                        <i class="fas fa-exclamation-triangle text-yellow-500 text-4xl mb-4"></i>
                        <p class="text-gray-600">Aucun échéancier disponible pour ce prêt.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Actions -->
        <div class="mt-6 flex flex-wrap gap-4">
            <a href="${pageContext.request.contextPath}/pret/details?id=${pret.idPret}" 
               class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg transition-colors">
                <i class="fas fa-eye mr-2"></i>Détails du Prêt
            </a>
            <c:if test="${pret.statut == 'ACTIF'}">
                <a href="${pageContext.request.contextPath}/pret/rembourser?id=${pret.idPret}" 
                   class="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-lg transition-colors">
                    <i class="fas fa-money-bill-wave mr-2"></i>Effectuer un Remboursement
                </a>
            </c:if>
            <a href="${pageContext.request.contextPath}/pret/list" 
               class="bg-gray-600 hover:bg-gray-700 text-white px-6 py-2 rounded-lg transition-colors">
                <i class="fas fa-list mr-2"></i>Retour à la Liste
            </a>
        </div>
    </div>

    <script>
        // Données de l'échéancier depuis le serveur
        const echeancierData = ${echeancier != null ? echeancier : 'null'};
        
        function afficherEcheancier() {
            const container = document.getElementById('echeancier-content');
            
            if (!echeancierData || !echeancierData.echeances) {
                container.innerHTML = `
                    <div class="text-center py-8">
                        <i class="fas fa-exclamation-triangle text-yellow-500 text-4xl mb-4"></i>
                        <p class="text-gray-600">Impossible de charger l'échéancier.</p>
                    </div>
                `;
                return;
            }

            // Résumé de l'échéancier
            const resume = `
                <div class="bg-gray-50 p-4 rounded-lg mb-6">
                    <h4 class="font-semibold text-gray-800 mb-3">Résumé de l'Échéancier</h4>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm">
                        <div>
                            <span class="text-gray-600">Mensualité:</span>
                            <span class="font-semibold ml-2" id="mensualite-display"></span>
                        </div>
                        <div>
                            <span class="text-gray-600">Total à rembourser:</span>
                            <span class="font-semibold ml-2" id="montant-total-display"></span>
                        </div>
                        <div>
                            <span class="text-gray-600">Total des intérêts:</span>
                            <span class="font-semibold ml-2" id="interets-total-display"></span>
                        </div>
                    </div>
                </div>
            `;

            // Tableau des échéances
            let tableHTML = `
                ${resume}
                <div class="overflow-x-auto">
                    <table class="min-w-full table-auto">
                        <thead class="bg-gray-100">
                            <tr>
                                <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Mois</th>
                                <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                                <th class="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Mensualité</th>
                                <th class="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Capital</th>
                                <th class="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Intérêts</th>
                                <th class="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Capital Restant</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
            `;

            echeancierData.echeances.forEach((echeance, index) => {
                const isEven = index % 2 === 0;
                const dateFormatted = formatDate(echeance.dateEcheance);
                const mensualiteFormatted = formatCurrency(echeance.mensualite);
                const capitalFormatted = formatCurrency(echeance.capital);
                const interetsFormatted = formatCurrency(echeance.interets);
                const capitalRestantFormatted = formatCurrency(echeance.capitalRestant);
                
                tableHTML += `
                    <tr class="${isEven ? 'bg-white' : 'bg-gray-50'}">
                        <td class="px-4 py-3 text-sm font-medium text-gray-900">${echeance.numeroMois}</td>
                        <td class="px-4 py-3 text-sm text-gray-600">${dateFormatted}</td>
                        <td class="px-4 py-3 text-sm text-right font-semibold">${mensualiteFormatted}</td>
                        <td class="px-4 py-3 text-sm text-right text-blue-600">${capitalFormatted}</td>
                        <td class="px-4 py-3 text-sm text-right text-red-600">${interetsFormatted}</td>
                        <td class="px-4 py-3 text-sm text-right font-medium">${capitalRestantFormatted}</td>
                    </tr>
                `;
            });

            tableHTML += `
                        </tbody>
                    </table>
                </div>
            `;

            container.innerHTML = tableHTML;
            
            // Remplir les valeurs du résumé après avoir inséré le HTML
            if (document.getElementById('mensualite-display')) {
                document.getElementById('mensualite-display').textContent = formatCurrency(echeancierData.mensualite);
                document.getElementById('montant-total-display').textContent = formatCurrency(echeancierData.montantTotal);
                document.getElementById('interets-total-display').textContent = formatCurrency(echeancierData.interetsTotal);
            }
        }

        function formatCurrency(amount) {
            return new Intl.NumberFormat('fr-FR', {
                style: 'currency',
                currency: 'EUR'
            }).format(amount);
        }

        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('fr-FR');
        }

        // Charger l'échéancier au chargement de la page
        document.addEventListener('DOMContentLoaded', afficherEcheancier);
    </script>
</body>
</html>
