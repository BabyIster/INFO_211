import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import jpaUtils.JPAUtil;

/**
 * Session Bean implementation class CandidatureDAO
 * @author Florian GUILLOT & Matthieu LE JEUNE
 */
@Stateless
@LocalBean
public class CandidatureDAO
{
  //-----------------------------------------------------------------------------
  /**
   * Référence vers le gestionnaire de persistance.
   */
  @PersistenceContext
  EntityManager entityManager;
  //-----------------------------------------------------------------------------
  /**
   * Default constructor.
   */
  public CandidatureDAO()
  {
    // TODO Auto-generated constructor stub
  }
  //-----------------------------------------------------------------------------
  public Candidature findById(Integer id)
  {
    return entityManager.find(Candidature.class, id);
  }
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<Candidature> findAll()
  {
    Query query = entityManager.createQuery("select * from Candidature order by id");
    List l = query.getResultList(); 
    
    return (List<Candidature>)l;
  }
  

  public List<Candidature> findBySectorAndQualification()
  {
    Query query = entityManager.createQuery("SELECT * FROM index_activite_candidature INNER JOIN candidature cand ON id_candidature = cand.id WHERE id_activite = 1 AND id_qualification = 1");
    List l = query.getResultList(); 
    
    return (List<Candidature>)l;
  }

  public Candidature persist(Candidature Candidature) {
	EntityManager Cand = JPAUtil.getEntityManager();
	Cand.persist(Candidature);
	
	return Candidature;
  }
  
  public Candidature update(Candidature Candidature) {
	EntityManager Cand = JPAUtil.getEntityManager();
	Cand.merge(Candidature);
	
	return Candidature;
  }
  
  public void remove(Candidature Candidature) {
	EntityManager Cand = JPAUtil.getEntityManager();
	Cand.remove(Candidature);
  }
  //-----------------------------------------------------------------------------
}