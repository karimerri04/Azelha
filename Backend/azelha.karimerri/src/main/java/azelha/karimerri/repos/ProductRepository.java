package azelha.karimerri.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import azelha.karimerri.entites.Product;

public interface ProductRepository extends JpaRepository<Product, Integer> {

	@Query("select p from Product p join p.category c where c.id = :id")
	List<Product> findByCategoryId(Integer id);

	@Query("SELECT p from Product p WHERE p.isFavorite = :isFavorite")
	List<Product> findByFavorite(@Param("isFavorite") Boolean isFavorite);

	Product findByName(String name);

	Product findBySku(String sku);

	@Query("select p from Product p where p.name like ?1 or p.sku like ?1 or p.description like ?1")
	List<Product> search(String query);

	@Modifying
	@Query("UPDATE Product p SET p.isFavorite = :isFavorite WHERE p.id = :id")
	int updateByFavorited(@Param("id") Integer id, @Param("isFavorite") Boolean isFavorite);

	@Query("select p from Product p where p.category.company.id=:id")
	List<Product> initDataByCompanyId(Integer id);

	@Query("select p from Product p where p.barCode=:barCode")
	Product getByBarCode(String barCode);
}
