package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the offre_emploi database table.
 * 
 */
@Entity
@Table(name="offre_emploi")
@NamedQuery(name="OffreEmploi.findAll", query="SELECT o FROM OffreEmploi o")
public class OffreEmploi implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="OFFRE_EMPLOI_ID_GENERATOR", sequenceName="OFFRE_EMPLOI_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="OFFRE_EMPLOI_ID_GENERATOR")
	private Integer id;

	@Temporal(TemporalType.DATE)
	@Column(name="date_depot")
	private Date dateDepot;

	private String descriptif;
	
	//bi-directional many-to-one association to Qualification
	@ManyToOne
	@JoinColumn(name="id_qualification")
	private Qualification qualification;

	@Column(name="profil_recherche")
	private String profilRecherche;

	private String titre;

	//bi-directional many-to-one association to MessageCandidature
	@OneToMany(mappedBy="offreEmploi")
	private Set<MessageCandidature> messageCandidatures;

	//bi-directional many-to-one association to MessageOffreEmploi
	@OneToMany(mappedBy="offreEmploi")
	private Set<MessageOffreEmploi> messageOffreEmplois;

	//bi-directional many-to-one association to Entreprise
	@ManyToOne
	@JoinColumn(name="id_entreprise")
	private Entreprise entreprise;

	//bi-directional many-to-many association to Qualification
	@ManyToMany(mappedBy="offreEmplois", fetch=FetchType.EAGER)
	private Set<Qualification> qualifications;

	//bi-directional many-to-many association to SecteurActivite
	@ManyToMany(mappedBy="offreEmplois", fetch=FetchType.EAGER)
	private Set<SecteurActivite> secteurActivites;

	public OffreEmploi() {
	}
	
	public OffreEmploi(String titrec, String desc, String profile, Entreprise entreprisec, Date depot, Qualification qual, Set<SecteurActivite> secteurs) {
		this.titre=titrec;
		this.descriptif=desc;
		this.profilRecherche=profile;
		this.entreprise=entreprisec;
		this.dateDepot=depot;
		this.qualification=qual;
		this.secteurActivites=secteurs;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDateDepot() {
		return this.dateDepot;
	}

	public void setDateDepot(Date dateDepot) {
		this.dateDepot = dateDepot;
	}

	public String getDescriptif() {
		return this.descriptif;
	}

	public void setDescriptif(String descriptif) {
		this.descriptif = descriptif;
	}

	public String getProfilRecherche() {
		return this.profilRecherche;
	}

	public void setProfilRecherche(String profilRecherche) {
		this.profilRecherche = profilRecherche;
	}

	public String getTitre() {
		return this.titre;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public Set<MessageCandidature> getMessageCandidatures() {
		return this.messageCandidatures;
	}

	public void setMessageCandidatures(Set<MessageCandidature> messageCandidatures) {
		this.messageCandidatures = messageCandidatures;
	}

	public MessageCandidature addMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().add(messageCandidature);
		messageCandidature.setOffreEmploi(this);

		return messageCandidature;
	}

	public MessageCandidature removeMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().remove(messageCandidature);
		messageCandidature.setOffreEmploi(null);

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
		messageOffreEmploi.setOffreEmploi(this);

		return messageOffreEmploi;
	}

	public MessageOffreEmploi removeMessageOffreEmploi(MessageOffreEmploi messageOffreEmploi) {
		getMessageOffreEmplois().remove(messageOffreEmploi);
		messageOffreEmploi.setOffreEmploi(null);

		return messageOffreEmploi;
	}

	public Entreprise getEntreprise() {
		return this.entreprise;
	}

	public void setEntreprise(Entreprise entreprise) {
		this.entreprise = entreprise;
	}

	public Set<Qualification> getQualifications() {
		return this.qualifications;
	}

	public void setQualifications(Set<Qualification> qualifications) {
		this.qualifications = qualifications;
	}

	public Set<SecteurActivite> getSecteurActivites() {
		return this.secteurActivites;
	}
	

	public void setSecteurActivites(Set<SecteurActivite> secteurActivites) {
		this.secteurActivites = secteurActivites;
	}

}