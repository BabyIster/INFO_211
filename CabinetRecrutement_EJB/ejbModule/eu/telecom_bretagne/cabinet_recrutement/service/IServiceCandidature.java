package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;

/**
 * Interface du service gérant les entreprises.
 * @author Matthieu Le Jeune
 */
@Remote
public interface IServiceCandidature
{
  //-----------------------------------------------------------------------------
  /**
   * Obtention d'une <{@link Candidature}.
   * 
   * @param id id de l'entreprise à récupérer.
   * @return
   */
  public Candidature getCandidature(int id);
  /**
   * Obtention de la liste de toutes les Candidature.
   * 
   * @return la liste des Candidature dans une {@code List<Candidature>}.
   */
  public List<Candidature> listCandidatures();
  //-----------------------------------------------------------------------------
}
