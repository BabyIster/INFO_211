package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.service.JPAUtil;

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
  public Candidature findById(Integer id)
  {
    return entityManager.find(Candidature.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<Candidature> findAll()
  {
    Query query = entityManager.createQuery("select candidature from Candidature candidature order by candidature.id");
    List l = query.getResultList(); 
    
    return (List<Candidature>)l;
  }
  

  public List<Candidature> findBySectorAndQualification(int sector, int qualification)
  {
	List<Candidature> candidatures = null;
	candidatures = entityManager.createNativeQuery("SELECT * FROM index_activite_candidature INNER JOIN Candidature cand ON id_candidature = cand.id WHERE id_activite = ? AND id_qualification = ?", Candidature.class)
            .setParameter(1, sector).setParameter(2, qualification)
            .getResultList();
    
    return candidatures;
  }

  public Candidature persist(Candidature candidature) {
      if (candidature != null) {
          entityManager.persist(candidature);
      }
      return candidature;
  }
  
  public Candidature update(Candidature candidature) {
	  if (candidature != null) {
		  entityManager.merge(candidature);
	  }
	return candidature;
  }
  
  public void remove(Candidature candidature) {
	  if (candidature != null) {
          Candidature temp = entityManager.merge(candidature);
          entityManager.remove(temp);
      }
  }
  //-----------------------------------------------------------------------------
}