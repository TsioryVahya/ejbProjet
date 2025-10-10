package com.banque.compte.ejb;

import jakarta.ejb.Local;

@Local
public interface CompteServiceLocal extends CompteServiceRemote {
    // Interface locale hérite de toutes les méthodes de l'interface remote
    // Peut ajouter des méthodes spécifiques au contexte local si nécessaire
}
