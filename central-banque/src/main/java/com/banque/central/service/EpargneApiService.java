package com.banque.central.service;

import com.banque.central.config.ApiConfig;
import com.banque.central.dto.EpargneDTO;
import com.banque.central.dto.RetraitEpargneDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import jakarta.enterprise.context.ApplicationScoped;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

@ApplicationScoped
public class EpargneApiService {
    
    private static final Logger LOGGER = Logger.getLogger(EpargneApiService.class.getName());
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper;
    
    public EpargneApiService() {
        this.httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofMillis(ApiConfig.CONNECTION_TIMEOUT))
                .build();
        this.objectMapper = new ObjectMapper();
        this.objectMapper.registerModule(new JavaTimeModule());
    }
    
    // ===== GESTION DES DÉPÔTS D'ÉPARGNE =====
    
    public EpargneDTO creerDepotEpargne(Long idCompte, BigDecimal montant) throws Exception {
        try {
            String requestBody = String.format("{\"idCompte\":%d,\"montant\":%s}", idCompte, montant.toString());
            
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.EPARGNE_API_BASE_URL + "/depots"))
                    .header("Content-Type", ApiConfig.CONTENT_TYPE_JSON)
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 201) {
                return objectMapper.readValue(response.body(), EpargneDTO.class);
            } else {
                LOGGER.warning("Erreur lors de la création du dépôt d'épargne: " + response.statusCode() + " - " + response.body());
                throw new Exception("Erreur lors de la création du dépôt d'épargne: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API épargne: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    public EpargneDTO obtenirDepotEpargne(Long idDepot) throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.EPARGNE_API_BASE_URL + "/depots/" + idDepot))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                return objectMapper.readValue(response.body(), EpargneDTO.class);
            } else if (response.statusCode() == 404) {
                return null;
            } else {
                LOGGER.warning("Erreur lors de la récupération du dépôt d'épargne: " + response.statusCode());
                throw new Exception("Erreur lors de la récupération du dépôt d'épargne");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API épargne: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    public List<EpargneDTO> obtenirDepotsParCompte(Long idCompte) throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.EPARGNE_API_BASE_URL + "/comptes/" + idCompte + "/depots"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                EpargneDTO[] depots = objectMapper.readValue(response.body(), EpargneDTO[].class);
                return Arrays.asList(depots);
            } else {
                LOGGER.warning("Erreur lors de la récupération des dépôts d'épargne: " + response.statusCode());
                throw new Exception("Erreur lors de la récupération des dépôts d'épargne");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API épargne: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    // ===== GESTION DES RETRAITS D'ÉPARGNE =====
    
    public RetraitEpargneDTO creerRetraitEpargne(Long idDepot, BigDecimal montant) throws Exception {
        try {
            String requestBody = String.format("{\"idDepot\":%d,\"montant\":%s}", idDepot, montant.toString());
            
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.EPARGNE_API_BASE_URL + "/retraits"))
                    .header("Content-Type", ApiConfig.CONTENT_TYPE_JSON)
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 201) {
                return objectMapper.readValue(response.body(), RetraitEpargneDTO.class);
            } else {
                LOGGER.warning("Erreur lors de la création du retrait d'épargne: " + response.statusCode() + " - " + response.body());
                throw new Exception("Erreur lors de la création du retrait d'épargne: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API épargne: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    // ===== CALCULS ET STATISTIQUES =====
    
    public BigDecimal obtenirSoldeEpargne(Long idCompte) throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.EPARGNE_API_BASE_URL + "/comptes/" + idCompte + "/solde"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                // La réponse contient un objet avec idCompte et solde
                String jsonResponse = response.body();
                // Parser pour extraire le solde
                ObjectMapper mapper = new ObjectMapper();
                var jsonNode = mapper.readTree(jsonResponse);
                return new BigDecimal(jsonNode.get("solde").asText());
            } else {
                LOGGER.warning("Erreur lors de la récupération du solde épargne: " + response.statusCode());
                return BigDecimal.ZERO;
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API épargne: " + e.getMessage());
            return BigDecimal.ZERO;
        }
    }
    
    public String obtenirStatistiquesEpargne(Long idCompte) throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.EPARGNE_API_BASE_URL + "/comptes/" + idCompte + "/statistiques"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                return response.body();
            } else {
                LOGGER.warning("Erreur lors de la récupération des statistiques épargne: " + response.statusCode());
                throw new Exception("Erreur lors de la récupération des statistiques épargne");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API épargne: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    // ===== VÉRIFICATION DE SANTÉ =====
    
    public boolean verifierSanteApi() {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.EPARGNE_API_BASE_URL + "/health"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(3000)) // Timeout court pour la vérification
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return response.statusCode() == 200;
        } catch (Exception e) {
            LOGGER.warning("API épargne indisponible: " + e.getMessage());
            return false;
        }
    }
}
