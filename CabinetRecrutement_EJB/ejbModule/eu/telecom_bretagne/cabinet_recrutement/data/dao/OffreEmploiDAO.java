package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.service.JPAUtil;

/**
 * Session Bean implementation class OffreEmploiDAO
 * @author Florian GUILLOT & Matthieu LE JEUNE
 */
@Stateless
@LocalBean
public class OffreEmploiDAO
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
  public OffreEmploiDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public OffreEmploi findById(Integer id)
  {
    return entityManager.find(OffreEmploi.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<OffreEmploi> findAll()
  {
    Query query = entityManager.createQuery("select offreEmploi from OffreEmploi offreEmploi order by offreEmploi.id");
    List l = query.getResultList();

    return (List<OffreEmploi>)l;
  }
  
  public List<OffreEmploi> findByEntreprise(int idEntreprise)
  {
	List<OffreEmploi> offreEmplois = null;
	offreEmplois = entityManager.createNativeQuery("SELECT * FROM offre_Emploi WHERE id_entreprise = ?", OffreEmploi.class)
            .setParameter(1, idEntreprise)
            .getResultList();
    
    return offreEmplois;
  }

  public OffreEmploi persist(OffreEmploi OffreEmploi) {
	EntityManager Offre = JPAUtil.getEntityManager();
	Offre.persist(OffreEmploi);

	return OffreEmploi;
  }

  public OffreEmploi update(OffreEmploi OffreEmploi) {
	EntityManager Offre = JPAUtil.getEntityManager();
	Offre.merge(OffreEmploi);

	return OffreEmploi;
  }

  public void remove(OffreEmploi OffreEmploi) {
	EntityManager Offre = JPAUtil.getEntityManager();
	Offre.remove(OffreEmploi);
  }
  //-----------------------------------------------------------------------------
}