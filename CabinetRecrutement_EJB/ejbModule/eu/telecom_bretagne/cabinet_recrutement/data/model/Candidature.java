package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.Set;


/**
 * The persistent class for the candidature database table.
 * 
 */
@Entity
@NamedQuery(name="Candidature.findAll", query="SELECT c FROM Candidature c")
public class Candidature implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="CANDIDATURE_ID_GENERATOR", sequenceName="CANDIDATURE_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="CANDIDATURE_ID_GENERATOR")
	private Integer id;

	@Column(name="adresse_email")
	private String adresseEmail;

	@Column(name="adresse_postale")
	private String adressePostale;

	private String cv;

	@Temporal(TemporalType.DATE)
	@Column(name="date_depot")
	private Date dateDepot;

	@Temporal(TemporalType.DATE)
	@Column(name="date_naissance")
	private Date dateNaissance;

	private String nom;

	private String prenom;

	//bi-directional many-to-one association to Qualification
	@ManyToOne
	@JoinColumn(name="id_qualification")
	private Qualification qualification;

	//bi-directional many-to-one association to MessageCandidature
	@OneToMany(mappedBy="candidature")
	private Set<MessageCandidature> messageCandidatures;

	//bi-directional many-to-one association to MessageOffreEmploi
	@OneToMany(mappedBy="candidature")
	private Set<MessageOffreEmploi> messageOffreEmplois;

	//bi-directional many-to-many association to SecteurActivite
	@ManyToMany(mappedBy="candidatures")
	private Set<SecteurActivite> secteurActivites;

	public Candidature() {
	}
	
	public Candidature(String prenomC, String nomC, Date dateNaissanceC, String postaleC, String mailC, String cvC, Date dateDepotC, Qualification qualificationC, Set<SecteurActivite> secteurs) {
		this.nom=nomC;
		this.prenom=prenomC;
		this.dateNaissance=dateNaissanceC;
		this.adresseEmail=mailC;
		this.adressePostale=postaleC;
		this.cv=cvC;
		this.dateDepot=dateDepotC;
		this.qualification=qualificationC;
		this.secteurActivites=secteurs;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAdresseEmail() {
		return this.adresseEmail;
	}

	public void setAdresseEmail(String adresseEmail) {
		this.adresseEmail = adresseEmail;
	}

	public String getAdressePostale() {
		return this.adressePostale;
	}

	public void setAdressePostale(String adressePostale) {
		this.adressePostale = adressePostale;
	}

	public String getCv() {
		return this.cv;
	}

	public void setCv(String cv) {
		this.cv = cv;
	}

	public Date getDateDepot() {
		return this.dateDepot;
	}

	public void setDateDepot(Date dateDepot) {
		this.dateDepot = dateDepot;
	}

	public Date getDateNaissance() {
		return this.dateNaissance;
	}

	public void setDateNaissance(Date dateNaissance) {
		this.dateNaissance = dateNaissance;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return this.prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public Qualification getQualification() {
		return this.qualification;
	}

	public void setQualification(Qualification qualification) {
		this.qualification = qualification;
	}

	public Set<MessageCandidature> getMessageCandidatures() {
		return this.messageCandidatures;
	}

	public void setMessageCandidatures(Set<MessageCandidature> messageCandidatures) {
		this.messageCandidatures = messageCandidatures;
	}

	public MessageCandidature addMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().add(messageCandidature);
		messageCandidature.setCandidature(this);

		return messageCandidature;
	}

	public MessageCandidature removeMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().remove(messageCandidature);
		messageCandidature.setCandidature(null);

		return messageCandidature;
	}

	public Set<MessageOffreEmploi> getMessageOffreEmplois() {
		return this.messageOffreEmplois;
	}

	public void setMessageOffreEmplois(Set<MessageOffreEmploi> messageOffreEmplois) {
		this.messageOffreEmplois = messageOffreEmplois;
	}

	public MessageOffreEmploi addMessageOffreEmploi(MessageOffreEmploi messageOffreEmploi) {
		getMessageOffreEmplois().add(messageOffreEmploi);
		messageOffreEmploi.setCandidature(this);

		return messageOffreEmploi;
	}

	public MessageOffreEmploi removeMessageOffreEmploi(MessageOffreEmploi messageOffreEmploi) {
		getMessageOffreEmplois().remove(messageOffreEmploi);
		messageOffreEmploi.setCandidature(null);

		return messageOffreEmploi;
	}

	public Set<SecteurActivite> getSecteurActivites() {
		return this.secteurActivites;
	}

	public void setSecteurActivites(Set<SecteurActivite> secteurActivites) {
		this.secteurActivites = secteurActivites;
	}

}