package eu.telecom_bretagne.cabinet_recrutement.front.rss;

import java.io.Writer;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocatorException;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils;
import eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature;
import eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi;

/**
 * Classe permettant la gestion des flux RSS publiant la liste des offres
 * d'emploi et la liste des candidatures. La classe contient deux méthodes
 * statiques utilisables au sein d'un JSP :
 * <ul>
 * 		<li>{@code GenerationFluxRSS.offresEmploi (Writer writer, String urlBase)}</li>
 * 		<li>{@code GenerationFluxRSS.candidatures(Writer writer, String urlBase)}</li>
 * </ul>
 * @author Philippe TANGUY
 */
public class GenerationFluxRSS
{
	//-----------------------------------------------------------------------------
	/**
	 * Construction du flux RSS de la liste des offres d'emploi. Celles-ci sont obtenues
	 * par l'appel de la méthode {@code listeDesOffres()}, voir : {@link IServiceOffreEmploi}.
	 * @param writer  l'instance du {@link Writer} sur lequel sera écrit le flux RSS.
	 *                La méthode étant appelée au sein d'un JSP, celui-ci est l'instance
	 *                de l'objet prédéfini {@code out}, instance de {@link JspWriter}.
	 * @param urlBase l'URL de base (une chaîne de caractères) permettant la récupération
	 *                des éléments du flux.
	 * @throws JAXBException
	 * @throws ServicesLocatorException
	 */
	public static void offresEmploi(Writer writer, String urlBase) throws JAXBException, ServicesLocatorException
	{
		// Récupération du service de gestion des offres d'emploi à l'aide de
		// la classe ServiceLocator.
		// A éventuellement adapter à votre projet.
		IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
		
		// Récupération des offres d'emploi.
		List<OffreEmploi> offres = serviceOffreEmploi.listeDesOffres();
		
		// Création du "contexte" JAXB. Celui-ci est paramétré avec le nom du package
		// contenant les classes générées par l'outil xjc.
		JAXBContext jc = JAXBContext.newInstance("eu.telecom_bretagne.cabinet_recrutement.front.rss");
		
		// Le "marshaller" est la classe permettra de gérer la sérialisation :
		// instances --> flux XML.
		Marshaller marshaller = jc.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true); // Pour que le flux généré soit joli...
		
		// Instance de l'objet ObjectFactory qui permettra de créer les instances qui
		// permettront au marshaller de générer le flux XML.
		ObjectFactory fabrique = new ObjectFactory();

		// Création de l'objet racine (élément <rss>)
		Rss rss = fabrique.createRss();
		// Mise à jour du numéro de version RSS
		rss.setVersion(new BigDecimal(2));
		
		// Création du "channel" (élément <channel>)
		Channel channel = fabrique.createChannel();

		channel.setTitle("Cabinet de recrutement : les offres d'emploi");
		channel.setLink("http://localhost:8080/CabinetRecrutement_Web/template.jsp");
		channel.setDescription("Fil rouge : gestion d'un cabinet de recrutement. Flux RSS listant les offres d'emploi.");
		channel.setPubDate("" + Utils.date2String(new Date()));
		
		// Inclusion du channel dans le rss.
		rss.setChannel(channel);
		
		
		for(OffreEmploi offre : offres) {
			Item current = fabrique.createItem();
			current.setTitle(offre.getTitre());
			current.setLink("http://localhost:8080/CabinetRecrutement_Web/template.jsp?action=infos_offre&id=" + offre.getId());
			current.setDescription(offre.getDescriptif());
			current.setPubDate(Utils.date2String(offre.getDateDepot()));
			
			channel.getItem().add(current);
		}
		
		marshaller.marshal(rss, writer);
	}
	//-----------------------------------------------------------------------------
	/**
	 * Construction du flux RSS de la liste des candidature. Celles-ci sont obtenues par
	 * l'appel de la méthode {@code listeDesCandidatures()}, voir : {@link IServiceCandidature}.
	 * @param writer  l'instance du {@link Writer} sur lequel sera écrit le flux RSS.
	 *                La méthode étant appelée au sein d'un JSP, celui-ci est l'instance
	 *                de l'objet prédéfini {@code out}, instance de {@link JspWriter}.
	 * @param urlBase l'URL de base (une chaîne de caractères) permettant la récupération
	 *                des éléments du flux.
	 * @throws JAXBException
	 * @throws ServicesLocatorException
	 */
	public static void candidatures(Writer writer, String urlBase) throws JAXBException, ServicesLocatorException {
		IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
		List<Candidature> candidatures = serviceCandidature.listCandidatures();
		JAXBContext jc = JAXBContext.newInstance("eu.telecom_bretagne.cabinet_recrutement.front.rss");
		Marshaller marshaller = jc.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true); 
		
		ObjectFactory fabrique = new ObjectFactory();
		Rss rss = fabrique.createRss();
		rss.setVersion(new BigDecimal(3));
		
		Channel channel = fabrique.createChannel();

		channel.setTitle("Cabinet de recrutement : les candidatures");
		channel.setLink("http://localhost:8080/CabinetRecrutement_Web/template.jsp");
		channel.setDescription("Fil rouge : gestion d'un cabinet de recrutement. Flux RSS listant les candidatures");
		channel.setPubDate("" + Utils.date2String(new Date()));
		
		rss.setChannel(channel);
		
		for(Candidature candidature : candidatures) {
			Item current = fabrique.createItem();
			current.setTitle(candidature.getPrenom() + " " + candidature.getNom());
			current.setLink("http://localhost:8080/CabinetRecrutement_Web/template.jsp?action=infos_candidature&id=" + candidature.getId());
			current.setDescription(candidature.getCv());
			current.setPubDate(Utils.date2String(candidature.getDateDepot()));
			
			channel.getItem().add(current);
		}
		
		marshaller.marshal(rss, writer);
	}
	//-----------------------------------------------------------------------------
}
