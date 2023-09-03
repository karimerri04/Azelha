package azelha.karimerri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import azelha.karimerri.entites.Article;
import azelha.karimerri.entites.OperationResponse;
import azelha.karimerri.entites.OperationResponse.ResponseStatusEnum;
import azelha.karimerri.services.ArticleService;

@CrossOrigin(origins = { "http://10.0.2.2" })
@RestController
public class ArticleController {
	@Autowired
	private ArticleService articleService;

	@GetMapping(path = "/articles")
	public List<Article> listArticle() {
		return articleService.getAllArticles();
	}

	@GetMapping(path = "/articles/scan/{id}")
	public List<Article> listArticleByScanId(@PathVariable Integer id) {
		return articleService.getListArticleByScanId(id);
	}

	@GetMapping(path = "/articles/id/{id}")
	public Article articleById(@PathVariable Integer id) {
		return articleService.findById(id);
	}

	@GetMapping(path = "/articles/barcodeNumber/{barcodeNumber}")
	public Article findByBarcodeNumber(@PathVariable String barcodeNumber) {

		final OperationResponse resp = new OperationResponse();

		final Article newArticle = articleService.findByBarcodeNumber(barcodeNumber);

		if (newArticle == null) {
			resp.setOperationStatus(ResponseStatusEnum.ERROR);
			resp.setOperationMessage("Unable to add Article - Article not found ");
		} else {
			final Article persistedArticle = articleService.findByCodeNumber(barcodeNumber);

			if (persistedArticle == null) {
				resp.setOperationStatus(ResponseStatusEnum.ERROR);
				resp.setOperationMessage("Unable to add Article - Article allready exist ");
			} else {
				resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
				resp.setOperationMessage("Created new Article with id : {} and name : {}" + persistedArticle.getId()
						+ persistedArticle.getBarcode_number() + "info Article created successfully");
				return persistedArticle;
			}

			resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
			resp.setOperationMessage("Created new Article with id : {} and name : {}" + newArticle.getId()
					+ newArticle.getBarcode_number() + "info Category created successfully");
		}

		return newArticle;
	}

	@PostMapping(path = "/articles/new", consumes = "application/json")
	public OperationResponse createArticle(@RequestBody Article article) {

		System.out.println(article.toString());

		final OperationResponse resp = new OperationResponse();
		final Article persistedArticle = articleService.createArticle(article);

		if (persistedArticle == null) {
			resp.setOperationStatus(ResponseStatusEnum.ERROR);
			resp.setOperationMessage("Unable to add Article - Article allready exist ");
		} else {
			resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
			resp.setOperationMessage("Created new Article with id : {} and name : {}" + persistedArticle.getId()
					+ persistedArticle.getBarcode_number() + "info Article created successfully");
		}

		return resp;
	}

	/*
	 * @PostMapping(path = "/articles/new", consumes = "application/json") public
	 * OperationResponse createArticle(@RequestBody Article article) {
	 * 
	 * System.out.println(article.toString());
	 * 
	 * final OperationResponse resp = new OperationResponse(); final Article
	 * persistedArticle = articleService.createArticle(article);
	 * 
	 * if (persistedArticle == null) {
	 * resp.setOperationStatus(ResponseStatusEnum.ERROR);
	 * resp.setOperationMessage("Unable to add Post - Post allready exist "); } else
	 * { resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
	 * resp.setOperationMessage("Created new Category with id : {} and name : {}" +
	 * persistedArticle.getId() + persistedArticle.getName() +
	 * "info Category created successfully"); }
	 * 
	 * return resp; }
	 */
}
