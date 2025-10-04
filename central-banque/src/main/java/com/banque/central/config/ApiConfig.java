package com.banque.central.config;

public class ApiConfig {
    
    // URLs des APIs C#
    public static final String EPARGNE_API_BASE_URL = "https://localhost:5001/api/Epargne";
    public static final String PRET_API_BASE_URL = "http://localhost:5002/api/Pret";
    
    // Timeouts
    public static final int CONNECTION_TIMEOUT = 5000; // 5 secondes
    public static final int READ_TIMEOUT = 10000; // 10 secondes
    
    // Headers
    public static final String CONTENT_TYPE_JSON = "application/json";
    public static final String ACCEPT_JSON = "application/json";
    
    // Messages d'erreur
    public static final String ERROR_API_UNAVAILABLE = "Service temporairement indisponible";
    public static final String ERROR_INVALID_RESPONSE = "Réponse invalide du service";
    public static final String ERROR_NETWORK = "Erreur de communication réseau";
    
    private ApiConfig() {
        // Classe utilitaire - constructeur privé
    }
}
