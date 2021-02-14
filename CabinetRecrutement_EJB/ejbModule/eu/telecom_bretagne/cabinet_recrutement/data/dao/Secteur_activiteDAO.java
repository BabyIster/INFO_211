package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;
import eu.telecom_bretagne.cabinet_recrutement.service.JPAUtil;

/**
 * Session Bean implementation class Secteur_activiteDAO
 * @author Florian GUILLOT & Matthieu LE JEUNE
 */
@Stateless
@LocalBean
public class Secteur_activiteDAO
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
  public Secteur_activiteDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  
  public SecteurActivite findById(Integer id)
  {
    return entityManager.find(SecteurActivite.class, id);
  }
  
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<SecteurActivite> findAll()
  {
    Query query = entityManager.createQuery("select secteur from SecteurActivite secteur order by secteur.id");

    List l = query.getResultList();

    return (List<SecteurActivite>)l;
  }

  public SecteurActivite persist(SecteurActivite secteur) {
	  if (secteur != null) {
          entityManager.persist(secteur);
      }
      return secteur;
  }

  public SecteurActivite update(SecteurActivite secteur) {
	  if (secteur != null) {
          entityManager.merge(secteur);
      }
      return secteur;
  }
  
  /**
   * Utilisé uniquement pour nos tests afin de ne pas se retrouver avec plusieurs fois le même secteur 
   * @param secteur
   */
  public void remove(SecteurActivite secteur) {
	  try {
		  SecteurActivite temp = entityManager.merge(secteur);
          entityManager.remove(temp);
	} catch (Exception e) {
		e.printStackTrace();
		return;
	}
  }
  

  //-----------------------------------------------------------------------------
}