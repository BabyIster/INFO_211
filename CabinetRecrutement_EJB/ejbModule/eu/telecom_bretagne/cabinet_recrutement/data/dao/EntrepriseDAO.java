package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import jpaUtils.JPAUtil;

/**
 * Session Bean implementation class EntrepriseDAO
 * @author Florian GUILLOT & Matthieu LE JEUNE
 */
@Stateless
@LocalBean
public class EntrepriseDAO
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
  public EntrepriseDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public Entreprise findById(Integer id)
  {
    return entityManager.find(Entreprise.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<Entreprise> findAll()
  {
    Query query = entityManager.createQuery("select entreprise from Entreprise entreprise order by entreprise.id");
    List l = query.getResultList();

    return (List<Entreprise>)l;
  }

  public Entreprise persist(Entreprise entreprise) {
	EntityManager Ent = JPAUtil.getEntityManager();
	Ent.persist(entreprise);

	return entreprise;
  }

  public Entreprise update(Entreprise entreprise) {
	EntityManager Ent = JPAUtil.getEntityManager();
	Ent.merge(entreprise);

	return entreprise;
  }

  public void remove(Entreprise entreprise) {
	EntityManager Ent = JPAUtil.getEntityManager();
	Ent.remove(entreprise);
  }
  //-----------------------------------------------------------------------------
}