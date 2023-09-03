
package azelha.karimerri.repos;

import java.util.Optional;

import org.springframework.data.repository.PagingAndSortingRepository;

import azelha.karimerri.entites.Property;

public interface PropertyRepository extends PagingAndSortingRepository<Property, Integer> {

	Optional<Property> findByName(String name);

}
