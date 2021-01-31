package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Offre_emploi;
import jpaUtils.JPAUtil;

/**
 * Session Bean implementation class Offre_emploiDAO
 * @author Florian GUILLOT & Matthieu LE JEUNE
 */
@Stateless
@LocalBean
public class Offre_emploiDAO
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
  public Offre_emploiDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public Offre_emploi findById(Integer id)
  {
    return entityManager.find(Offre_emploi.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<Offre_emploi> findAll()
  {
    Query query = entityManager.createQuery("select * from Offre_emploi order by id");
    List l = query.getResultList();

    return (List<Offre_emploi>)l;
  }


  public List<Offre_emploi> findAll()
  {
    Query query = entityManager.createQuery("select * from Offre_emploi order by id");
    List l = query.getResultList();

    return (List<Offre_emploi>)l;
  }

  public Offre_emploi persist(Offre_emploi Offre_emploi) {
	EntityManager Offre = JPAUtil.getEntityManager();
	Offre.persist(Offre_emploi);

	return Offre_emploi;
  }

  public Offre_emploi update(Offre_emploi Offre_emploi) {
	EntityManager Offre = JPAUtil.getEntityManager();
	Offre.merge(Offre_emploi);

	return Offre_emploi;
  }

  public void remove(Offre_emploi Offre_emploi) {
	EntityManager Offre = JPAUtil.getEntityManager();
	Offre.remove(Offre_emploi);
  }
  //-----------------------------------------------------------------------------
}