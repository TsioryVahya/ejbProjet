<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simulation de Prêt - Système Bancaire</title>
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
                    <a href="${pageContext.request.contextPath}/operations/list" class="text-white hover:text-blue-200 px-3 py-2 rounded-md text-sm font-medium">
                        <i class="fas fa-list-alt mr-2"></i>Opérations
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
    <div class="max-w-4xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- En-tête -->
        <div class="px-4 py-6 sm:px-0">
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Simulation de Prêt</h1>
                    <p class="text-gray-600 mt-2">Calculez vos mensualités et le coût total de votre prêt</p>
                </div>
                <div class="flex space-x-3">
                    <a href="${pageContext.request.contextPath}/pret/list" 
                       class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                        <i class="fas fa-arrow-left mr-2"></i>Retour aux Prêts
                    </a>
                    <a href="${pageContext.request.contextPath}/pret/nouveau" 
                       class="inline-flex items-center px-4 py-2 border border-green-300 text-sm font-medium rounded-md text-green-700 bg-green-50 hover:bg-green-100">
                        <i class="fas fa-plus mr-2"></i>Créer un Prêt
                    </a>
                </div>
            </div>

            <!-- Messages -->
            <c:if test="${not empty erreur}">
                <div class="mb-4 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <span class="block sm:inline">${erreur}</span>
                </div>
            </c:if>

            <!-- Formulaire de simulation -->
            <div class="bg-white shadow rounded-lg">
                <div class="px-4 py-5 sm:p-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900 mb-6">
                        <i class="fas fa-calculator mr-2 text-blue-600"></i>Paramètres de Simulation
                    </h3>

                    <form action="${pageContext.request.contextPath}/pret/simuler" method="post" class="space-y-6" id="simulationForm">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Montant du prêt -->
                            <div>
                                <label for="montant" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-euro-sign mr-1"></i>Montant du Prêt (€) *
                                </label>
                                <input type="number" 
                                       id="montant" 
                                       name="montant" 
                                       required 
                                       step="0.01" 
                                       min="0.01" 
                                       max="500000"
                                       value="${param.montant}"
                                       placeholder="Ex: 10000.00"
                                       onchange="calculateSimulation()"
                                       class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                            </div>

                            <!-- Durée du prêt -->
                            <div>
                                <label for="duree" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-calendar-alt mr-1"></i>Durée (en mois) *
                                </label>
                                <select id="duree" 
                                        name="duree" 
                                        required 
                                        onchange="calculateSimulation()"
                                        class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                    <option value="">Sélectionner la durée</option>
                                    <option value="12" ${param.duree == '12' ? 'selected' : ''}>12 mois (1 an)</option>
                                    <option value="24" ${param.duree == '24' ? 'selected' : ''}>24 mois (2 ans)</option>
                                    <option value="36" ${param.duree == '36' ? 'selected' : ''}>36 mois (3 ans)</option>
                                    <option value="48" ${param.duree == '48' ? 'selected' : ''}>48 mois (4 ans)</option>
                                    <option value="60" ${param.duree == '60' ? 'selected' : ''}>60 mois (5 ans)</option>
                                    <option value="84" ${param.duree == '84' ? 'selected' : ''}>84 mois (7 ans)</option>
                                    <option value="120" ${param.duree == '120' ? 'selected' : ''}>120 mois (10 ans)</option>
                                    <option value="180" ${param.duree == '180' ? 'selected' : ''}>180 mois (15 ans)</option>
                                    <option value="240" ${param.duree == '240' ? 'selected' : ''}>240 mois (20 ans)</option>
                                    <option value="300" ${param.duree == '300' ? 'selected' : ''}>300 mois (25 ans)</option>
                                </select>
                            </div>
                        </div>

                        <!-- Boutons d'action -->
                        <div class="flex justify-center space-x-3 pt-4">
                            <button type="button" 
                                    onclick="calculateSimulation()"
                                    class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                <i class="fas fa-calculator mr-2"></i>Calculer la Simulation
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Résultats de simulation -->
            <div id="resultatsSimulation" class="mt-8 bg-white shadow rounded-lg hidden">
                <div class="px-4 py-5 sm:p-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900 mb-6">
                        <i class="fas fa-chart-line mr-2 text-green-600"></i>Résultats de la Simulation
                    </h3>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                        <div class="bg-blue-50 rounded-lg p-4 text-center">
                            <div class="text-3xl font-bold text-blue-600 mb-2" id="mensualiteResult">-</div>
                            <div class="text-sm text-blue-700">Mensualité</div>
                        </div>
                        <div class="bg-green-50 rounded-lg p-4 text-center">
                            <div class="text-2xl font-bold text-green-600 mb-2" id="totalResult">-</div>
                            <div class="text-sm text-green-700">Total à rembourser</div>
                        </div>
                        <div class="bg-orange-50 rounded-lg p-4 text-center">
                            <div class="text-2xl font-bold text-orange-600 mb-2" id="interetsResult">-</div>
                            <div class="text-sm text-orange-700">Intérêts totaux</div>
                        </div>
                    </div>

                    <div class="bg-gray-50 rounded-lg p-4">
                        <h4 class="text-sm font-medium text-gray-800 mb-3">Détails du Prêt</h4>
                        <div class="grid grid-cols-2 gap-4 text-sm">
                            <div>
                                <span class="text-gray-600">Capital emprunté:</span>
                                <span class="font-medium" id="capitalDetail">-</span>
                            </div>
                            <div>
                                <span class="text-gray-600">Durée:</span>
                                <span class="font-medium" id="dureeDetail">-</span>
                            </div>
                            <div>
                                <span class="text-gray-600">Taux annuel:</span>
                                <span class="font-medium">3.50%</span>
                            </div>
                            <div>
                                <span class="text-gray-600">Taux mensuel:</span>
                                <span class="font-medium">0.29%</span>
                            </div>
                        </div>
                    </div>

                    <div class="mt-6 flex justify-center">
                        <a href="${pageContext.request.contextPath}/pret/nouveau" 
                           class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md text-white bg-green-600 hover:bg-green-700">
                            <i class="fas fa-plus mr-2"></i>Créer ce Prêt
                        </a>
                    </div>
                </div>
            </div>

            <!-- Informations sur les taux -->
            <div class="mt-8 bg-yellow-50 border border-yellow-200 rounded-lg p-4">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="fas fa-info-circle text-yellow-400 text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <h3 class="text-sm font-medium text-yellow-800">Informations sur les Taux</h3>
                        <div class="mt-2 text-sm text-yellow-700">
                            <ul class="list-disc list-inside space-y-1">
                                <li>Taux indicatif utilisé: 3.50% annuel</li>
                                <li>Le taux réel peut varier selon votre profil client</li>
                                <li>Cette simulation est donnée à titre informatif</li>
                                <li>Les conditions définitives seront précisées lors de la demande</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Variables globales
        const TAUX_ANNUEL = 0.035; // 3.5% annuel
        const TAUX_MENSUEL = TAUX_ANNUEL / 12;
        
        // Fonction pour calculer la simulation
        function calculateSimulation() {
            const montant = parseFloat(document.getElementById('montant').value);
            const duree = parseInt(document.getElementById('duree').value);
            const resultatsDiv = document.getElementById('resultatsSimulation');
            
            if (montant && duree && montant >= 100) {
                // Calcul de la mensualité avec la formule des annuités
                const mensualite = (montant * TAUX_MENSUEL * Math.pow(1 + TAUX_MENSUEL, duree)) / 
                                  (Math.pow(1 + TAUX_MENSUEL, duree) - 1);
                const totalRembourse = mensualite * duree;
                const interetsTotal = totalRembourse - montant;
                
                // Affichage des résultats
                document.getElementById('mensualiteResult').textContent = formatCurrency(mensualite);
                document.getElementById('totalResult').textContent = formatCurrency(totalRembourse);
                document.getElementById('interetsResult').textContent = formatCurrency(interetsTotal);
                
                // Détails
                document.getElementById('capitalDetail').textContent = formatCurrency(montant);
                document.getElementById('dureeDetail').textContent = duree + ' mois (' + Math.round(duree/12*10)/10 + ' ans)';
                
                resultatsDiv.classList.remove('hidden');
                
                // Scroll vers les résultats
                resultatsDiv.scrollIntoView({ behavior: 'smooth', block: 'start' });
            } else {
                resultatsDiv.classList.add('hidden');
                
                if (montant && montant <= 0) {
                    alert('Veuillez saisir un montant valide');
                }
            }
        }
        
        // Fonction pour formater les montants en euros
        function formatCurrency(amount) {
            return new Intl.NumberFormat('fr-FR', {
                style: 'currency',
                currency: 'EUR'
            }).format(amount);
        }
        
        // Calcul automatique au chargement si des paramètres sont présents
        document.addEventListener('DOMContentLoaded', function() {
            const montant = document.getElementById('montant').value;
            const duree = document.getElementById('duree').value;
            
            if (montant && duree) {
                calculateSimulation();
            }
            
            document.getElementById('montant').focus();
        });
        
        // Validation du formulaire
        document.getElementById('simulationForm').addEventListener('submit', function(e) {
            e.preventDefault();
            calculateSimulation();
        });
    </script>
</body>
</html>
