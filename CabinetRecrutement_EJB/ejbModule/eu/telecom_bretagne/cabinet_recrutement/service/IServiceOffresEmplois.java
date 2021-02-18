package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

/**
 * Interface du service gérant les entreprises.
 * @author Florian GUILLOT
 */
@Remote
public interface IServiceOffresEmplois {
	
	public List<OffreEmploi> listeDesOffres();
	
	public OffreEmploi getOffre(int id);

}
