package azelha.karimerri.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import azelha.karimerri.entites.Product;
import azelha.karimerri.exceptions.AzelhaException;
import azelha.karimerri.repos.ProductRepository;

@Service
@Transactional
public class ProductService {

	@Autowired
	ProductRepository productRepository;

	/*
	 * public Product createProduct(Product product) { final Product
	 * persistedProduct = getProductBySku(product.getName()); if (persistedProduct
	 * != null) throw new AlaDinException("Product SKU " + product.getSku() +
	 * " already exist"); return productRepository.save(product); }
	 */

	public Product deleteProduct(Product product) {
		final Product persistedProduct = getProductById(product.getId());
		if (persistedProduct == null)
			throw new AzelhaException("Product " + product.getId() + " doesn't exist");
		else
			persistedProduct.setDescription(product.getSku());
		return productRepository.save(persistedProduct);
	}

	public List<Product> findByFavorited(Boolean isFavorite) {
		return productRepository.findByFavorite(isFavorite);

	}

	public List<Product> getAllProducts() {

		return productRepository.findAll();
	}

	public List<Product> getProductByCategory(Integer id) {
		return productRepository.findByCategoryId(id);

	}

	public List<Product> initDataByCompanyId(Integer id) {
		return productRepository.initDataByCompanyId(id);
	}

	public Product getProductById(Integer id) {
		return productRepository.findById(id).get();
	}

	public Product getByBarCode(String barCode) {
		return productRepository.getByBarCode(barCode);
	}

	public Product getProductBySku(String sku) {
		return productRepository.findBySku(sku);
	}

	public List<Product> searchWithJPQLQuery(String query) {
		return productRepository.search("%" + query + "%");
	}

	public List<Product> searchWithPriceQuery(String query) {
		return productRepository.search("%" + query + "%");
	}

	public Product updateProduct(Product product) {
		final Product persistedProduct = getProductById(product.getId());
		if (persistedProduct == null)
			throw new AzelhaException("Product " + product.getId() + " doesn't exist");
		else
			persistedProduct.setDescription(product.getSku());
		/*
		 * persistedProduct.setDescription(product.getDescription());
		 * persistedProduct.setDisabled(product.isDisabled());
		 * persistedProduct.setCreatedOn(product.getCreatedOn());
		 * persistedProduct.setAssetName(product.getAssetName());
		 * System.out.println("the favorite value is " + product.getIsFavorited());
		 * persistedProduct.setIsFavorited(product.getIsFavorited());
		 * persistedProduct.setCategory(categoryService.getCategoryById(product.
		 * getCategory().getId()));
		 */
		return productRepository.save(persistedProduct);
	}
}
