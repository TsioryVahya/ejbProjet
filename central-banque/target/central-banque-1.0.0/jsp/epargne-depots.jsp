<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dépôts d'Épargne - Système Bancaire</title>
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
                    <a href="${pageContext.request.contextPath}/epargne/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium bg-blue-700">
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
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Dépôts d'Épargne</h1>
                    <p class="text-gray-600 mt-2">Gérez vos dépôts et suivez vos gains</p>
                </div>
                <div class="flex space-x-3">
                    <c:if test="${apiDisponible}">
                        <a href="${pageContext.request.contextPath}/epargne/nouveau-depot" 
                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                            <i class="fas fa-plus mr-2"></i>Nouveau Dépôt
                        </a>
                    </c:if>
                    <button onclick="exportCSV()" 
                            class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                        <i class="fas fa-download mr-2"></i>Exporter CSV
                    </button>
                </div>
            </div>

            <!-- Statut de l'API -->
            <c:if test="${not apiDisponible}">
                <div class="mb-6 bg-yellow-50 border border-yellow-200 text-yellow-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-exclamation-triangle mr-2"></i>
                    <span class="block sm:inline">Service d'épargne temporairement indisponible. Certaines fonctionnalités peuvent être limitées.</span>
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

            <!-- Filtres et recherche -->
            <div class="bg-white p-4 rounded-lg shadow mb-6">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Recherche</label>
                        <div class="relative">
                            <input type="text" id="searchInput" placeholder="N° compte, client..." 
                                   class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                            <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Montant minimum</label>
                        <input type="number" id="montantMin" placeholder="0" 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Période</label>
                        <select id="periodeFilter" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                            <option value="">Toutes les périodes</option>
                            <option value="7">7 derniers jours</option>
                            <option value="30">30 derniers jours</option>
                            <option value="90">3 derniers mois</option>
                            <option value="365">Cette année</option>
                        </select>
                    </div>
                    <div class="flex items-end">
                        <button onclick="resetFilters()" 
                                class="w-full px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                            <i class="fas fa-undo mr-2"></i>Réinitialiser
                        </button>
                    </div>
                </div>
            </div>

            <!-- Tableau des dépôts -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <div class="flex justify-between items-center">
                        <div>
                            <h3 class="text-lg leading-6 font-medium text-gray-900">
                                <i class="fas fa-piggy-bank mr-2"></i>Liste des Dépôts d'Épargne
                            </h3>
                            <p class="mt-1 max-w-2xl text-sm text-gray-500">
                                <span id="resultsCount">${not empty depots ? depots.size() : 0}</span> dépôt(s) trouvé(s)
                            </p>
                        </div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty depots}">
                        <div class="text-center py-12">
                            <i class="fas fa-piggy-bank text-gray-400 text-6xl mb-4"></i>
                            <h3 class="text-lg font-medium text-gray-900 mb-2">Aucun dépôt d'épargne trouvé</h3>
                            <p class="text-gray-500 mb-6">Commencez par créer votre premier dépôt d'épargne.</p>
                            <c:if test="${apiDisponible}">
                                <a href="${pageContext.request.contextPath}/epargne/nouveau-depot" 
                                   class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                                    <i class="fas fa-plus mr-2"></i>Créer un Dépôt
                                </a>
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200" id="depotsTable">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th onclick="sortTable(0)" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100">
                                            N° Dépôt <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th onclick="sortTable(1)" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100">
                                            Compte <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th onclick="sortTable(2)" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100">
                                            Montant Épargné <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th onclick="sortTable(3)" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100">
                                            Montant Disponible <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th onclick="sortTable(4)" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100">
                                            Taux <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th onclick="sortTable(5)" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100">
                                            Date de Création <i class="fas fa-sort ml-1"></i>
                                        </th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="depot" items="${depots}">
                                        <tr class="hover:bg-gray-50 depot-row">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                #${depot.idDepotEpargne}
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                <div class="flex flex-col">
                                                    <span class="font-medium">
                                                        <c:choose>
                                                            <c:when test="${not empty depot.numeroCompte}">
                                                                ${depot.numeroCompte}
                                                            </c:when>
                                                            <c:otherwise>
                                                                Compte #${depot.idCompte}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                    <c:if test="${not empty depot.nomClient and not empty depot.prenomClient}">
                                                        <span class="text-xs text-gray-500">${depot.prenomClient} ${depot.nomClient}</span>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-green-600">
                                                <fmt:formatNumber value="${depot.montantEpargne}" type="currency" currencySymbol="€"/>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                <div class="flex flex-col">
                                                    <span class="font-medium text-blue-600">
                                                        <fmt:formatNumber value="${depot.montantDisponible}" type="currency" currencySymbol="€"/>
                                                    </span>
                                                    <c:if test="${depot.montantDisponible < depot.montantEpargne}">
                                                        <span class="text-xs text-gray-500">
                                                            Retraits: <fmt:formatNumber value="${depot.montantEpargne - depot.montantDisponible}" type="currency" currencySymbol="€"/>
                                                        </span>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                <c:choose>
                                                    <c:when test="${not empty depot.tauxPourcentage}">
                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                                            <fmt:formatNumber value="${depot.tauxPourcentage}" pattern="#0.00"/>%
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-gray-400">N/A</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <c:choose>
                                                    <c:when test="${not empty depot.dateEpargne}">
                                                        ${depot.dateEpargne.toString().substring(0, 10)}
                                                    </c:when>
                                                    <c:otherwise>
                                                        N/A
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                <div class="flex space-x-2">
                                                    <button onclick="toggleDropdown('${depot.idDepotEpargne}')" 
                                                            class="text-gray-400 hover:text-gray-600 focus:outline-none">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </button>
                                                    <div id="dropdown-${depot.idDepotEpargne}" class="hidden absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg z-10 border">
                                                        <div class="py-1">
                                                            <a href="${pageContext.request.contextPath}/epargne/details?id=${depot.idDepotEpargne}" 
                                                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                                <i class="fas fa-eye mr-2"></i>Détails
                                                            </a>
                                                            <c:if test="${depot.montantDisponible > 0}">
                                                                <a href="${pageContext.request.contextPath}/epargne/nouveau-retrait?idDepot=${depot.idDepotEpargne}" 
                                                                   class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                                    <i class="fas fa-minus-circle mr-2"></i>Retrait
                                                                </a>
                                                            </c:if>
                                                            <a href="${pageContext.request.contextPath}/epargne/interets?id=${depot.idDepotEpargne}" 
                                                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                                <i class="fas fa-calculator mr-2"></i>Calculer Intérêts
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        let sortDirection = {};
        
        // Fonction de tri des colonnes
        function sortTable(columnIndex) {
            const table = document.getElementById('depotsTable');
            const tbody = table.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            
            const currentDirection = sortDirection[columnIndex] || 'asc';
            const newDirection = currentDirection === 'asc' ? 'desc' : 'asc';
            sortDirection[columnIndex] = newDirection;
            
            // Mettre à jour les icônes
            document.querySelectorAll('th i').forEach(icon => {
                icon.className = 'fas fa-sort ml-1';
            });
            document.querySelector('th:nth-child(' + (columnIndex + 1) + ') i').className = 
                'fas fa-sort-' + (newDirection === 'asc' ? 'up' : 'down') + ' ml-1';
            
            rows.sort((a, b) => {
                const aValue = a.cells[columnIndex].textContent.trim();
                const bValue = b.cells[columnIndex].textContent.trim();
                
                let comparison = 0;
                if (columnIndex === 2 || columnIndex === 3) { // Montants
                    const aNum = parseFloat(aValue.replace(/[€\s]/g, '').replace(',', '.')) || 0;
                    const bNum = parseFloat(bValue.replace(/[€\s]/g, '').replace(',', '.')) || 0;
                    comparison = aNum - bNum;
                } else if (columnIndex === 4) { // Taux
                    const aNum = parseFloat(aValue.replace('%', '')) || 0;
                    const bNum = parseFloat(bValue.replace('%', '')) || 0;
                    comparison = aNum - bNum;
                } else if (columnIndex === 5) { // Date
                    comparison = new Date(aValue) - new Date(bValue);
                } else { // Texte
                    comparison = aValue.localeCompare(bValue);
                }
                
                return newDirection === 'asc' ? comparison : -comparison;
            });
            
            // Réappliquer les lignes triées
            rows.forEach(row => tbody.appendChild(row));
        }
        
        // Fonction de recherche et filtrage
        function filterTable() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const montantMin = parseFloat(document.getElementById('montantMin').value) || 0;
            const periode = parseInt(document.getElementById('periodeFilter').value);
            
            const rows = document.querySelectorAll('.depot-row');
            let visibleCount = 0;
            
            const now = new Date();
            const cutoffDate = periode ? new Date(now.getTime() - (periode * 24 * 60 * 60 * 1000)) : null;
            
            rows.forEach(row => {
                const compte = row.cells[1].textContent.toLowerCase();
                const montantText = row.cells[2].textContent;
                const montant = parseFloat(montantText.replace(/[€\s]/g, '').replace(',', '.')) || 0;
                const dateText = row.cells[5].textContent.trim();
                const date = dateText !== 'N/A' ? new Date(dateText) : null;
                
                let visible = true;
                
                // Filtre de recherche
                if (searchTerm && !compte.includes(searchTerm)) {
                    visible = false;
                }
                
                // Filtre montant minimum
                if (montant < montantMin) {
                    visible = false;
                }
                
                // Filtre période
                if (cutoffDate && date && date < cutoffDate) {
                    visible = false;
                }
                
                row.style.display = visible ? '' : 'none';
                if (visible) visibleCount++;
            });
            
            document.getElementById('resultsCount').textContent = visibleCount;
        }
        
        // Fonction de réinitialisation des filtres
        function resetFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('montantMin').value = '';
            document.getElementById('periodeFilter').value = '';
            filterTable();
        }
        
        // Fonction d'export CSV
        function exportCSV() {
            const table = document.getElementById('depotsTable');
            const rows = table.querySelectorAll('tr:not([style*="display: none"])');
            
            let csv = 'N° Dépôt,Compte,Montant Épargné,Montant Disponible,Taux,Date de Création\n';
            
            for (let i = 1; i < rows.length; i++) {
                const cells = rows[i].querySelectorAll('td');
                const rowData = [
                    cells[0].textContent.trim(),
                    cells[1].textContent.trim().replace(/\n/g, ' '),
                    cells[2].textContent.trim(),
                    cells[3].textContent.trim().split('\n')[0],
                    cells[4].textContent.trim(),
                    cells[5].textContent.trim()
                ];
                csv += rowData.map(field => '"' + field.replace(/"/g, '""') + '"').join(',') + '\n';
            }
            
            const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'depots_epargne_' + new Date().toISOString().split('T')[0] + '.csv';
            link.click();
        }
        
        // Fonction pour afficher/masquer le menu dropdown
        function toggleDropdown(id) {
            const dropdown = document.getElementById('dropdown-' + id);
            const allDropdowns = document.querySelectorAll('[id^="dropdown-"]');
            
            // Fermer tous les autres dropdowns
            allDropdowns.forEach(d => {
                if (d.id !== 'dropdown-' + id) {
                    d.classList.add('hidden');
                }
            });
            
            // Toggle le dropdown actuel
            dropdown.classList.toggle('hidden');
        }
        
        // Fermer les dropdowns quand on clique ailleurs
        document.addEventListener('click', function(event) {
            if (!event.target.closest('button') || !event.target.closest('button').onclick) {
                document.querySelectorAll('[id^="dropdown-"]').forEach(d => {
                    d.classList.add('hidden');
                });
            }
        });
        
        // Événements de filtrage
        document.getElementById('searchInput').addEventListener('input', filterTable);
        document.getElementById('montantMin').addEventListener('input', filterTable);
        document.getElementById('periodeFilter').addEventListener('change', filterTable);
        
        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            filterTable();
        });
    </script>
</body>
</html>
