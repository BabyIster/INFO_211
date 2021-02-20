package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Interface du service gérant les entreprises.
 * @author Philippe TANGUY
 */
@Remote
public interface IServiceSecteurActivite
{
  //-----------------------------------------------------------------------------
  /**
   * Obtention d'une <{@link Entreprise}.
   * 
   * @param id id de l'entreprise à récupérer.
   * @return
   */
  public SecteurActivite getSecteurActivite(int id);
  /**
   * Obtention de la liste de toutes les entreprises.
   * 
   * @return la liste des entreprises dans une {@code List<Entreprise>}.
   */
  public List<SecteurActivite> listeDesSecteurActivites();
  
  public SecteurActivite CreationSecteurActivite(SecteurActivite SecteurActivite);
  //-----------------------------------------------------------------------------
}