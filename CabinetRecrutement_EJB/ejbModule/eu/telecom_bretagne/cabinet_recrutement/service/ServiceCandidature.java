package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceCandidature implements IServiceCandidature
{
  //-----------------------------------------------------------------------------
  @EJB private CandidatureDAO         candidatureDAO;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public ServiceCandidature()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  @Override
  public Candidature getCandidature(int id)
  {
    return candidatureDAO.findById(id);
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Candidature> listCandidatures()
  {
    return candidatureDAO.findAll();
  }
  //-----------------------------------------------------------------------------
  @Override
  public Candidature CreationCandidature(Candidature candidature)
  {
    Candidature candReturn = candidatureDAO.persist(candidature);
    Set<SecteurActivite> secteurs = candReturn.getSecteurActivites();
    
    for(SecteurActivite s : secteurs) {
  	  s.addCandidature(candReturn);
    }
    
    candReturn.getQualification().getCandidatures().add(candReturn);
    
    return candReturn;
  }
  //-----------------------------------------------------------------------------
  @Override
  public List<Candidature> listCandidaturesPotentielles(Set<SecteurActivite> secteurs, Qualification qualification) {
	List<Candidature> candidatures = new ArrayList<Candidature>();
	List<Candidature> candidaturesRecu = new ArrayList<Candidature>();
	
	for(SecteurActivite s : secteurs) {
		candidaturesRecu = candidatureDAO.findBySectorAndQualification(s.getId(), qualification.getId());
		if(candidaturesRecu != null) {
			for(Candidature c : candidaturesRecu) {
				candidatures.add(c);
			}
		}
	}
	Set<Candidature> setTemp = new HashSet<Candidature>(candidatures);
	List<Candidature> candidaturesFinal = new ArrayList<Candidature>(setTemp);
	
    return candidaturesFinal;
  }
  //-----------------------------------------------------------------------------
  @Override
  public void DeleteCandidature(Candidature candidature) {
    candidatureDAO.remove(candidature);
  }
  @Override
  public Candidature UpdateCandidature(Candidature candidature) {
    return candidatureDAO.update(candidature);
  }
}
