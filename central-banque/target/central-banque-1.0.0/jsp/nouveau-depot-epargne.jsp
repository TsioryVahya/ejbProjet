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
    <div class="max-w-4xl mx-auto py-6 sm:px-6 lg:px-8">
        <div class="px-4 py-6 sm:px-0">
            <!-- En-tête -->
            <div class="mb-6">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center">
                        <a href="${pageContext.request.contextPath}/epargne/list" class="text-blue-600 hover:text-blue-800 mr-4">
                            <i class="fas fa-arrow-left"></i> Retour à l'épargne
                        </a>
                        <h1 class="text-3xl font-bold text-gray-900">Nouveau Dépôt d'Épargne</h1>
                    </div>
                </div>
                <p class="text-gray-600">Créez un nouveau dépôt d'épargne pour commencer à faire fructifier vos économies.</p>
            </div>

            <!-- Messages -->
            <c:if test="${not empty erreur}">
                <div class="mb-4 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative" role="alert">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <span class="block sm:inline">${erreur}</span>
                </div>
            </c:if>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Formulaire principal -->
                <div class="lg:col-span-2">
                    <div class="bg-white shadow rounded-lg overflow-hidden">
                        <div class="px-6 py-4 bg-gradient-to-r from-green-600 to-green-700">
                            <h3 class="text-lg font-medium text-white">
                                <i class="fas fa-plus-circle mr-2"></i>Informations du Dépôt
                            </h3>
                        </div>
                        <form action="${pageContext.request.contextPath}/epargne/creer-depot" method="post" id="depotForm">
                            <div class="px-6 py-4 space-y-6">
                                <!-- Sélection du compte -->
                                <div>
                                    <label for="idCompte" class="block text-sm font-medium text-gray-700 mb-2">
                                        <i class="fas fa-credit-card mr-1"></i>Compte d'épargne *
                                    </label>
                                    <select id="idCompte" name="idCompte" required 
                                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-green-500 focus:border-green-500">
                                        <option value="">Sélectionnez un compte</option>
                                        <c:forEach var="compte" items="${comptes}">
                                            <option value="${compte.idCompte}" 
                                                    data-solde="${compte.solde}"
                                                    data-client="${compte.prenomClient} ${compte.nomClient}">
                                                ${compte.numeroCompte} - ${compte.prenomClient} ${compte.nomClient}
                                                (Solde: <fmt:formatNumber value="${compte.solde}" type="currency" currencySymbol="€"/>)
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <p class="mt-1 text-sm text-gray-500">Choisissez le compte depuis lequel effectuer le dépôt d'épargne</p>
                                </div>

                                <!-- Montant du dépôt -->
                                <div>
                                    <label for="montant" class="block text-sm font-medium text-gray-700 mb-2">
                                        <i class="fas fa-euro-sign mr-1"></i>Montant du dépôt *
                                    </label>
                                    <div class="relative">
                                        <input type="number" id="montant" name="montant" step="0.01" min="1" required
                                               class="w-full pl-8 pr-4 py-2 border border-gray-300 rounded-md focus:ring-green-500 focus:border-green-500"
                                               placeholder="0.00">
                                        <span class="absolute left-3 top-2 text-gray-500">€</span>
                                    </div>
                                    <p class="mt-1 text-sm text-gray-500">Montant minimum: 1€</p>
                                </div>

                                <!-- Durée du dépôt -->
                                <div>
                                    <label for="duree" class="block text-sm font-medium text-gray-700 mb-2">
                                        <i class="fas fa-calendar-alt mr-1"></i>Durée du dépôt (en mois) *
                                    </label>
                                    <select id="duree" name="duree" required 
                                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-green-500 focus:border-green-500">
                                        <option value="">Sélectionnez une durée</option>
                                        <option value="3">3 mois</option>
                                        <option value="6">6 mois</option>
                                        <option value="12">12 mois (1 an)</option>
                                        <option value="24">24 mois (2 ans)</option>
                                        <option value="36">36 mois (3 ans)</option>
                                        <option value="60">60 mois (5 ans)</option>
                                    </select>
                                    <p class="mt-1 text-sm text-gray-500">Plus la durée est longue, plus les intérêts sont avantageux</p>
                                </div>

                                <!-- Taux d'épargne -->
                                <div>
                                    <label for="idTaux" class="block text-sm font-medium text-gray-700 mb-2">
                                        <i class="fas fa-percentage mr-1"></i>Taux d'épargne
                                    </label>
                                    <select id="idTaux" name="idTaux" 
                                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-green-500 focus:border-green-500">
                                        <option value="">Taux automatique (recommandé)</option>
                                        <c:forEach var="taux" items="${tauxDisponibles}">
                                            <option value="${taux.idTaux}" data-pourcentage="${taux.pourcentage}">
                                                <fmt:formatNumber value="${taux.pourcentage}" pattern="#0.00"/>% 
                                                <c:if test="${not empty taux.description}">- ${taux.description}</c:if>
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <p class="mt-1 text-sm text-gray-500">Laissez vide pour utiliser le taux le plus avantageux</p>
                                </div>

                                <!-- Boutons de montant rapide -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Montants suggérés</label>
                                    <div class="grid grid-cols-2 md:grid-cols-4 gap-2">
                                        <button type="button" onclick="setMontant(100)" 
                                                class="px-3 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                            100€
                                        </button>
                                        <button type="button" onclick="setMontant(500)" 
                                                class="px-3 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                            500€
                                        </button>
                                        <button type="button" onclick="setMontant(1000)" 
                                                class="px-3 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                            1 000€
                                        </button>
                                        <button type="button" onclick="setMontant(5000)" 
                                                class="px-3 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                            5 000€
                                        </button>
                                    </div>
                                </div>

                                <!-- Boutons d'action -->
                                <div class="flex justify-end space-x-3 pt-6 border-t border-gray-200">
                                    <a href="${pageContext.request.contextPath}/epargne/list" 
                                       class="px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                                        <i class="fas fa-times mr-2"></i>Annuler
                                    </a>
                                    <button type="submit" id="submitBtn"
                                            class="px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500">
                                        <i class="fas fa-plus-circle mr-2"></i>Créer le Dépôt
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Sidebar informative -->
                <div class="lg:col-span-1">
                    <!-- Aperçu du dépôt -->
                    <div class="bg-white shadow rounded-lg overflow-hidden mb-6" id="apercuDepot" style="display: none;">
                        <div class="px-6 py-4 bg-gradient-to-r from-blue-600 to-blue-700">
                            <h3 class="text-lg font-medium text-white">
                                <i class="fas fa-eye mr-2"></i>Aperçu du Dépôt
                            </h3>
                        </div>
                        <div class="px-6 py-4">
                            <div class="space-y-3">
                                <div class="flex justify-between">
                                    <span class="text-sm text-gray-600">Compte:</span>
                                    <span class="text-sm font-semibold text-gray-900" id="apercuCompte">-</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-sm text-gray-600">Client:</span>
                                    <span class="text-sm font-semibold text-gray-900" id="apercuClient">-</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-sm text-gray-600">Montant:</span>
                                    <span class="text-sm font-semibold text-green-600" id="apercuMontant">0,00€</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-sm text-gray-600">Durée:</span>
                                    <span class="text-sm font-semibold text-gray-900" id="apercuDuree">-</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-sm text-gray-600">Taux:</span>
                                    <span class="text-sm font-semibold text-blue-600" id="apercuTaux">-</span>
                                </div>
                                <div class="flex justify-between border-t pt-2 mt-2">
                                    <span class="text-sm text-gray-600">Gains estimés:</span>
                                    <span class="text-sm font-semibold text-green-600" id="apercuGains">-</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Informations sur l'épargne -->
                    <div class="bg-white shadow rounded-lg overflow-hidden mb-6">
                        <div class="px-6 py-4 bg-gradient-to-r from-purple-600 to-purple-700">
                            <h3 class="text-lg font-medium text-white">
                                <i class="fas fa-info-circle mr-2"></i>Informations Importantes
                            </h3>
                        </div>
                        <div class="px-6 py-4">
                            <div class="space-y-4">
                                <div class="bg-green-50 p-3 rounded-lg">
                                    <h4 class="font-medium text-green-900 mb-1">
                                        <i class="fas fa-percentage mr-1"></i>Taux d'Intérêt
                                    </h4>
                                    <p class="text-sm text-green-800">
                                        Taux actuel: 
                                        <c:choose>
                                            <c:when test="${not empty tauxActuel}">
                                                <strong><fmt:formatNumber value="${tauxActuel.pourcentage}" pattern="#0.00"/>%</strong> par an
                                            </c:when>
                                            <c:otherwise>
                                                <strong>Non disponible</strong>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                <div class="bg-blue-50 p-3 rounded-lg">
                                    <h4 class="font-medium text-blue-900 mb-1">
                                        <i class="fas fa-clock mr-1"></i>Disponibilité
                                    </h4>
                                    <p class="text-sm text-blue-800">
                                        Vos fonds restent disponibles et vous pouvez effectuer des retraits à tout moment.
                                    </p>
                                </div>
                                <div class="bg-yellow-50 p-3 rounded-lg">
                                    <h4 class="font-medium text-yellow-900 mb-1">
                                        <i class="fas fa-calculator mr-1"></i>Calcul des Intérêts
                                    </h4>
                                    <p class="text-sm text-yellow-800">
                                        Les intérêts sont calculés automatiquement selon la durée de placement.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Conseils -->
                    <div class="bg-white shadow rounded-lg overflow-hidden">
                        <div class="px-6 py-4 bg-gradient-to-r from-indigo-600 to-indigo-700">
                            <h3 class="text-lg font-medium text-white">
                                <i class="fas fa-lightbulb mr-2"></i>Conseils
                            </h3>
                        </div>
                        <div class="px-6 py-4">
                            <ul class="space-y-2 text-sm text-gray-600">
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-green-500 mr-2 mt-0.5"></i>
                                    Diversifiez vos placements pour optimiser vos rendements
                                </li>
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-green-500 mr-2 mt-0.5"></i>
                                    Gardez une réserve de liquidités pour les urgences
                                </li>
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-green-500 mr-2 mt-0.5"></i>
                                    Consultez régulièrement vos gains d'intérêts
                                </li>
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
        let compteSelectionne = null;
        
        // Fonction pour définir un montant rapide
        function setMontant(montant) {
            document.getElementById('montant').value = montant;
            mettreAJourApercu();
        }
        
        // Fonction pour mettre à jour l'aperçu
        function mettreAJourApercu() {
            const compteSelect = document.getElementById('idCompte');
            const montantInput = document.getElementById('montant');
            const dureeSelect = document.getElementById('duree');
            const tauxSelect = document.getElementById('idTaux');
            const apercu = document.getElementById('apercuDepot');
            
            if (compteSelect.value && montantInput.value && dureeSelect.value) {
                const selectedOption = compteSelect.options[compteSelect.selectedIndex];
                const client = selectedOption.getAttribute('data-client');
                const montant = parseFloat(montantInput.value);
                const duree = parseInt(dureeSelect.value);
                
                // Informations de base
                document.getElementById('apercuCompte').textContent = selectedOption.text.split(' - ')[0];
                document.getElementById('apercuClient').textContent = client;
                document.getElementById('apercuMontant').textContent = montant.toLocaleString('fr-FR', {
                    style: 'currency',
                    currency: 'EUR'
                });
                
                // Durée
                const dureeText = duree + ' mois' + (duree >= 12 ? ' (' + Math.floor(duree/12) + ' an' + (duree >= 24 ? 's' : '') + ')' : '');
                document.getElementById('apercuDuree').textContent = dureeText;
                
                // Taux
                let tauxPourcentage = 0;
                let tauxText = 'Taux automatique';
                if (tauxSelect.value) {
                    const selectedTaux = tauxSelect.options[tauxSelect.selectedIndex];
                    tauxPourcentage = parseFloat(selectedTaux.getAttribute('data-pourcentage'));
                    tauxText = tauxPourcentage.toFixed(2) + '%';
                } else {
                    // Utiliser le premier taux disponible comme estimation
                    if (tauxSelect.options.length > 1) {
                        tauxPourcentage = parseFloat(tauxSelect.options[1].getAttribute('data-pourcentage'));
                        tauxText = tauxPourcentage.toFixed(2) + '% (estimé)';
                    }
                }
                document.getElementById('apercuTaux').textContent = tauxText;
                
                // Calcul des gains estimés
                if (tauxPourcentage > 0) {
                    const gainsAnnuels = montant * (tauxPourcentage / 100);
                    const gainsTotal = gainsAnnuels * (duree / 12);
                    document.getElementById('apercuGains').textContent = gainsTotal.toLocaleString('fr-FR', {
                        style: 'currency',
                        currency: 'EUR'
                    });
                } else {
                    document.getElementById('apercuGains').textContent = 'À calculer';
                }
                
                apercu.style.display = 'block';
            } else {
                apercu.style.display = 'none';
            }
        }
        
        // Validation du formulaire
        function validerFormulaire() {
            const compte = document.getElementById('idCompte').value;
            const montant = parseFloat(document.getElementById('montant').value);
            const duree = parseInt(document.getElementById('duree').value);
            
            if (!compte) {
                alert('Veuillez sélectionner un compte.');
                return false;
            }
            
            if (!montant || montant < 1) {
                alert('Veuillez saisir un montant valide (minimum 1€).');
                return false;
            }
            
            if (!duree || duree < 1) {
                alert('Veuillez sélectionner une durée.');
                return false;
            }
            
            // Vérifier le solde disponible
            const selectedOption = document.getElementById('idCompte').options[document.getElementById('idCompte').selectedIndex];
            const soldeDisponible = parseFloat(selectedOption.getAttribute('data-solde'));
            
            if (montant > soldeDisponible) {
                alert('Le montant du dépôt ne peut pas dépasser le solde disponible (' + 
                      soldeDisponible.toLocaleString('fr-FR', {style: 'currency', currency: 'EUR'}) + ').');
                return false;
            }
            
            return confirm('Confirmez-vous la création de ce dépôt d\'épargne de ' + 
                          montant.toLocaleString('fr-FR', {style: 'currency', currency: 'EUR'}) + ' ?');
        }
        
        // Événements
        document.getElementById('idCompte').addEventListener('change', mettreAJourApercu);
        document.getElementById('montant').addEventListener('input', mettreAJourApercu);
        document.getElementById('duree').addEventListener('change', mettreAJourApercu);
        document.getElementById('idTaux').addEventListener('change', mettreAJourApercu);
        
        document.getElementById('depotForm').addEventListener('submit', function(e) {
            if (!validerFormulaire()) {
                e.preventDefault();
            }
        });
        
        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            mettreAJourApercu();
        });
    </script>
</body>
</html>
