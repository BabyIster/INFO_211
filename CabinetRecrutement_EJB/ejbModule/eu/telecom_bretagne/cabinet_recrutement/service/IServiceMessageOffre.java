package eu.telecom_bretagne.cabinet_recrutement.service;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;

public interface IServiceMessageOffre {
	
	public void RemoveMessageOffre(MessageOffreEmploi message);
	
	public MessageOffreEmploi CreationMessageOffre(MessageOffreEmploi message);

}
