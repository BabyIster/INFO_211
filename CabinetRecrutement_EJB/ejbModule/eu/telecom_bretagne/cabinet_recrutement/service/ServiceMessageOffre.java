package eu.telecom_bretagne.cabinet_recrutement.service;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceMessageOffre implements IServiceMessageOffre
{
  //-----------------------------------------------------------------------------
  @EJB private MessageOffreEmploiDAO         messageOffreDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceMessageOffre()
  {
	  
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public void RemoveMessageOffre(MessageOffreEmploi message)
  {
    messageOffreDAO.remove(message);
  }
  //-----------------------------------------------------------------------------
}