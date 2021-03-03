package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.Secteur_activiteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;
import java.util.Set;

/**
 * Session Bean implementation class ServiceOffresEmplois
 * @author Florian GUILLOT
 */
@Stateless
@LocalBean
public class ServiceOffreEmploi implements IServiceOffreEmploi{
	//-----------------------------------------------------------------------------
	@EJB private OffreEmploiDAO         offreEmploiDAO;
	@EJB private Secteur_activiteDAO         secteurDAO;
	@EJB private EntrepriseDAO         entrepriseDAO;
	//-----------------------------------------------------------------------------
    /**
     * Default constructor. 
     */
    public ServiceOffreEmploi() {
        // TODO Auto-generated constructor stub
    }
    
    @Override
    public List<OffreEmploi> listeDesOffres()
    {
      return offreEmploiDAO.findAll();
    }
    //-----------------------------------------------------------------------------
    @Override
    public OffreEmploi getOffre(int id)
    {
      return offreEmploiDAO.findById(id);
    }
  //-----------------------------------------------------------------------------
    @Override
    public OffreEmploi CreationOffre(OffreEmploi offreEmploi)
    {
      OffreEmploi offreReturn = offreEmploiDAO.persist(offreEmploi);
      Set<SecteurActivite> secteurs = offreReturn.getSecteurActivites();
      
      offreReturn.getEntreprise().addOffreEmploi(offreReturn);
      entrepriseDAO.update(offreReturn.getEntreprise());
      
      for(SecteurActivite s : secteurs) {
    	  s.addOffreEmplois(offreReturn);
    	  //secteurDAO.update(s);
      }
      return offreReturn;
    }
    //-----------------------------------------------------------------------------
    @Override
    public OffreEmploi UpdateOffre(OffreEmploi offre)
    {
      return offreEmploiDAO.update(offre);
    }
  //-----------------------------------------------------------------------------
    @Override
    public void RemoveOffre(OffreEmploi offre)
    {
      offreEmploiDAO.remove(offre);
    }
  //-----------------------------------------------------------------------------
}
