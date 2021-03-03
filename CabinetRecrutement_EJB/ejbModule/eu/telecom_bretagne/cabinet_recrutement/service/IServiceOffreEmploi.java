package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Qualification;

/**
 * Interface du service gérant les entreprises.
 * @author Florian GUILLOT
 */
@Remote
public interface IServiceOffreEmploi {
	
	public List<OffreEmploi> listeDesOffres();
	
	public OffreEmploi getOffre(int id);
	
	public OffreEmploi CreationOffre(OffreEmploi offreEmploi);
	
	public OffreEmploi UpdateOffre(OffreEmploi offre);
	
	public void RemoveOffre(OffreEmploi offre);
	
	public List<OffreEmploi> listOffreQualification(Qualification qualification);

}
