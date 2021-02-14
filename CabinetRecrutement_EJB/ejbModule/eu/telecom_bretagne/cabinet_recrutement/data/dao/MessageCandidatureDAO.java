package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;

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
  
  /**
   * Recherche de l'objet MessageCandidature grâce à l'id en entrée
   * 
   * @param id du message a trouver
   * @return le message correspondant à l'id
   */
  public MessageCandidature findById(Integer id)
  {
    return entityManager.find(MessageCandidature.class, id);
  }
  //----------------------------------------------------------------------------
  
  /**
   * Liste tous les messages des candidats présents dans la base
   * 
   * @return la liste
   */
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<MessageCandidature> findAll()
  {
    Query query = entityManager.createQuery("select m from MessageCandidature m order by m.id");
    List l = query.getResultList();

    return (List<MessageCandidature>)l;
  }
  
  /**
   * Recherche des messages lié à une offre
   * 
   * @param idOffre
   * @return la liste messages
   */
  public List<MessageCandidature> findByOffre(int idOffre)
  {
	List<MessageCandidature> messageCandidatures = null;
	messageCandidatures = entityManager.createNativeQuery("SELECT * FROM message_candidature WHERE id_offre_emploi = ?", MessageCandidature.class)
            .setParameter(1, idOffre)
            .getResultList();
    
    return messageCandidatures;
  }
  
  /**
   * Recherche des messages lié à une candidature
   * 
   * @param idOffre
   * @return la liste messages
   */
  public List<MessageCandidature> findByCandidature(int idCandidature)
  {
	List<MessageCandidature> messageCandidatures = null;
	messageCandidatures = entityManager.createNativeQuery("SELECT * FROM message_candidature WHERE id_candidature = ?", MessageCandidature.class)
            .setParameter(1, idCandidature)
            .getResultList();
    
    return messageCandidatures;
  }

  /**
   * Création d'un MessageCandidature
   * 
   * @param MessageCandidature Object Message en entrée
   * @return On retourne l'objet crée
   */
  public MessageCandidature persist(MessageCandidature messageCandidature) {
      if (messageCandidature != null) {
          entityManager.persist(messageCandidature);
      }
      return messageCandidature;
  }
  
  /**
   * Modification d'un message (avec un set fait au préalable)
   * 
   * @param MessageCandidature
   * @return
   */
  public MessageCandidature update(MessageCandidature messageCandidature) {
	  if (messageCandidature != null) {
          entityManager.merge(messageCandidature);
      }
      return messageCandidature;
  }

  /**
   * Suppression d'un message
   * 
   *    * @param MessageCandidature à supprimer
   */
  public void remove(MessageCandidature messageCandidature) {
	  if (messageCandidature != null) {
		  MessageCandidature temp = entityManager.merge(messageCandidature);
          entityManager.remove(temp);
      }
  }
  //-----------------------------------------------------------------------------
}