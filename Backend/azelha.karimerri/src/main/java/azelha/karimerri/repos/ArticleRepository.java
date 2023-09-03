package azelha.karimerri.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import azelha.karimerri.entites.Article;

public interface ArticleRepository extends JpaRepository<Article, Integer> {

	@Query("select a from Article a where a.barcode_number = :barcodeNumber")
	Article findByCodeNumber(String barcodeNumber);

	@Query("select a from Article a where a.product.id=:id")
	Article findScanArticleByProductId(Integer id);

	@Query("select a from Article a where a.product.id=:id")
	List<Article> findByCustomerScan(Integer id);

	@Query("select a from Article a where a.scan.id=:id")
	List<Article> getListArticleByScanId(Integer id);

}
