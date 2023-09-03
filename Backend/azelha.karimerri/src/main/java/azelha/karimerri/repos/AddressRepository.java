package azelha.karimerri.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import azelha.karimerri.entites.Address;
import azelha.karimerri.entites.Point;

public interface AddressRepository extends JpaRepository<Address, Integer> {

	@Query("select a from Address a where a.user.id = :userId and a.isActive = :isActive")
	Address findActiveAddress(Integer userId, Boolean isActive);

	@Query("select a from Address a where a.user.id=:id")
	List<Address> findByUserId(Integer id);

	List<Address> findByCompanyId(Integer id);

	@Query("select a from Address a where a.point = :point")
	List<Address> findByLocationNear(Point point);

}
