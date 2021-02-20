package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.Secteur_activiteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Session Bean implementation class ServiceSecteurActivite
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceSecteurActivite implements IServiceSecteurActivite
{
  //-----------------------------------------------------------------------------
  @EJB private Secteur_activiteDAO         SecteurActiviteDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceSecteurActivite()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public SecteurActivite getSecteurActivite(int id)
  {
    return SecteurActiviteDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<SecteurActivite> listeDesSecteurActivites()
  {
    return SecteurActiviteDAO.findAll();
  }
  //-----------------------------------------------------------------------------
  @Override
  public SecteurActivite CreationSecteurActivite(SecteurActivite SecteurActivite)
  {
    return SecteurActiviteDAO.persist(SecteurActivite);
  }
  //-----------------------------------------------------------------------------
}
