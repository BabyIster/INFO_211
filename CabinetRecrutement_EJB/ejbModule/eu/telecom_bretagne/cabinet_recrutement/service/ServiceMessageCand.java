package eu.telecom_bretagne.cabinet_recrutement.service;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceMessageCand implements IServiceMessageCand
{
  //-----------------------------------------------------------------------------
  @EJB private MessageCandidatureDAO         messageCandDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceMessageCand()
  {
    // TODO Auto-generated constructor stub
  }
}