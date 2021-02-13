package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification;
import eu.telecom_bretagne.cabinet_recrutement.service.JPAUtil;

/**
 * Session Bean implementation class qualification_activiteDAO
 * @author Florian GUILLOT & Matthieu LE JEUNE
 */
@Stateless
@LocalBean
public class QualificationDAO
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
  public QualificationDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  
  public Qualification findById(Integer id)
  {
    return entityManager.find(Qualification .class, id);
  }
  
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<Qualification > findAll()
  {
    Query query = entityManager.createQuery("select qualification from Qualification qualification order by qualification.id");

    List l = query.getResultList();

    return (List<Qualification >)l;
  }

  public Qualification  persist(Qualification  qualification) {
	  if (qualification != null) {
          entityManager.persist(qualification);
      }
      return qualification;
  }

  public Qualification  update(Qualification  qualification) {
	  if (qualification != null) {
          entityManager.merge(qualification);
      }
      return qualification;
  }

  //-----------------------------------------------------------------------------
}