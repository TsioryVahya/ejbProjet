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
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'bank-blue': '#1e40af',
                        'bank-light': '#3b82f6',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-100 font-sans">
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <div class="hidden md:flex md:w-64 md:flex-col">
            <div class="flex flex-col flex-grow pt-5 overflow-y-auto bg-gradient-to-b from-bank-blue to-blue-800 shadow-xl">
                <!-- Logo -->
                <div class="flex items-center flex-shrink-0 px-6 py-4">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center">
                                <i class="fas fa-university text-bank-blue text-xl"></i>
                            </div>
                        </div>
                        <div class="ml-3">
                            <h1 class="text-white text-lg font-bold">BankSystem</h1>
                            <p class="text-blue-200 text-xs">Gestion Bancaire</p>
                        </div>
                    </div>
                </div>

                <!-- Navigation -->
                <nav class="mt-8 flex-1 px-3 space-y-1">
                    <a href="${pageContext.request.contextPath}/accueil" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-home text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Tableau de Bord</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/client/list" 
                       class="bg-blue-700 text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200 hover:bg-blue-600">
                        <i class="fas fa-users text-blue-200 mr-3 text-lg"></i>
                        <span>Clients</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/compte/list" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-credit-card text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Comptes</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/operations/list" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-exchange-alt text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Opérations</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/epargne/list" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-piggy-bank text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Épargne</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/pret/list" 
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-hand-holding-usd text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                        <span>Prêts</span>
                    </a>
                </nav>

                <!-- Footer Sidebar -->
                <div class="flex-shrink-0 p-4 border-t border-blue-600">
                    <div class="text-center">
                        <p class="text-xs text-blue-200">© 2025 BankSystem</p>
                        <p class="text-xs text-blue-300 mt-1">v2.0.0</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Mobile menu button -->
        <div class="md:hidden">
            <button id="mobile-menu-button" class="fixed top-4 left-4 z-50 bg-bank-blue text-white p-2 rounded-lg shadow-lg">
                <i class="fas fa-bars"></i>
            </button>
        </div>

        <!-- Mobile sidebar -->
        <div id="mobile-sidebar" class="fixed inset-0 z-40 md:hidden hidden">
            <div class="fixed inset-0 bg-gray-600 bg-opacity-75" onclick="toggleMobileSidebar()"></div>
            <div class="relative flex-1 flex flex-col max-w-xs w-full bg-gradient-to-b from-bank-blue to-blue-800">
                <div class="absolute top-0 right-0 -mr-12 pt-2">
                    <button onclick="toggleMobileSidebar()" class="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white">
                        <i class="fas fa-times text-white"></i>
                    </button>
                </div>
                <div class="flex-1 h-0 pt-5 pb-4 overflow-y-auto">
                    <div class="flex-shrink-0 flex items-center px-4">
                        <div class="w-8 h-8 bg-white rounded-lg flex items-center justify-center">
                            <i class="fas fa-university text-bank-blue"></i>
                        </div>
                        <h1 class="ml-2 text-white text-lg font-bold">BankSystem</h1>
                    </div>
                    <nav class="mt-5 px-2 space-y-1">
                        <a href="${pageContext.request.contextPath}/accueil" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-home mr-3"></i>Tableau de Bord
                        </a>
                        <a href="${pageContext.request.contextPath}/client/list" class="bg-blue-700 text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-users mr-3"></i>Clients
                        </a>
                        <a href="${pageContext.request.contextPath}/compte/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-credit-card mr-3"></i>Comptes
                        </a>
                        <a href="${pageContext.request.contextPath}/operations/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-exchange-alt mr-3"></i>Opérations
                        </a>
                        <a href="${pageContext.request.contextPath}/epargne/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-piggy-bank mr-3"></i>Épargne
                        </a>
                        <a href="${pageContext.request.contextPath}/pret/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-hand-holding-usd mr-3"></i>Prêts
                        </a>
                    </nav>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="flex-1 overflow-auto focus:outline-none">
            <!-- Top bar -->
            <div class="bg-white shadow-sm border-b border-gray-200">
                <div class="px-4 sm:px-6 lg:px-8">
                    <div class="flex justify-between h-16">
                        <div class="flex items-center">
                            <h1 class="text-2xl font-semibold text-gray-900">Gestion des Clients</h1>
                        </div>
                        <div class="flex items-center space-x-4">
                            <a href="${pageContext.request.contextPath}/client/nouveau" 
                               class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-lg text-white bg-gradient-to-r from-green-500 to-green-600 hover:from-green-600 hover:to-green-700 shadow-md hover:shadow-lg transition-all duration-200">
                                <i class="fas fa-plus mr-2"></i>Nouveau Client
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Page content -->
            <main class="flex-1 relative pb-8 overflow-y-auto">
                <div class="px-4 sm:px-6 lg:px-8 py-8">
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

        // Mobile sidebar functionality
        function toggleMobileSidebar() {
            const sidebar = document.getElementById('mobile-sidebar');
            sidebar.classList.toggle('hidden');
        }

        // Mobile menu button functionality
        document.getElementById('mobile-menu-button').addEventListener('click', toggleMobileSidebar);

        // Close mobile sidebar when clicking outside
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('mobile-sidebar');
            const menuButton = document.getElementById('mobile-menu-button');
            
            if (!sidebar.contains(event.target) && !menuButton.contains(event.target)) {
                sidebar.classList.add('hidden');
            }
        });
    </script>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
