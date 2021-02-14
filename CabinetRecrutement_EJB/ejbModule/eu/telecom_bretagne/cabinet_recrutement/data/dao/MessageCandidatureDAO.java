package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.service.JPAUtil;

/**
 * Session Bean implementation class MessageCandidatureDAO
 * @author Florian GUILLOT & Matthieu LE JEUNE
 */
@Stateless
@LocalBean
public class MessageCandidatureDAO
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
  public MessageCandidatureDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public MessageCandidature findById(Integer id)
  {
    return entityManager.find(MessageCandidature.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<MessageCandidature> findAll()
  {
    Query query = entityManager.createQuery("select m from MessageCandidature m order by m.id");
    List l = query.getResultList();

    return (List<MessageCandidature>)l;
  }
  
  public List<MessageCandidature> findByOffre(int idOffre)
  {
	List<MessageCandidature> messageCandidatures = null;
	messageCandidatures = entityManager.createNativeQuery("SELECT * FROM message_candidature WHERE id_offre_emploi = ?", MessageCandidature.class)
            .setParameter(1, idOffre)
            .getResultList();
    
    return messageCandidatures;
  }
  
  public List<MessageCandidature> findByCandidature(int idCandidature)
  {
	List<MessageCandidature> messageCandidatures = null;
	messageCandidatures = entityManager.createNativeQuery("SELECT * FROM message_candidature WHERE id_candidature = ?", MessageCandidature.class)
            .setParameter(1, idCandidature)
            .getResultList();
    
    return messageCandidatures;
  }


  public MessageCandidature persist(MessageCandidature messageCandidature) {
      if (messageCandidature != null) {
          entityManager.persist(messageCandidature);
      }
      return messageCandidature;
  }

  public MessageCandidature update(MessageCandidature messageCandidature) {
	  if (messageCandidature != null) {
          entityManager.merge(messageCandidature);
      }
      return messageCandidature;
  }

  public void remove(MessageCandidature messageCandidature) {
	  if (messageCandidature != null) {
		  MessageCandidature temp = entityManager.merge(messageCandidature);
          entityManager.remove(temp);
      }
  }
  //-----------------------------------------------------------------------------
}