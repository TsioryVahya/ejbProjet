<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Clients - Système Bancaire</title>
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
                    <a href="${pageContext.request.contextPath}/client/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium bg-blue-700">
                        <i class="fas fa-users mr-2"></i>Clients
                    </a>
                    <a href="${pageContext.request.contextPath}/compte/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
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
    <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- En-tête -->
        <div class="px-4 py-6 sm:px-0">
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Gestion des Clients</h1>
                    <p class="text-gray-600 mt-2">Gérez tous les clients de la banque</p>
                </div>
                <div class="flex space-x-3">
                    <a href="${pageContext.request.contextPath}/client/nouveau" 
                       class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                        <i class="fas fa-plus mr-2"></i>Nouveau Client
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

            <!-- Barre de recherche -->
            <div class="bg-white shadow rounded-lg mb-6">
                <div class="px-6 py-4">
                    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between space-y-3 sm:space-y-0">
                        <div class="flex-1 max-w-lg">
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-search text-gray-400"></i>
                                </div>
                                <input type="text" id="searchInput" placeholder="Rechercher par nom, prénom, email..."
                                       class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md leading-5 bg-white placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-1 focus:ring-blue-500 focus:border-blue-500">
                            </div>
                        </div>
                        <div class="flex items-center space-x-3">
                            <button onclick="exportToCSV()" class="inline-flex items-center px-3 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                <i class="fas fa-download mr-2"></i>Exporter CSV
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tableau des clients -->
            <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <div class="flex justify-between items-center">
                        <div>
                            <h3 class="text-lg leading-6 font-medium text-gray-900">
                                <i class="fas fa-table mr-2"></i>Liste des Clients
                            </h3>
                            <p class="mt-1 max-w-2xl text-sm text-gray-500">
                                <span id="clientsCount">${not empty clients ? clients.size() : 0}</span> client(s) trouvé(s)
                            </p>
                        </div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty clients}">
                        <div class="text-center py-12">
                            <i class="fas fa-users text-gray-400 text-6xl mb-4"></i>
                            <h3 class="text-lg font-medium text-gray-900 mb-2">Aucun client trouvé</h3>
                            <p class="text-gray-500 mb-6">Commencez par créer votre premier client.</p>
                            <a href="${pageContext.request.contextPath}/client/nouveau" 
                               class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                <i class="fas fa-plus mr-2"></i>Créer un Client
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200" id="clientsTable">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(0)">
                                            <div class="flex items-center">
                                                Nom & Prénom
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(1)">
                                            <div class="flex items-center">
                                                Contact
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider cursor-pointer hover:bg-gray-100" onclick="sortTable(2)">
                                            <div class="flex items-center">
                                                Date de Création
                                                <i class="fas fa-sort ml-1 text-gray-400"></i>
                                            </div>
                                        </th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                            Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach var="client" items="${clients}" varStatus="status">
                                        <tr class="hover:bg-gray-50 transition-colors duration-200 ${status.index % 2 == 0 ? 'bg-white' : 'bg-gray-25'}">
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="flex-shrink-0 h-10 w-10">
                                                        <div class="h-10 w-10 rounded-full bg-blue-100 flex items-center justify-center">
                                                            <i class="fas fa-user text-blue-600 text-lg"></i>
                                                        </div>
                                                    </div>
                                                    <div class="ml-4">
                                                        <div class="text-sm font-medium text-gray-900">
                                                            ${client.nom} ${client.prenom}
                                                        </div>
                                                        <div class="text-xs text-gray-500">ID: ${client.idClient}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="text-sm text-gray-900">
                                                    <c:if test="${not empty client.email}">
                                                        <div class="flex items-center mb-1">
                                                            <i class="fas fa-envelope mr-2 text-gray-400"></i>
                                                            <a href="mailto:${client.email}" class="text-blue-600 hover:text-blue-800">${client.email}</a>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${not empty client.telephone}">
                                                        <div class="flex items-center">
                                                            <i class="fas fa-phone mr-2 text-gray-400"></i>
                                                            <a href="tel:${client.telephone}" class="text-blue-600 hover:text-blue-800">${client.telephone}</a>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${empty client.email and empty client.telephone}">
                                                        <span class="text-gray-400 text-xs">Aucun contact</span>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <c:choose>
                                                    <c:when test="${not empty client.dateCreationAsDate}">
                                                        <div class="flex items-center">
                                                            <i class="fas fa-calendar-alt mr-2 text-gray-400"></i>
                                                            <div>
                                                                <div><fmt:formatDate value="${client.dateCreationAsDate}" pattern="dd/MM/yyyy"/></div>
                                                                <div class="text-xs text-gray-400"><fmt:formatDate value="${client.dateCreationAsDate}" pattern="HH:mm"/></div>
                                                            </div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-gray-400">Date non définie</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                <div class="flex items-center space-x-2">
                                                    <a href="${pageContext.request.contextPath}/client/details?id=${client.idClient}" 
                                                       class="inline-flex items-center px-2 py-1 border border-gray-300 text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 transition-colors duration-200"
                                                       title="Voir les détails">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/compte/list?clientId=${client.idClient}" 
                                                       class="inline-flex items-center px-2 py-1 border border-gray-300 text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 transition-colors duration-200"
                                                       title="Voir les comptes">
                                                        <i class="fas fa-credit-card"></i>
                                                    </a>
                                                    <div class="relative inline-block text-left">
                                                        <button onclick="toggleDropdown('${client.idClient}')" class="inline-flex items-center px-2 py-1 border border-gray-300 text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 transition-colors duration-200">
                                                            <i class="fas fa-ellipsis-v"></i>
                                                        </button>
                                                        <div id="dropdown-${client.idClient}" class="hidden origin-top-right absolute right-0 mt-2 w-48 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 z-10">
                                                            <div class="py-1">
                                                                <a href="${pageContext.request.contextPath}/compte/nouveau?clientId=${client.idClient}" class="flex items-center w-full px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                                    <i class="fas fa-plus-circle mr-2 text-green-600"></i>Créer un compte
                                                                </a>
                                                                <button onclick="editClient('${client.idClient}', '${client.nom}', '${client.prenom}', '${client.email}', '${client.telephone}')" class="flex items-center w-full px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                                    <i class="fas fa-edit mr-2 text-blue-600"></i>Modifier
                                                                </button>
                                                            </div>
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

    <!-- Modal Modification Client -->
    <div id="editModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full hidden z-50">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
            <div class="mt-3">
                <h3 class="text-lg font-medium text-gray-900 mb-4">
                    <i class="fas fa-edit mr-2 text-blue-600"></i>Modifier le Client
                </h3>
                <form action="${pageContext.request.contextPath}/client/modifier" method="post">
                    <input type="hidden" id="editIdClient" name="idClient">
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Nom *</label>
                        <input type="text" id="editNom" name="nom" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Prénom *</label>
                        <input type="text" id="editPrenom" name="prenom" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                        <input type="email" id="editEmail" name="email" 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Téléphone</label>
                        <input type="tel" id="editTelephone" name="telephone" 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div class="flex justify-end space-x-3">
                        <button type="button" onclick="hideEditModal()" 
                                class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300">
                            Annuler
                        </button>
                        <button type="submit" 
                                class="px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded-md hover:bg-blue-700">
                            Modifier
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Variables globales
        let currentSortColumn = -1;
        let currentSortDirection = 'asc';
        
        // Initialisation au chargement de la page
        document.addEventListener('DOMContentLoaded', function() {
            initializeSearch();
        });
        
        // Fonction de recherche
        function initializeSearch() {
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('input', function() {
                    filterTable();
                });
            }
        }
        
        function filterTable() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const table = document.getElementById('clientsTable');
            const tbody = table.querySelector('tbody');
            const rows = tbody.querySelectorAll('tr');
            
            let visibleCount = 0;
            
            rows.forEach(row => {
                const cells = row.querySelectorAll('td');
                if (cells.length === 0) return;
                
                const nom = cells[0].textContent.toLowerCase();
                const contact = cells[1].textContent.toLowerCase();
                
                const matchesSearch = !searchTerm || 
                    nom.includes(searchTerm) || 
                    contact.includes(searchTerm);
                
                if (matchesSearch) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            document.getElementById('clientsCount').textContent = visibleCount;
        }
        
        // Fonction de tri
        function sortTable(columnIndex) {
            const table = document.getElementById('clientsTable');
            const tbody = table.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            
            if (currentSortColumn === columnIndex) {
                currentSortDirection = currentSortDirection === 'asc' ? 'desc' : 'asc';
            } else {
                currentSortDirection = 'asc';
                currentSortColumn = columnIndex;
            }
            
            rows.sort((a, b) => {
                const aValue = getCellValue(a, columnIndex);
                const bValue = getCellValue(b, columnIndex);
                
                let comparison = 0;
                if (columnIndex === 2) { // Colonne date
                    const aDate = new Date(aValue.split('/').reverse().join('-'));
                    const bDate = new Date(bValue.split('/').reverse().join('-'));
                    comparison = aDate - bDate;
                } else {
                    comparison = aValue.localeCompare(bValue, 'fr', { numeric: true });
                }
                
                return currentSortDirection === 'asc' ? comparison : -comparison;
            });
            
            rows.forEach(row => tbody.appendChild(row));
            updateSortIcons(columnIndex);
        }
        
        function getCellValue(row, columnIndex) {
            const cell = row.querySelectorAll('td')[columnIndex];
            return cell ? cell.textContent.trim() : '';
        }
        
        function updateSortIcons(activeColumn) {
            const headers = document.querySelectorAll('#clientsTable thead th');
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
        
        // Fonctions dropdown
        function toggleDropdown(clientId) {
            document.querySelectorAll('[id^="dropdown-"]').forEach(dropdown => {
                if (dropdown.id !== 'dropdown-' + clientId) {
                    dropdown.classList.add('hidden');
                }
            });
            
            const dropdown = document.getElementById('dropdown-' + clientId);
            if (dropdown) {
                dropdown.classList.toggle('hidden');
            }
        }
        
        document.addEventListener('click', function(event) {
            if (!event.target.closest('.relative')) {
                document.querySelectorAll('[id^="dropdown-"]').forEach(dropdown => {
                    dropdown.classList.add('hidden');
                });
            }
        });
        
        // Fonctions modal
        function editClient(id, nom, prenom, email, telephone) {
            document.getElementById('editIdClient').value = id;
            document.getElementById('editNom').value = nom;
            document.getElementById('editPrenom').value = prenom;
            document.getElementById('editEmail').value = email || '';
            document.getElementById('editTelephone').value = telephone || '';
            document.getElementById('editModal').classList.remove('hidden');
            toggleDropdown(id);
        }
        
        function hideEditModal() {
            document.getElementById('editModal').classList.add('hidden');
        }
        
        // Export CSV
        function exportToCSV() {
            const table = document.getElementById('clientsTable');
            const rows = table.querySelectorAll('tr');
            let csv = [];
            
            const headers = ['Nom', 'Prénom', 'Email', 'Téléphone', 'Date de Création'];
            csv.push(headers.join(','));
            
            for (let i = 1; i < rows.length; i++) {
                const row = rows[i];
                if (row.style.display === 'none') continue;
                
                const cells = row.querySelectorAll('td');
                const nomPrenom = cells[0].textContent.trim().split(' ');
                const nom = nomPrenom[0] || '';
                const prenom = nomPrenom.slice(1).join(' ') || '';
                const contact = cells[1].textContent.trim();
                const email = contact.includes('@') ? contact.split('\n')[0] : '';
                const telephone = contact.includes('@') ? contact.split('\n')[1] || '' : contact;
                const date = cells[2].textContent.trim();
                
                const rowData = [nom, prenom, email, telephone, date];
                csv.push(rowData.map(field => `"${field}"`).join(','));
            }
            
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            const url = URL.createObjectURL(blob);
            link.setAttribute('href', url);
            link.setAttribute('download', 'clients_' + new Date().toISOString().split('T')[0] + '.csv');
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    </script>
</body>
</html>
