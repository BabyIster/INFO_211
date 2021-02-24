package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

/**
 * Session Bean implementation class ServiceOffresEmplois
 * @author Florian GUILLOT
 */
@Stateless
@LocalBean
public class ServiceOffreEmploi implements IServiceOffreEmploi{
	//-----------------------------------------------------------------------------
	@EJB private OffreEmploiDAO         offreEmploiDAO;
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

}
