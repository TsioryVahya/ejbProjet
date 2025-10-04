package com.banque.central.service;

import com.banque.central.config.ApiConfig;
import com.banque.central.dto.PretDTO;
import com.banque.central.dto.RemboursementDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import jakarta.enterprise.context.ApplicationScoped;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.security.cert.X509Certificate;
import java.time.Duration;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

@ApplicationScoped
public class PretApiService {
    
    private static final Logger LOGGER = Logger.getLogger(PretApiService.class.getName());
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper;
    
    public PretApiService() {
        HttpClient client;
        try {
            // Créer un TrustManager qui accepte tous les certificats (pour le développement)
            TrustManager[] trustAllCerts = new TrustManager[] {
                new X509TrustManager() {
                    public X509Certificate[] getAcceptedIssuers() { return null; }
                    public void checkClientTrusted(X509Certificate[] certs, String authType) { }
                    public void checkServerTrusted(X509Certificate[] certs, String authType) { }
                }
            };
            
            // Configurer le contexte SSL
            SSLContext sslContext = SSLContext.getInstance("TLS");
            sslContext.init(null, trustAllCerts, new java.security.SecureRandom());
            
            client = HttpClient.newBuilder()
                    .connectTimeout(Duration.ofMillis(ApiConfig.CONNECTION_TIMEOUT))
                    .sslContext(sslContext)
                    .build();
        } catch (Exception e) {
            LOGGER.warning("Erreur lors de la configuration SSL, utilisation du client par défaut: " + e.getMessage());
            client = HttpClient.newBuilder()
                    .connectTimeout(Duration.ofMillis(ApiConfig.CONNECTION_TIMEOUT))
                    .build();
        }
        
        this.httpClient = client;
        this.objectMapper = new ObjectMapper();
        this.objectMapper.registerModule(new JavaTimeModule());
    }
    
    // ===== GESTION DES PRÊTS =====
    
    public PretDTO creerPret(Long idCompte, BigDecimal montant, Integer dureeEnMois) throws Exception {
        return creerPret(idCompte, montant, dureeEnMois, null);
    }
    
