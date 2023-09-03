/**
 *
 */
package azelha.karimerri.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import azelha.karimerri.entites.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer> {

	Category getByName(String name);

}
