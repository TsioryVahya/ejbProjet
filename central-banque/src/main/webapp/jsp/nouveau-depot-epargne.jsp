<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau Dépôt d'Épargne - Système Bancaire</title>
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
                       class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                        <i class="fas fa-users text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
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
                       class="bg-blue-700 text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200 hover:bg-blue-600">
                        <i class="fas fa-piggy-bank text-blue-200 mr-3 text-lg"></i>
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
                        <a href="${pageContext.request.contextPath}/client/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-users mr-3"></i>Clients
                        </a>
                        <a href="${pageContext.request.contextPath}/compte/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-credit-card mr-3"></i>Comptes
                        </a>
                        <a href="${pageContext.request.contextPath}/operations/list" class="text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                            <i class="fas fa-exchange-alt mr-3"></i>Opérations
                        </a>
                        <a href="${pageContext.request.contextPath}/epargne/list" class="bg-blue-700 text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
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
                            <h1 class="text-2xl font-semibold text-gray-900">Nouveau Dépôt d'Épargne</h1>
                        </div>
                        <div class="flex items-center space-x-4">
                            <a href="${pageContext.request.contextPath}/epargne/list" 
                               class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-lg text-gray-700 bg-white hover:bg-gray-50 shadow-sm transition-all duration-200">
                                <i class="fas fa-arrow-left mr-2"></i>Retour à la liste
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Page content -->
            <main class="flex-1 relative pb-8 overflow-y-auto">
                <div class="px-4 sm:px-6 lg:px-8 py-8">

    <!-- Messages d'erreur -->
    <c:if test="${not empty erreur}">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-4">
            <div class="bg-red-50 border border-red-200 rounded-md p-4">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="fas fa-exclamation-circle text-red-400"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-red-800">${erreur}</p>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Contenu principal -->
    <div class="max-w-3xl mx-auto py-6 sm:px-6 lg:px-8">
        <div class="px-4 py-6 sm:px-0">
            <!-- En-tête -->
            <div class="mb-8">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">Nouveau Dépôt d'Épargne</h1>
                        <p class="mt-2 text-sm text-gray-600">Effectuer un dépôt sur un compte d'épargne</p>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/epargne/list" 
                           class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <i class="fas fa-arrow-left mr-2"></i>
                            Retour à la liste
                        </a>
                    </div>
                </div>
            </div>

            <!-- Formulaire de dépôt -->
            <div class="bg-white shadow sm:rounded-lg">
                <div class="px-4 py-5 sm:p-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900 mb-6">
                        <i class="fas fa-piggy-bank mr-2 text-green-600"></i>
                        Informations du dépôt
                    </h3>
                    
                    <form action="${pageContext.request.contextPath}/epargne/creer-depot" method="post" class="space-y-6">
                        <!-- Sélection du compte -->
                        <div>
                            <label for="idCompte" class="block text-sm font-medium text-gray-700 mb-2">
                                Compte d'épargne *
                            </label>
                            <select name="idCompte" id="idCompte" required
                                    class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 sm:text-sm">
                                <option value="">Sélectionnez un compte d'épargne</option>
                                <c:forEach var="compte" items="${comptesEpargne}">
                                    <option value="${compte.idCompte}" ${param.idCompte == compte.idCompte ? 'selected' : ''}>
                                        ${compte.numeroCompte} - ${compte.client.prenom} ${compte.client.nom}
                                        <c:if test="${not empty compte.typeCompte}">
                                            (${compte.typeCompte.nomTypeCompte})
                                        </c:if>
                                    </option>
                                </c:forEach>
                            </select>
                            <p class="mt-1 text-xs text-gray-500">
                                Choisissez le compte d'épargne sur lequel effectuer le dépôt
                            </p>
                        </div>

                        <!-- Montant -->
                        <div>
                            <label for="montant" class="block text-sm font-medium text-gray-700 mb-2">
                                Montant du dépôt *
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-euro-sign text-gray-400"></i>
                                </div>
                                <input type="number" name="montant" id="montant" step="0.01" min="0.01" required
                                       value="${param.montant}"
                                       class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 sm:text-sm"
                                       placeholder="0.00">
                            </div>
                            <p class="mt-1 text-xs text-gray-500">
                                Montant minimum : 0,01 €
                            </p>
                        </div>

                        <!-- Durée de placement (optionnel) -->
                        <div>
                            <label for="duree" class="block text-sm font-medium text-gray-700 mb-2">
                                Durée de placement (jours)
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-calendar text-gray-400"></i>
                                </div>
                                <input type="number" name="duree" id="duree" min="1" max="3650"
                                       value="${param.duree}"
                                       class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 sm:text-sm"
                                       placeholder="365">
                            </div>
                            <p class="mt-1 text-xs text-gray-500">
                                Durée souhaitée pour le placement (optionnel, entre 1 et 3650 jours)
                            </p>
                        </div>

                        <!-- Informations sur les taux -->
                        <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
                            <h4 class="text-sm font-medium text-blue-900 mb-2">
                                <i class="fas fa-info-circle mr-2"></i>
                                Informations sur les taux d'intérêt
                            </h4>
                            <div class="text-sm text-blue-800 space-y-1">
                                <p>• Les taux d'intérêt sont appliqués automatiquement selon les conditions en vigueur</p>
                                <p>• Les intérêts sont calculés quotidiennement et capitalisés</p>
                                <p>• Vous pouvez effectuer des retraits à tout moment selon les conditions de votre contrat</p>
                            </div>
                        </div>

                        <!-- Calculateur d'intérêts estimés -->
                        <div class="bg-gray-50 border border-gray-200 rounded-lg p-4">
                            <h4 class="text-sm font-medium text-gray-900 mb-3">
                                <i class="fas fa-calculator mr-2"></i>
                                Estimation des intérêts
                            </h4>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm">
                                <div class="text-center">
                                    <p class="text-gray-600">Taux estimé</p>
                                    <p class="text-lg font-semibold text-green-600">2,0%</p>
                                    <p class="text-xs text-gray-500">par an</p>
                                </div>
                                <div class="text-center">
                                    <p class="text-gray-600">Intérêts/mois</p>
                                    <p id="interetsEstimes" class="text-lg font-semibold text-blue-600">-</p>
                                    <p class="text-xs text-gray-500">estimation</p>
                                </div>
                                <div class="text-center">
                                    <p class="text-gray-600">Total après 1 an</p>
                                    <p id="totalEstime" class="text-lg font-semibold text-purple-600">-</p>
                                    <p class="text-xs text-gray-500">capital + intérêts</p>
                                </div>
                            </div>
                        </div>

                        <!-- Boutons d'action -->
                        <div class="flex justify-end space-x-3 pt-6 border-t border-gray-200">
                            <a href="${pageContext.request.contextPath}/epargne/list" 
                               class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                Annuler
                            </a>
                            <button type="submit" 
                                    class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                <i class="fas fa-piggy-bank mr-2"></i>
                                Effectuer le dépôt
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Aide et conseils -->
            <div class="mt-8 bg-white shadow sm:rounded-lg">
                <div class="px-4 py-5 sm:p-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                        <i class="fas fa-lightbulb mr-2 text-yellow-500"></i>
                        Conseils pour votre épargne
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="space-y-3">
                            <div class="flex items-start">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-check-circle text-green-500 mt-1"></i>
                                </div>
                                <div class="ml-3">
                                    <h4 class="text-sm font-medium text-gray-900">Diversifiez vos placements</h4>
                                    <p class="text-sm text-gray-600">Répartissez votre épargne sur différents types de comptes selon vos objectifs.</p>
                                </div>
                            </div>
                            <div class="flex items-start">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-check-circle text-green-500 mt-1"></i>
                                </div>
                                <div class="ml-3">
                                    <h4 class="text-sm font-medium text-gray-900">Épargnez régulièrement</h4>
                                    <p class="text-sm text-gray-600">Des dépôts réguliers, même petits, peuvent générer des gains importants sur le long terme.</p>
                                </div>
                            </div>
                        </div>
                        <div class="space-y-3">
                            <div class="flex items-start">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-check-circle text-green-500 mt-1"></i>
                                </div>
                                <div class="ml-3">
                                    <h4 class="text-sm font-medium text-gray-900">Surveillez les taux</h4>
                                    <p class="text-sm text-gray-600">Les taux d'intérêt peuvent évoluer. Consultez régulièrement vos comptes.</p>
                                </div>
                            </div>
                            <div class="flex items-start">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-check-circle text-green-500 mt-1"></i>
                                </div>
                                <div class="ml-3">
                                    <h4 class="text-sm font-medium text-gray-900">Planifiez vos objectifs</h4>
                                    <p class="text-sm text-gray-600">Définissez des objectifs d'épargne clairs pour rester motivé.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8 mt-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center">
                <p class="text-sm">© 2025 Système Bancaire - Projet EJB & C# API</p>
                <p class="text-xs text-gray-400 mt-2">Nouveau dépôt d'épargne</p>
            </div>
        </div>
    </footer>

    <script>
        // Calculateur d'intérêts en temps réel
        function calculerInteretsEstimes() {
            const montant = parseFloat(document.getElementById('montant').value) || 0;
            const tauxAnnuel = 2.0; // Taux estimé de 2%
            
            if (montant > 0) {
                const interetsMensuel = (montant * tauxAnnuel / 100) / 12;
                const totalAnnuel = montant + (montant * tauxAnnuel / 100);
                
                document.getElementById('interetsEstimes').textContent = 
                    interetsMensuel.toFixed(2) + ' €';
                document.getElementById('totalEstime').textContent = 
                    totalAnnuel.toFixed(2) + ' €';
            } else {
                document.getElementById('interetsEstimes').textContent = '-';
                document.getElementById('totalEstime').textContent = '-';
            }
        }
        
        // Écouter les changements du montant
        document.getElementById('montant').addEventListener('input', calculerInteretsEstimes);
        
        // Calculer au chargement de la page si un montant est déjà saisi
        document.addEventListener('DOMContentLoaded', calculerInteretsEstimes);
        
        // Validation du formulaire
        document.querySelector('form').addEventListener('submit', function(e) {
            const montantInput = document.getElementById('montant');
            const montant = parseFloat(montantInput.value);
            const compte = document.getElementById('idCompte').value;
            
            if (!compte) {
                e.preventDefault();
                alert('Veuillez sélectionner un compte d\'épargne.');
                return;
            }
            
            if (!montantInput.value || isNaN(montant) || montant <= 0) {
                e.preventDefault();
                alert('Veuillez saisir un montant valide supérieur à 0.');
                return;
            }
            
            // Confirmation du dépôt
            const confirmation = confirm(
                `Confirmer le dépôt de ${montant.toFixed(2)} € ?`
            );
            
            if (!confirmation) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