    public PretDTO creerPret(Long idCompte, BigDecimal montant, Integer dureeEnMois, Long idTaux) throws Exception {
        try {
            String requestBody;
            if (idTaux != null) {
                requestBody = String.format("{\"idCompte\":%d,\"montant\":%s,\"dureeEnMois\":%d,\"idTaux\":%d}", 
                                          idCompte, montant.toString(), dureeEnMois, idTaux);
            } else {
                requestBody = String.format("{\"idCompte\":%d,\"montant\":%s,\"dureeEnMois\":%d}", 
                                          idCompte, montant.toString(), dureeEnMois);
            }
            
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/prets"))
                    .header("Content-Type", ApiConfig.CONTENT_TYPE_JSON)
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 201) {
                return objectMapper.readValue(response.body(), PretDTO.class);
            } else {
                LOGGER.warning("Erreur lors de la création du prêt: " + response.statusCode() + " - " + response.body());
                throw new Exception("Erreur lors de la création du prêt: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    public PretDTO obtenirPret(Long idPret) throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/prets/" + idPret))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                return objectMapper.readValue(response.body(), PretDTO.class);
            } else if (response.statusCode() == 404) {
                return null;
            } else {
                LOGGER.warning("Erreur lors de la récupération du prêt: " + response.statusCode());
                throw new Exception("Erreur lors de la récupération du prêt");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    public List<PretDTO> obtenirPretsParCompte(Long idCompte) throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/comptes/" + idCompte + "/prets"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                PretDTO[] prets = objectMapper.readValue(response.body(), PretDTO[].class);
                return Arrays.asList(prets);
            } else {
                LOGGER.warning("Erreur lors de la récupération des prêts: " + response.statusCode());
                throw new Exception("Erreur lors de la récupération des prêts");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    public List<PretDTO> obtenirPretsActifs() throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/prets"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                PretDTO[] prets = objectMapper.readValue(response.body(), PretDTO[].class);
                return Arrays.asList(prets);
            } else {
                LOGGER.warning("Erreur lors de la récupération des prêts actifs: " + response.statusCode());
                throw new Exception("Erreur lors de la récupération des prêts actifs");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    // ===== GESTION DES REMBOURSEMENTS =====
    
    public RemboursementDTO effectuerRemboursement(Long idPret, BigDecimal montant) throws Exception {
        try {
            String requestBody = String.format("{\"idPret\":%d,\"montant\":%s}", idPret, montant.toString());
            
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/remboursements"))
                    .header("Content-Type", ApiConfig.CONTENT_TYPE_JSON)
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 201) {
                return objectMapper.readValue(response.body(), RemboursementDTO.class);
            } else {
                LOGGER.warning("Erreur lors du remboursement: " + response.statusCode() + " - " + response.body());
                throw new Exception("Erreur lors du remboursement: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    public List<RemboursementDTO> obtenirRemboursementsParPret(Long idPret) throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/prets/" + idPret + "/remboursements"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                RemboursementDTO[] remboursements = objectMapper.readValue(response.body(), RemboursementDTO[].class);
                return Arrays.asList(remboursements);
            } else {
                LOGGER.warning("Erreur lors de la récupération des remboursements: " + response.statusCode());
                throw new Exception("Erreur lors de la récupération des remboursements");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    // ===== SIMULATIONS =====
    
    public String simulerPret(BigDecimal montant, Integer dureeEnMois) throws Exception {
        try {
            String requestBody = String.format("{\"montant\":%s,\"dureeEnMois\":%d}", 
                                             montant.toString(), dureeEnMois);
            
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/simulations"))
                    .header("Content-Type", ApiConfig.CONTENT_TYPE_JSON)
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                return response.body();
            } else {
                LOGGER.warning("Erreur lors de la simulation de prêt: " + response.statusCode());
                throw new Exception("Erreur lors de la simulation de prêt");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    public String calculerEcheancier(Long idPret) throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/prets/" + idPret + "/echeancier"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                return response.body();
            } else {
                LOGGER.warning("Erreur lors du calcul de l'échéancier: " + response.statusCode());
                throw new Exception("Erreur lors du calcul de l'échéancier");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    // ===== STATISTIQUES =====
    
    public String obtenirStatistiquesPrets(Long idCompte) throws Exception {
        try {
            String url = idCompte != null ? 
                ApiConfig.PRET_API_BASE_URL + "/comptes/" + idCompte + "/statistiques" :
                ApiConfig.PRET_API_BASE_URL + "/statistiques";
                
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                return response.body();
            } else {
                LOGGER.warning("Erreur lors de la récupération des statistiques prêts: " + response.statusCode());
                throw new Exception("Erreur lors de la récupération des statistiques prêts");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    // ===== GESTION DES TAUX =====
    
    public String obtenirTousLesTaux() throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/taux"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                return response.body();
            } else {
                LOGGER.warning("Erreur lors de la récupération des taux: " + response.statusCode());
                throw new Exception("Erreur lors de la récupération des taux");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    public String obtenirTauxActuel() throws Exception {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/taux/actuel"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(ApiConfig.READ_TIMEOUT))
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                return response.body();
            } else {
                LOGGER.warning("Erreur lors de la récupération du taux actuel: " + response.statusCode());
                throw new Exception("Erreur lors de la récupération du taux actuel");
            }
        } catch (IOException | InterruptedException e) {
            LOGGER.severe("Erreur de communication avec l'API prêt: " + e.getMessage());
            throw new Exception(ApiConfig.ERROR_NETWORK, e);
        }
    }
    
    // ===== VÉRIFICATION DE SANTÉ =====
    
    public boolean verifierSanteApi() {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(ApiConfig.PRET_API_BASE_URL + "/health"))
                    .header("Accept", ApiConfig.ACCEPT_JSON)
                    .timeout(Duration.ofMillis(3000)) // Timeout court pour la vérification
                    .GET()
                    .build();
            
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return response.statusCode() == 200;
        } catch (Exception e) {
            LOGGER.warning("API prêt indisponible: " + e.getMessage());
            return false;
        }
    }
}
