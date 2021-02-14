package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;

/**
 * Session Bean implementation class CandidatureDAO
 * @author Florian GUILLOT & Matthieu LE JEUNE
 */
@Stateless
@LocalBean
public class CandidatureDAO
{
  //-----------------------------------------------------------------------------
  /**
   * Référence vers le gestionnaire de persistance.
   */
  @PersistenceContext
  EntityManager entityManager;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public CandidatureDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  
  /**
   * Recherche de l'objet candidature grâce à l'id en entrée
   * 
   * @param id de la candidature a trouver
   * @return la candidature correspondante à l'id
   */
  public Candidature findById(Integer id)
  {
    return entityManager.find(Candidature.class, id);
  }
  //----------------------------------------------------------------------------
  
  /**
   * Liste toutes les candidatures présentent dans la base
   * 
   * @return la liste
   */
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<Candidature> findAll()
  {
    Query query = entityManager.createQuery("select candidature from Candidature candidature order by candidature.id");
    List l = query.getResultList(); 
    
    return (List<Candidature>)l;
  }
  
/**
 * Recherche une candidature correspondant au secteur et a la qualification
 * 
 * @param sector
 * @param qualification
 * @return
 */
  public List<Candidature> findBySectorAndQualification(int sector, int qualification)
  {
	List<Candidature> candidatures = null;
	candidatures = entityManager.createNativeQuery("SELECT * FROM index_activite_candidature INNER JOIN Candidature cand ON id_candidature = cand.id WHERE id_activite = ? AND id_qualification = ?", Candidature.class)
            .setParameter(1, sector).setParameter(2, qualification)
            .getResultList();
    
    return candidatures;
  }
  
  /**
   * Création d'une candidature
   * 
   * @param candidature Object Candidature en entrée
   * @return On retourne l'objet crée
   */
  public Candidature persist(Candidature candidature) {
      if (candidature != null) {
          entityManager.persist(candidature);
      }
      return candidature;
  }
  
  /**
   * Modification d'une candidature (avec un set fait au préalable)
   * 
   * @param candidature
   * @return
   */
  public Candidature update(Candidature candidature) {
	  if (candidature != null) {
		  entityManager.merge(candidature);
	  }
	return candidature;
  }
  
  /**
   * Suppression d'une candidature
   * 
   *    * @param candidature à supprimer
   */
  public void remove(Candidature candidature) {
	  try {
		  Candidature temp = entityManager.merge(candidature);
          entityManager.remove(temp);
	} catch (Exception e) {
		e.printStackTrace();
		return;
	}
   
  }
  //-----------------------------------------------------------------------------
}