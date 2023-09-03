package azelha.karimerri.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import azelha.karimerri.entites.Item;

public interface ItemRepository extends JpaRepository<Item, Integer> {

	@Query("select i from Item i where i.product.id=:id")
	Item findOrderItemByProductId(Integer id);

}
