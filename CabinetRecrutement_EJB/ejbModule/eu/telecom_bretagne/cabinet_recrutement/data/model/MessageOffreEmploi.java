package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the message_offre_emploi database table.
 * 
 */
@Entity
@Table(name="message_offre_emploi")
@NamedQuery(name="MessageOffreEmploi.findAll", query="SELECT m FROM MessageOffreEmploi m")
public class MessageOffreEmploi implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="MESSAGE_OFFRE_EMPLOI_ID_GENERATOR", sequenceName="MESSAGE_OFFRE_EMPLOI_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="MESSAGE_OFFRE_EMPLOI_ID_GENERATOR")
	private Integer id;

	@Column(name="corps_message")
	private String corpsMessage;

	@Temporal(TemporalType.DATE)
	@Column(name="date_envoi")
	private Date dateEnvoi;

	//bi-directional many-to-one association to Candidature
	@ManyToOne
	@JoinColumn(name="id_candidature")
	private Candidature candidature;

	//bi-directional many-to-one association to OffreEmploi
	@ManyToOne
	@JoinColumn(name="id_offre_emploi")
	private OffreEmploi offreEmploi;

	public MessageOffreEmploi() {
	}
	
	public MessageOffreEmploi(String msg, Date envoi, OffreEmploi offre, Candidature cand) {
		this.corpsMessage=msg;
		this.dateEnvoi=envoi;
		this.candidature=cand;
		this.offreEmploi=offre;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCorpsMessage() {
		return this.corpsMessage;
	}

	public void setCorpsMessage(String corpsMessage) {
		this.corpsMessage = corpsMessage;
	}

	public Date getDateEnvoi() {
		return this.dateEnvoi;
	}

	public void setDateEnvoi(Date dateEnvoi) {
		this.dateEnvoi = dateEnvoi;
	}

	public Candidature getCandidature() {
		return this.candidature;
	}

	public void setCandidature(Candidature candidature) {
		this.candidature = candidature;
	}

	public OffreEmploi getOffreEmploi() {
		return this.offreEmploi;
	}

	public void setOffreEmploi(OffreEmploi offreEmploi) {
		this.offreEmploi = offreEmploi;
	}

}