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
    Query query = entityManager.createQuery("select Candidature from Candidature Candidature order by Candidature.id");
    List l = query.getResultList(); 
    
    return (List<Candidature>)l;
  }
  
  public Candidature persist(Candidature Candidature) {
	EntityManager Ent = JPAUtil.getEntityManager();
	Ent.persist(Candidature);
	
	return Candidature;
  }
  
  public Candidature update(Candidature Candidature) {
	EntityManager Ent = JPAUtil.getEntityManager();
	Ent.merge(Candidature);
	
	return Candidature;
  }
  
  public void remove(Candidature Candidature) {
	EntityManager Ent = JPAUtil.getEntityManager();
	Ent.remove(Candidature);
  }
  //-----------------------------------------------------------------------------
}