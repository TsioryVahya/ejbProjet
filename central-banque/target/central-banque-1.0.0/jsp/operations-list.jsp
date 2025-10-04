<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Opérations - Système Bancaire</title>
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
                    <a href="${pageContext.request.contextPath}/compte/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
                        <i class="fas fa-credit-card mr-2"></i>Comptes
                    </a>
                    <a href="${pageContext.request.contextPath}/operations/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium bg-blue-700">
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
    <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- En-tête -->
        <div class="px-4 py-6 sm:px-0">
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Liste des Opérations</h1>
                    <p class="text-gray-600 mt-2">Consultez toutes les opérations bancaires</p>
                </div>
                <div class="flex space-x-3">
                    <button onclick="exportOperations()" 
                           class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                        <i class="fas fa-download mr-2"></i>Exporter
                    </button>
                    <button onclick="refreshOperations()" 
                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                        <i class="fas fa-sync-alt mr-2"></i>Actualiser
                    </button>
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

            <!-- Statistiques -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="p-5">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-list-alt text-gray-400 text-2xl"></i>
                            </div>
                            <div class="ml-5 w-0 flex-1">
                                <dl>
                                    <dt class="text-sm font-medium text-gray-500 truncate">Total Opérations</dt>
                                    <dd class="text-lg font-medium text-gray-900">${not empty operations ? operations.size() : 0}</dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="p-5">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-arrow-up text-green-400 text-2xl"></i>
                            </div>
                            <div class="ml-5 w-0 flex-1">
                                <dl>
                                    <dt class="text-sm font-medium text-gray-500 truncate">Total Crédits</dt>
                                    <dd class="text-lg font-medium text-green-600">
                                        <fmt:formatNumber value="${totalCredits}" type="currency" currencySymbol="€"/>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="p-5">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-arrow-down text-red-400 text-2xl"></i>
                            </div>
                            <div class="ml-5 w-0 flex-1">
                                <dl>
                                    <dt class="text-sm font-medium text-gray-500 truncate">Total Débits</dt>
                                    <dd class="text-lg font-medium text-red-600">
                                        <fmt:formatNumber value="${totalDebits}" type="currency" currencySymbol="€"/>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="p-5">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <i class="fas fa-balance-scale text-blue-400 text-2xl"></i>
                            </div>
                            <div class="ml-5 w-0 flex-1">
                                <dl>
                                    <dt class="text-sm font-medium text-gray-500 truncate">Solde Net</dt>
                                    <dd class="text-lg font-medium ${soldeNet >= 0 ? 'text-green-600' : 'text-red-600'}">
                                        <fmt:formatNumber value="${soldeNet}" type="currency" currencySymbol="€"/>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filtres -->
            <div class="bg-white shadow rounded-lg mb-6">
                <div class="px-6 py-4">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">
                        <i class="fas fa-filter mr-2"></i>Filtres
                    </h3>
                    <form method="GET" action="${pageContext.request.contextPath}/operations/list" class="space-y-4">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                            <!-- Filtre par compte -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Compte</label>
                                <select name="idCompte" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-1 focus:ring-blue-500">
                                    <option value="">Tous les comptes</option>
                                    <c:forEach var="compte" items="${comptes}">
                                        <option value="${compte.idCompte}" ${selectedCompte == compte.idCompte ? 'selected' : ''}>
                                            ${compte.numeroCompte} - ${compte.nomCompletClient}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Filtre par type d'opération -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Type d'opération</label>
                                <select name="typeOperation" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-1 focus:ring-blue-500">
                                    <option value="TOUS">Tous les types</option>
                                    <option value="DEPOT" ${selectedTypeOperation == 'DEPOT' ? 'selected' : ''}>Dépôt</option>
                                    <option value="RETRAIT" ${selectedTypeOperation == 'RETRAIT' ? 'selected' : ''}>Retrait</option>
                                    <option value="VIREMENT_DEBIT" ${selectedTypeOperation == 'VIREMENT_DEBIT' ? 'selected' : ''}>Virement (Débit)</option>
                                    <option value="VIREMENT_CREDIT" ${selectedTypeOperation == 'VIREMENT_CREDIT' ? 'selected' : ''}>Virement (Crédit)</option>
                                    <option value="SOLDE_INITIAL" ${selectedTypeOperation == 'SOLDE_INITIAL' ? 'selected' : ''}>Solde Initial</option>
                                    <option value="INTERETS" ${selectedTypeOperation == 'INTERETS' ? 'selected' : ''}>Intérêts</option>
                                    <option value="FRAIS" ${selectedTypeOperation == 'FRAIS' ? 'selected' : ''}>Frais</option>
                                </select>
                            </div>

                            <!-- Filtre par date de début -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Date de début</label>
                                <input type="date" name="dateDebut" value="${dateDebut}" 
                                       class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-1 focus:ring-blue-500">
                            </div>

                            <!-- Filtre par date de fin -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Date de fin</label>
                                <input type="date" name="dateFin" value="${dateFin}" 
                                       class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-1 focus:ring-blue-500">
                            </div>
                        </div>

                        <div class="flex justify-between items-center">
                            <div class="flex items-center space-x-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Limite</label>
                                    <select name="limit" class="px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-1 focus:ring-blue-500">
                                        <option value="50" ${limit == 50 ? 'selected' : ''}>50</option>
                                        <option value="100" ${limit == 100 ? 'selected' : ''}>100</option>
                                        <option value="200" ${limit == 200 ? 'selected' : ''}>200</option>
                                        <option value="500" ${limit == 500 ? 'selected' : ''}>500</option>
                                    </select>
                                </div>
                            </div>
                            <div class="flex space-x-3">
                                <button type="button" onclick="clearFilters()" 
                                        class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300">
                                    <i class="fas fa-times mr-2"></i>Effacer
                                </button>
                                <button type="submit" 
                                        class="px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded-md hover:bg-blue-700">
                                    <i class="fas fa-search mr-2"></i>Filtrer
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Tableau des opérations -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <div class="flex justify-between items-center">
                        <div>
                            <h3 class="text-lg leading-6 font-medium text-gray-900">
                                <i class="fas fa-table mr-2"></i>Historique des Opérations
                            </h3>
                            <p class="mt-1 max-w-2xl text-sm text-gray-500">
                                <span id="operationsCount">${not empty operations ? operations.size() : 0}</span> opération(s) trouvée(s)
                            </p>
                        </div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty operations}">
                        <div class="text-center py-12">
                            <i class="fas fa-list-alt text-gray-400 text-6xl mb-4"></i>
                            <h3 class="text-lg font-medium text-gray-900 mb-2">Aucune opération trouvée</h3>
                            <p class="text-gray-500 mb-6">Aucune opération ne correspond aux critères de recherche.</p>
                            <button onclick="clearFilters()" 
                                   class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                <i class="fas fa-times mr-2"></i>Effacer les filtres
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200" id="operationsTable">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(0)">
                                            <div class="flex items-center">
                                                Date & Heure
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(1)">
                                            <div class="flex items-center">
                                                Compte
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(2)">
                                            <div class="flex items-center">
                                                Type d'opération
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Description
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(4)">
                                            <div class="flex items-center">
                                                Montant
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="operation" items="${operations}" varStatus="status">
                                        <tr class="hover:bg-gray-50 transition-colors duration-200 ${status.index % 2 == 0 ? 'bg-white' : 'bg-gray-25'}">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                <div class="flex items-center">
                                                    <i class="fas fa-clock mr-2 text-gray-400"></i>
                                                    <div>
                                                        <c:choose>
                                                            <c:when test="${not empty operation.dateOperationAsDate}">
                                                                <div class="font-medium">
                                                                    <fmt:formatDate value="${operation.dateOperationAsDate}" pattern="dd/MM/yyyy"/>
                                                                </div>
                                                                <div class="text-xs text-gray-500">
                                                                    <fmt:formatDate value="${operation.dateOperationAsDate}" pattern="HH:mm:ss"/>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="font-medium text-gray-400">
                                                                    Date non définie
                                                                </div>
                                                                <div class="text-xs text-gray-400">
                                                                    --:--:--
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="flex-shrink-0 h-8 w-8">
                                                        <div class="h-8 w-8 rounded-full bg-blue-100 flex items-center justify-center">
                                                            <i class="fas fa-credit-card text-blue-600 text-sm"></i>
                                                        </div>
                                                    </div>
                                                    <div class="ml-3">
                                                        <div class="text-sm font-medium text-gray-900">${operation.numeroCompte}</div>
                                                        <div class="text-xs text-gray-500">ID: ${operation.idCompte}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                    ${operation.credit ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                    <i class="fas ${operation.credit ? 'fa-arrow-up' : 'fa-arrow-down'} mr-1"></i>
                                                    ${operation.typeOperation}
                                                </span>
                                                <c:if test="${not empty operation.descriptionTypeOperation}">
                                                    <div class="text-xs text-gray-500 mt-1">${operation.descriptionTypeOperation}</div>
                                                </c:if>
                                            </td>
                                            <td class="px-6 py-4 text-sm text-gray-900">
                                                <div class="max-w-xs truncate" title="${operation.description}">
                                                    ${not empty operation.description ? operation.description : 'Aucune description'}
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-right">
                                                <div class="text-sm font-semibold ${operation.credit ? 'text-green-600' : 'text-red-600'}">
                                                    ${operation.credit ? '+' : '-'}<fmt:formatNumber value="${operation.montant}" type="currency" currencySymbol="€"/>
                                                </div>
                                                <div class="text-xs text-gray-500">
                                                    ${operation.credit ? 'Crédit' : 'Débit'}
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
        // Variables globales
        let currentSortColumn = -1;
        let currentSortDirection = 'asc';
        
        // Fonctions utilitaires
        function clearFilters() {
            window.location.href = '${pageContext.request.contextPath}/operations/list';
        }
        
        function refreshOperations() {
            window.location.reload();
        }
        
        function exportOperations() {
            // TODO: Implémenter l'export
            alert('Fonctionnalité d\'export en cours de développement');
        }
        
        // Fonction de tri du tableau
        function sortTable(columnIndex) {
            const table = document.getElementById('operationsTable');
            const tbody = table.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            
            // Déterminer la direction du tri
            if (currentSortColumn === columnIndex) {
                currentSortDirection = currentSortDirection === 'asc' ? 'desc' : 'asc';
            } else {
                currentSortDirection = 'asc';
                currentSortColumn = columnIndex;
            }
            
            // Trier les lignes
            rows.sort((a, b) => {
                const aValue = getCellValue(a, columnIndex);
                const bValue = getCellValue(b, columnIndex);
                
                let comparison = 0;
                if (columnIndex === 0) { // Colonne date
                    const aDate = new Date(aValue.replace(/(\d{2})\/(\d{2})\/(\d{4})/, '$3-$2-$1'));
                    const bDate = new Date(bValue.replace(/(\d{2})\/(\d{2})\/(\d{4})/, '$3-$2-$1'));
                    comparison = aDate - bDate;
                } else if (columnIndex === 4) { // Colonne montant
                    const aNum = parseFloat(aValue.replace(/[€\s+\-,]/g, '').replace(',', '.'));
                    const bNum = parseFloat(bValue.replace(/[€\s+\-,]/g, '').replace(',', '.'));
                    comparison = aNum - bNum;
                } else { // Tri alphabétique
                    comparison = aValue.localeCompare(bValue, 'fr', { numeric: true });
                }
                
                return currentSortDirection === 'asc' ? comparison : -comparison;
            });
            
            // Réinsérer les lignes triées
            rows.forEach(row => tbody.appendChild(row));
            
            // Mettre à jour les icônes de tri
            updateSortIcons(columnIndex);
        }
        
        function getCellValue(row, columnIndex) {
            const cell = row.querySelectorAll('td')[columnIndex];
            return cell ? cell.textContent.trim() : '';
        }
        
        function updateSortIcons(activeColumn) {
            const headers = document.querySelectorAll('#operationsTable thead th');
            headers.forEach((header, index) => {
                const icon = header.querySelector('i.fas');
                if (icon) {
                    if (index === activeColumn) {
                        icon.className = currentSortDirection === 'asc' 
                            ? 'fas fa-sort-up ml-1 text-blue-600' 
                            : 'fas fa-sort-down ml-1 text-blue-600';
                    } else {
                        icon.className = 'fas fa-sort ml-1 text-gray-400';
                    }
                }
            });
        }
    </script>
</body>
</html>
