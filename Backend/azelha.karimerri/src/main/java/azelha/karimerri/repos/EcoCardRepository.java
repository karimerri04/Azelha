package azelha.karimerri.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import azelha.karimerri.entites.EcoCard;

public interface EcoCardRepository extends JpaRepository<EcoCard, Integer> {

	@Query("select e from EcoCard e where e.user.id=:id AND e.isActive=:isActive")
	EcoCard getEcoCardByActiveCard(Integer id, Boolean isActive);

	@Query("select e from EcoCard e where e.user.id=:id")
	List<EcoCard> getEcoCardByUserId(Integer id);
}
