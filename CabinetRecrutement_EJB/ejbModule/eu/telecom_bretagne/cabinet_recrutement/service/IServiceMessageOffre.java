package eu.telecom_bretagne.cabinet_recrutement.service;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;

@Remote
public interface IServiceMessageOffre {
	
	public void RemoveMessageOffre(MessageOffreEmploi message);
	
	public MessageOffreEmploi CreationMessageOffre(MessageOffreEmploi message);

}
