package eu.telecom_bretagne.cabinet_recrutement.service;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;

@Remote
public interface IServiceMessageCand {
	
	public MessageCandidature CreationMessageCand(MessageCandidature message);

}
