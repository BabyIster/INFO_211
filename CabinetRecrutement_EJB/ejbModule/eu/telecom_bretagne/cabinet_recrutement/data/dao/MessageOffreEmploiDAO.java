package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.service.JPAUtil;

/**
 * Session Bean implementation class MessageOffreEmploiDAO
 * @author Florian GUILLOT & Matthieu LE JEUNE
 */
@Stateless
@LocalBean
public class MessageOffreEmploiDAO
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
  public MessageOffreEmploiDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public MessageOffreEmploi findById(Integer id)
  {
    return entityManager.find(MessageOffreEmploi.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<MessageOffreEmploi> findAll()
  {
    Query query = entityManager.createQuery("select m from MessageOffreEmploi m order by m.id");
    List l = query.getResultList();

    return (List<MessageOffreEmploi>)l;
  }
  
  public List<MessageOffreEmploi> findByOffre(int idOffre)
  {
	List<MessageOffreEmploi> messageOffreEmplois = null;
	messageOffreEmplois = entityManager.createNativeQuery("SELECT * FROM message_offre_emploi WHERE id_offre_emploi = ?", MessageOffreEmploi.class)
            .setParameter(1, idOffre)
            .getResultList();
    
    return messageOffreEmplois;
  }
  
  public List<MessageOffreEmploi> findByOffreEmploi(int idOffreEmploi)
  {
	List<MessageOffreEmploi> messageOffreEmplois = null;
	messageOffreEmplois = entityManager.createNativeQuery("SELECT * FROM message_OffreEmploi WHERE id_OffreEmploi = ?", MessageOffreEmploi.class)
            .setParameter(1, idOffreEmploi)
            .getResultList();
    
    return messageOffreEmplois;
  }


  public MessageOffreEmploi persist(MessageOffreEmploi messageOffreEmploi) {
      if (messageOffreEmploi != null) {
          entityManager.persist(messageOffreEmploi);
      }
      return messageOffreEmploi;
  }

  public MessageOffreEmploi update(MessageOffreEmploi messageOffreEmploi) {
	  if (messageOffreEmploi != null) {
          entityManager.merge(messageOffreEmploi);
      }
      return messageOffreEmploi;
  }

  public void remove(MessageOffreEmploi messageOffreEmploi) {
	  if (messageOffreEmploi != null) {
		  MessageOffreEmploi temp = entityManager.merge(messageOffreEmploi);
          entityManager.remove(temp);
      }
  }
  //-----------------------------------------------------------------------------
}