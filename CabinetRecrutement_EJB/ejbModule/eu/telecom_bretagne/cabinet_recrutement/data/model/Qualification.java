package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Set;


/**
 * The persistent class for the qualification database table.
 * 
 */
@Entity
@NamedQuery(name="Qualification.findAll", query="SELECT q FROM Qualification q")
public class Qualification implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="QUALIFICATION_ID_GENERATOR", sequenceName="QUALIFICATION_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="QUALIFICATION_ID_GENERATOR")
	private Integer id;

	private String intitule;

	//bi-directional many-to-one association to Candidature
	@OneToMany(mappedBy="qualification")
	private Set<Candidature> candidatures;

	//bi-directional many-to-many association to OffreEmploi
	@ManyToMany
	@JoinTable(
		name="index_qualification"
		, joinColumns={
			@JoinColumn(name="id_qualification")
			}
		, inverseJoinColumns={
			@JoinColumn(name="id_offre_emploi")
			}
		)
	private Set<OffreEmploi> offreEmplois;

	public Qualification() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getIntitule() {
		return this.intitule;
	}

	public void setIntitule(String intitule) {
		this.intitule = intitule;
	}

	public Set<Candidature> getCandidatures() {
		return this.candidatures;
	}

	public void setCandidatures(Set<Candidature> candidatures) {
		this.candidatures = candidatures;
	}

	public Candidature addCandidature(Candidature candidature) {
		getCandidatures().add(candidature);
		candidature.setQualification(this);

		return candidature;
	}

	public Candidature removeCandidature(Candidature candidature) {
		getCandidatures().remove(candidature);
		candidature.setQualification(null);

		return candidature;
	}

	public Set<OffreEmploi> getOffreEmplois() {
		return this.offreEmplois;
	}

	public void setOffreEmplois(Set<OffreEmploi> offreEmplois) {
		this.offreEmplois = offreEmplois;
	}

}