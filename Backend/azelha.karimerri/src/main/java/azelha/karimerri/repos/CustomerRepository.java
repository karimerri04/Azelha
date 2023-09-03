
package azelha.karimerri.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import azelha.karimerri.entites.Customer;

public interface CustomerRepository extends JpaRepository<Customer, Integer> {

	@Query("select c from Customer c where c.user.id=:id")
	List<Customer> findCustomersByUserId(Integer id);

}
