package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.QualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification;

/**
 * Session Bean implementation class ServiceQualification
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceQualification implements IServiceQualification
{
  //-----------------------------------------------------------------------------
  @EJB private QualificationDAO         QualificationDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceQualification()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public Qualification getQualification(int id)
  {
    return QualificationDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Qualification> listeDesQualifications()
  {
    return QualificationDAO.findAll();
  }
  //-----------------------------------------------------------------------------
  @Override
  public Qualification CreationQualification(Qualification Qualification)
  {
    return QualificationDAO.persist(Qualification);
  }
  //-----------------------------------------------------------------------------
	@Override
	public Qualification getQualificationByName(String name) {
		for(Qualification q : listeDesQualifications()) {
			if(q.getIntitule().equalsIgnoreCase(name)) {
				return q;
			}
		}
		return null;
	}
}
