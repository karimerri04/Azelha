package azelha.karimerri.services;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import azelha.karimerri.commons.AzelhaLogger;
import azelha.karimerri.entites.Article;
import azelha.karimerri.entites.Product;
import azelha.karimerri.entites.ProductModel;
import azelha.karimerri.entites.RootObject;
import azelha.karimerri.repos.ArticleRepository;
import azelha.karimerri.repos.ProductRepository;

@Service
@Transactional
public class ArticleService {

	private static final AzelhaLogger logger = AzelhaLogger.getLogger(CategoryService.class);

	@Autowired
	ArticleRepository articleRepository;
	@Autowired
	ProductRepository productRepository;

	public Article findById(Integer id) {
		return articleRepository.findById(id).get();
	}

	public Article findByCodeNumber(String barcodeNumber) {
		return articleRepository.findByCodeNumber(barcodeNumber);
	}

	public Article findByBarcodeNumber(String barcodeNumber) {

		try {
			URL url = new URL("https://api.barcodelookup.com/v2/products?barcode=" + barcodeNumber
					+ "&formatted=y&key=w9i90xya6bj7t2bvv2oklcpnei5ja3");
			BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
			String str = "";
			String data = "";
			while (null != (str = br.readLine())) {
				data += str;
			}

			Gson g = new Gson();

			RootObject value = g.fromJson(data, RootObject.class);

			String barcode = value.products[0].barcode_number;
			System.out.print("Barcode Number: ");
			System.out.println(barcode);

			String name = value.products[0].product_name;
			System.out.print("Product Name: ");
			System.out.println(name);

			final Product persistProduct = productRepository.findById(1).get();

			Article newArticle = new Article();
			newArticle.setBarcode_number(value.products[0].barcode_number);
			newArticle.setBarcode_formats(value.products[0].barcode_formats);
			newArticle.setBarcode_type(value.products[0].barcode_type);
			newArticle.setMpn(value.products[0].mpn);
			newArticle.setPackage_quantity(value.products[0].package_quantity);
			newArticle.setSize(value.products[0].size);
			newArticle.setLength(value.products[0].length);
			newArticle.setWidth(value.products[0].width);
			newArticle.setHeight(value.products[0].height);
			newArticle.setWeight(value.products[0].weight);
			newArticle.setDescription(value.products[0].description);
			newArticle.setImage(value.products[0].images[0]);
			newArticle.setProduct(persistProduct);

			final Article savedArticle = articleRepository.save(newArticle);
			logger.info("New Article created. Article : {}", savedArticle.getBarcode_number());

			return savedArticle;

		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return null;
	}

	public List<Article> getAllArticles() {
		return articleRepository.findAll();
	}

	public List<Article> getListArticleByScanId(Integer id) {
		return articleRepository.getListArticleByScanId(id);
	}

	public Article createArticleByProduct(ProductModel product) {

		final Product persistProduct = productRepository.findById(1).get();

		Article newArticle = new Article();
		newArticle.setBarcode_number(product.barcode_number);
		newArticle.setBarcode_formats(product.barcode_formats);
		newArticle.setBarcode_type(product.barcode_type);
		newArticle.setMpn(product.mpn);
		newArticle.setPackage_quantity(product.package_quantity);
		newArticle.setSize(product.size);
		newArticle.setLength(product.length);
		newArticle.setWidth(product.width);
		newArticle.setHeight(product.height);
		newArticle.setWeight(product.weight);
		newArticle.setDescription(product.description);
		newArticle.setImage(product.images[0]);
		newArticle.setProduct(persistProduct);

		final Article savedArticle = articleRepository.save(newArticle);
		logger.info("New Article created. Article : {}", savedArticle.getBarcode_number());
		return savedArticle;
	}

	public Article createArticle(Article article) {
		final Product persistProduct = productRepository.findById(1).get();

		article.setProduct(persistProduct);

		final Article savedArticle = articleRepository.save(article);
		logger.info("New Article created. Article : {}", savedArticle.getBarcode_number());
		return savedArticle;
	}

	public Set<Article> createScanArticle(Set<Article> scanArticles) {
		Set<Article> persistenceArticles = new HashSet<Article>();
		for (Article article : scanArticles) {
			final Article savedScanArticle = articleRepository.save(article);
			logger.info("New OrderItem created. OrderItem Number ", savedScanArticle.getBarcode_number());
			persistenceArticles.add(savedScanArticle);
		}
		return persistenceArticles;
	}

	public Article getOrderItemByProductId(Integer id) {
		return articleRepository.findScanArticleByProductId(id);
	}
}
