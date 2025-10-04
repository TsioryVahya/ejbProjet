<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau Prêt - Système Bancaire</title>
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
                    <h1 class="text-3xl font-bold text-gray-900">Créer un Nouveau Prêt</h1>
                    <p class="text-gray-600 mt-2">Remplissez les informations pour créer un nouveau prêt bancaire</p>
                </div>
                <div class="flex space-x-3">
                    <a href="${pageContext.request.contextPath}/pret/list" 
                       class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                        <i class="fas fa-arrow-left mr-2"></i>Retour à la liste
                    </a>
                    <a href="${pageContext.request.contextPath}/pret/simulation" 
                       class="inline-flex items-center px-4 py-2 border border-blue-300 text-sm font-medium rounded-md text-blue-700 bg-blue-50 hover:bg-blue-100">
                        <i class="fas fa-calculator mr-2"></i>Simuler un Prêt
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

            <!-- Formulaire de création -->
            <div class="bg-white shadow rounded-lg">
                <div class="px-4 py-5 sm:p-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900 mb-6">
                        <i class="fas fa-hand-holding-usd mr-2 text-green-600"></i>Informations du Prêt
                    </h3>

                    <form action="${pageContext.request.contextPath}/pret/creer" method="post" class="space-y-6" id="pretForm">
                        <!-- Sélection du compte -->
                        <div>
                            <label for="idCompte" class="block text-sm font-medium text-gray-700 mb-2">
                                <i class="fas fa-credit-card mr-1"></i>Compte Bénéficiaire *
                            </label>
                            <select id="idCompte" 
                                    name="idCompte" 
                                    required 
                                    onchange="updateCompteInfo()"
                                    class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
                                <option value="">Sélectionner un compte</option>
                                <c:forEach var="compte" items="${comptes}">
                                    <option value="${compte.idCompte}" 
                                            data-numero="${compte.numeroCompte}"
                                            data-client="${compte.client.nom} ${compte.client.prenom}"
                                            data-solde="0.00"
                                            data-type="${compte.typeCompte.nomTypeCompte}">
                                        ${compte.numeroCompte} - ${compte.client.nom} ${compte.client.prenom}
                                    </option>
                                </c:forEach>
                            </select>
                            <c:if test="${empty comptes}">
                                <p class="mt-1 text-xs text-red-500">Aucun compte disponible. Veuillez d'abord créer un compte.</p>
                            </c:if>
                        </div>

                        <!-- Informations du compte sélectionné -->
                        <div id="compteInfo" class="hidden bg-blue-50 border border-blue-200 rounded-lg p-4">
                            <h4 class="text-sm font-medium text-blue-800 mb-2">
                                <i class="fas fa-info-circle mr-1"></i>Informations du Compte
                            </h4>
                            <div class="grid grid-cols-2 gap-4 text-sm">
                                <div>
                                    <span class="text-blue-600 font-medium">Client:</span>
                                    <span id="clientInfo" class="text-blue-800"></span>
                                </div>
                                <div>
                                    <span class="text-blue-600 font-medium">Type:</span>
                                    <span id="typeInfo" class="text-blue-800"></span>
                                </div>
                                <div>
                                    <span class="text-blue-600 font-medium">Solde actuel:</span>
                                    <span id="soldeInfo" class="text-blue-800 font-semibold"></span>
                                </div>
                                <div>
                                    <span class="text-blue-600 font-medium">Numéro:</span>
                                    <span id="numeroInfo" class="text-blue-800"></span>
                                </div>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
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
                                       placeholder="Ex: 10000.00"
                                       onchange="calculateEstimation()"
                                       class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
                                <p class="mt-1 text-xs text-gray-500">Maximum: 500 000€</p>
                            </div>

                            <!-- Durée du prêt -->
                            <div>
                                <label for="duree" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-calendar-alt mr-1"></i>Durée (en mois) *
                                </label>
                                <select id="duree" 
                                        name="duree" 
                                        required 
                                        onchange="calculateEstimation()"
                                        class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
                                    <option value="">Sélectionner la durée</option>
                                    <option value="12">12 mois (1 an)</option>
                                    <option value="24">24 mois (2 ans)</option>
                                    <option value="36">36 mois (3 ans)</option>
                                    <option value="48">48 mois (4 ans)</option>
                                    <option value="60">60 mois (5 ans)</option>
                                    <option value="84">84 mois (7 ans)</option>
                                    <option value="120">120 mois (10 ans)</option>
                                    <option value="180">180 mois (15 ans)</option>
                                    <option value="240">240 mois (20 ans)</option>
                                    <option value="300">300 mois (25 ans)</option>
                                </select>
                                <p class="mt-1 text-xs text-gray-500">Durée de remboursement du prêt</p>
                            </div>

                            <!-- Taux d'intérêt -->
                            <div>
                                <label for="idTaux" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-percentage mr-1"></i>Taux d'Intérêt *
                                </label>
                                <c:choose>
                                    <c:when test="${apiTauxDisponible}">
                                        <select id="idTaux" 
                                                name="idTaux" 
                                                required 
                                                onchange="calculateEstimation()"
                                                class="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500">
                                            <option value="">Sélectionner un taux</option>
                                            <!-- Les taux seront chargés via JavaScript -->
                                        </select>
                                        <p class="mt-1 text-xs text-gray-500">Taux d'intérêt annuel applicable</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="bg-yellow-50 border border-yellow-200 rounded-md p-3">
                                            <div class="flex">
                                                <i class="fas fa-exclamation-triangle text-yellow-400 mr-2 mt-0.5"></i>
                                                <div class="text-sm text-yellow-700">
                                                    <p class="font-medium">Service de taux indisponible</p>
                                                    <p>Le taux par défaut (3.5%) sera appliqué</p>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="idTaux" value="">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Estimation des mensualités -->
                        <div id="estimation" class="hidden bg-green-50 border border-green-200 rounded-lg p-4">
                            <h4 class="text-sm font-medium text-green-800 mb-3">
                                <i class="fas fa-calculator mr-1"></i>Estimation des Mensualités
                            </h4>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm">
                                <div class="text-center">
                                    <div class="text-2xl font-bold text-green-600" id="mensualiteEstimee">-</div>
                                    <div class="text-green-700">Mensualité estimée</div>
                                </div>
                                <div class="text-center">
                                    <div class="text-lg font-semibold text-green-600" id="totalEstime">-</div>
                                    <div class="text-green-700">Total à rembourser</div>
                                </div>
                                <div class="text-center">
                                    <div class="text-lg font-semibold text-green-600" id="interetsEstimes">-</div>
                                    <div class="text-green-700">Intérêts totaux</div>
                                </div>
                            </div>
                            <p class="mt-2 text-xs text-green-600">
                                <i class="fas fa-info-circle mr-1"></i>
                                Estimation basée sur un taux indicatif de 3.5% annuel. Le taux réel sera déterminé lors de la validation.
                            </p>
                        </div>

                        <!-- Conditions et informations -->
                        <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-4">
                            <h4 class="text-sm font-medium text-yellow-800 mb-2">
                                <i class="fas fa-exclamation-triangle mr-1"></i>Conditions d'Octroi
                            </h4>
                            <ul class="text-sm text-yellow-700 space-y-1">
                                <li>• Le compte doit être actif et en règle</li>
                                <li>• Aucun montant minimum requis</li>
                                <li>• La capacité de remboursement sera évaluée</li>
                                <li>• Le taux d'intérêt sera déterminé selon le profil client</li>
                                <li>• Un échéancier détaillé sera fourni après validation</li>
                            </ul>
                        </div>

                        <!-- Boutons d'action -->
                        <div class="flex justify-end space-x-3 pt-6 border-t border-gray-200">
                            <a href="${pageContext.request.contextPath}/pret/list" 
                               class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                <i class="fas fa-times mr-2"></i>Annuler
                            </a>
                            <button type="button" 
                                    onclick="simulateBeforeCreate()"
                                    class="inline-flex items-center px-4 py-2 border border-blue-300 text-sm font-medium rounded-md text-blue-700 bg-blue-50 hover:bg-blue-100">
                                <i class="fas fa-calculator mr-2"></i>Simuler d'abord
                            </button>
                            <button type="submit" 
                                    class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                <i class="fas fa-plus mr-2"></i>Créer le Prêt
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Informations supplémentaires -->
            <div class="mt-8 bg-blue-50 border border-blue-200 rounded-lg p-4">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="fas fa-info-circle text-blue-400 text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <h3 class="text-sm font-medium text-blue-800">Informations importantes</h3>
                        <div class="mt-2 text-sm text-blue-700">
                            <ul class="list-disc list-inside space-y-1">
                                <li>Le prêt sera automatiquement associé au compte sélectionné</li>
                                <li>Les fonds seront versés sur le compte après validation</li>
                                <li>Un échéancier de remboursement sera généré automatiquement</li>
                                <li>Vous pourrez effectuer des remboursements anticipés à tout moment</li>
                                <li>Les intérêts sont calculés selon les taux en vigueur</li>
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
        const TAUX_INDICATIF = 0.035; // 3.5% annuel par défaut
        let tauxDisponibles = [];
        let tauxActuel = TAUX_INDICATIF;
        
        // Charger les taux depuis l'API au chargement de la page
        document.addEventListener('DOMContentLoaded', function() {
            console.log('=== DEBUT CHARGEMENT TAUX ===');
            
            // Toujours essayer de charger les taux
            const selectTaux = document.getElementById('idTaux');
            console.log('Element select taux trouvé:', selectTaux);
            
            if (selectTaux) {
                console.log('Lancement du chargement des taux...');
                chargerTauxDepuisServeur();
            } else {
                console.log('Pas de sélecteur de taux trouvé - API probablement indisponible');
            }
            
            const idCompteElement = document.getElementById('idCompte');
            if (idCompteElement) {
                idCompteElement.focus();
            }
        });
        
        // Fonction pour charger les taux depuis le serveur
        function chargerTauxDepuisServeur() {
            const selectTaux = document.getElementById('idTaux');
            if (!selectTaux) {
                console.log('Élément select taux non trouvé');
                return;
            }
            
            const url = '${pageContext.request.contextPath}/pret/api?action=taux';
            console.log('Chargement des taux depuis:', url);
            
            // Faire un appel AJAX pour récupérer les taux
            fetch(url)
                .then(response => {
                    console.log('=== REPONSE RECUE ===');
                    console.log('Status:', response.status);
                    console.log('Status Text:', response.statusText);
                    console.log('Headers:', response.headers);
                    console.log('OK:', response.ok);
                    
                    if (!response.ok) {
                        throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                    }
                    
                    return response.text(); // D'abord en text pour voir le contenu brut
                })
                .then(textData => {
                    console.log('=== DONNEES BRUTES ===');
                    console.log('Contenu brut:', textData);
                    
                    let tauxData;
                    try {
                        tauxData = JSON.parse(textData);
                        console.log('=== DONNEES PARSEES ===');
                        console.log('Données taux parsées:', tauxData);
                    } catch (e) {
                        console.error('Erreur de parsing JSON:', e);
                        throw new Error('Réponse invalide du serveur: ' + textData);
                    }
                    
                    return tauxData;
                })
                .then(tauxData => {
                    console.log('=== TRAITEMENT DES TAUX ===');
                    if (tauxData && Array.isArray(tauxData)) {
                        console.log('Traitement de', tauxData.length, 'taux');
                        tauxDisponibles = tauxData;
                        
                        // Vider les options existantes sauf la première
                        selectTaux.innerHTML = '<option value="">Sélectionner un taux</option>';
                        
                        // Ajouter les taux disponibles
                        tauxData.forEach((taux, index) => {
                            console.log('Ajout du taux', index, ':', taux);
                            const option = document.createElement('option');
                            option.value = taux.idTaux;
                            option.textContent = taux.pourcentage + '% - Standard';
                            option.dataset.taux = taux.pourcentage;
                            selectTaux.appendChild(option);
                        });
                        
                        // Sélectionner le premier taux par défaut
                        if (tauxData.length > 0) {
                            const premierTaux = tauxData[0];
                            selectTaux.value = premierTaux.idTaux;
                            tauxActuel = premierTaux.pourcentage / 100;
                            console.log('Taux par défaut sélectionné:', premierTaux.pourcentage + '%');
                        }
                    } else if (tauxData && tauxData.error) {
                        console.error('Erreur du serveur:', tauxData.error, tauxData.message);
                        afficherErreurTaux(tauxData.message || 'Service de taux indisponible');
                    } else {
                        console.warn('Format de données inattendu:', tauxData);
                        afficherErreurTaux('Format de données invalide reçu du serveur');
                    }
                })
                .catch(e => {
                    console.error('Erreur lors du chargement des taux:', e);
                    afficherErreurTaux('Impossible de contacter le serveur pour récupérer les taux');
                });
        }
        
        // Fonction pour afficher une erreur de taux
        function afficherErreurTaux(message) {
            const selectTaux = document.getElementById('idTaux');
            if (!selectTaux) return;
            
            console.error('Erreur taux:', message);
            
            // Désactiver le select et afficher l'erreur
            selectTaux.disabled = true;
            selectTaux.innerHTML = '<option value="">Erreur: Taux indisponibles</option>';
            
            // Afficher un message d'erreur visible
            const container = selectTaux.parentElement;
            let errorDiv = container.querySelector('.error-taux');
            if (!errorDiv) {
                errorDiv = document.createElement('div');
                errorDiv.className = 'error-taux mt-2 p-3 bg-red-50 border border-red-200 rounded-md';
                container.appendChild(errorDiv);
            }
            
            errorDiv.innerHTML = 
                '<div class="flex items-center">' +
                    '<i class="fas fa-exclamation-circle text-red-500 mr-2"></i>' +
                    '<div class="text-sm text-red-700">' +
                        '<p class="font-medium">Impossible de charger les taux d\'intérêt</p>' +
                        '<p>' + message + '</p>' +
                        '<p class="mt-1">Veuillez vérifier que l\'API Prêt est démarrée et que la base de données contient des taux.</p>' +
                    '</div>' +
                '</div>';
            
            // Désactiver le bouton de soumission
            const submitBtn = document.querySelector('button[type="submit"]');
            if (submitBtn) {
                submitBtn.disabled = true;
                submitBtn.textContent = 'Taux indisponibles - Création impossible';
                submitBtn.className = submitBtn.className.replace('bg-green-600', 'bg-gray-400').replace('hover:bg-green-700', '');
            }
        }
        
        // Fonction pour obtenir le taux sélectionné
        function getTauxSelectionne() {
            const selectTaux = document.getElementById('idTaux');
            if (selectTaux && selectTaux.selectedIndex > 0) {
                const selectedOption = selectTaux.options[selectTaux.selectedIndex];
                return parseFloat(selectedOption.dataset.taux) / 100;
            }
            return TAUX_INDICATIF;
        }
        
        // Fonction pour mettre à jour les informations du compte
        function updateCompteInfo() {
            const select = document.getElementById('idCompte');
            const selectedOption = select.options[select.selectedIndex];
            const infoDiv = document.getElementById('compteInfo');
            
            if (selectedOption.value) {
                document.getElementById('clientInfo').textContent = selectedOption.dataset.client;
                document.getElementById('typeInfo').textContent = selectedOption.dataset.type;
                document.getElementById('soldeInfo').textContent = formatCurrency(selectedOption.dataset.solde);
                document.getElementById('numeroInfo').textContent = selectedOption.dataset.numero;
                
                infoDiv.classList.remove('hidden');
            } else {
                infoDiv.classList.add('hidden');
            }
            
            calculateEstimation();
        }
        
        // Fonction pour calculer l'estimation des mensualités
        function calculateEstimation() {
            const montant = parseFloat(document.getElementById('montant').value);
            const duree = parseInt(document.getElementById('duree').value);
            const estimationDiv = document.getElementById('estimation');
            
            if (montant && duree && montant >= 100) {
                const tauxAnnuel = getTauxSelectionne();
                const tauxMensuel = tauxAnnuel / 12;
                
                let mensualite, totalRembourse, interetsTotal;
                
                if (tauxMensuel > 0) {
                    // Calcul avec intérêts
                    mensualite = (montant * tauxMensuel * Math.pow(1 + tauxMensuel, duree)) / 
                                (Math.pow(1 + tauxMensuel, duree) - 1);
                } else {
                    // Calcul sans intérêts (taux 0%)
                    mensualite = montant / duree;
                }
                
                totalRembourse = mensualite * duree;
                interetsTotal = totalRembourse - montant;
                
                document.getElementById('mensualiteEstimee').textContent = formatCurrency(mensualite);
                document.getElementById('totalEstime').textContent = formatCurrency(totalRembourse);
                document.getElementById('interetsEstimes').textContent = formatCurrency(interetsTotal);
                
                // Mettre à jour l'affichage du taux utilisé
                const tauxPourcentage = (tauxAnnuel * 100).toFixed(2);
                const infoTaux = document.querySelector('.text-xs.text-green-600');
                if (infoTaux) {
                    infoTaux.innerHTML = '<i class="fas fa-info-circle mr-1"></i>' +
                        'Estimation basée sur un taux de ' + tauxPourcentage + '% annuel. Le taux sélectionné sera appliqué lors de la création.';
                }
                
                estimationDiv.classList.remove('hidden');
            } else {
                estimationDiv.classList.add('hidden');
            }
        }
        
        // Fonction pour formater les montants en euros
        function formatCurrency(amount) {
            if (isNaN(amount)) return '0,00 €';
            return new Intl.NumberFormat('fr-FR', {
                style: 'currency',
                currency: 'EUR'
            }).format(amount);
        }
        
        // Fonction pour simuler avant de créer
        function simulateBeforeCreate() {
            const montant = document.getElementById('montant').value;
            const duree = document.getElementById('duree').value;
            
            if (!montant || !duree) {
                alert('Veuillez saisir le montant et la durée pour effectuer une simulation');
                return;
            }
            
            const url = window.location.origin + window.location.pathname.replace('/nouveau', '/simulation') + '?montant=' + montant + '&duree=' + duree;
            window.open(url, '_blank');
        }
        
        // Validation du formulaire
        document.getElementById('pretForm').addEventListener('submit', function(e) {
            const idCompte = document.getElementById('idCompte').value;
            const montant = parseFloat(document.getElementById('montant').value);
            const duree = document.getElementById('duree').value;
            const idTaux = document.getElementById('idTaux') ? document.getElementById('idTaux').value : '';

            if (!idCompte) {
                e.preventDefault();
                alert('Veuillez sélectionner un compte bénéficiaire');
                document.getElementById('idCompte').focus();
                return;
            }

            if (!montant || montant <= 0) {
                e.preventDefault();
                alert('Veuillez saisir un montant valide');
                document.getElementById('montant').focus();
                return;
            }

            if (!duree) {
                e.preventDefault();
                alert('Veuillez sélectionner une durée de remboursement');
                document.getElementById('duree').focus();
                return;
            }

            // Vérifier le taux d'intérêt
            const selectTaux = document.getElementById('idTaux');
            if (selectTaux) {
                if (selectTaux.disabled) {
                    e.preventDefault();
                    alert('Impossible de créer un prêt : les taux d\'intérêt ne sont pas disponibles.\nVeuillez vérifier que l\'API Prêt est démarrée et que la base de données contient des taux.');
                    return;
                }
                if (selectTaux.required && !idTaux) {
                    e.preventDefault();
                    alert('Veuillez sélectionner un taux d\'intérêt');
                    selectTaux.focus();
                    return;
                }
            }

            // Obtenir le taux sélectionné pour l'affichage
            const tauxAnnuel = getTauxSelectionne();
            const tauxPourcentage = (tauxAnnuel * 100).toFixed(2);

            // Confirmation avant création
            const confirmation = confirm(
                'Êtes-vous sûr de vouloir créer ce prêt ?\n\n' +
                'Montant: ' + formatCurrency(montant) + '\n' +
                'Durée: ' + duree + ' mois\n' +
                'Taux: ' + tauxPourcentage + '%\n' +
                'Mensualité estimée: ' + document.getElementById('mensualiteEstimee').textContent
            );

            if (!confirmation) {
                e.preventDefault();
            }
        });

        // Auto-focus sur le premier champ - supprimé car déjà géré plus haut
    </script>
</body>
</html>
