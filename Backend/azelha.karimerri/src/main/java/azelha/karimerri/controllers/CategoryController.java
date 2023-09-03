package azelha.karimerri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import azelha.karimerri.entites.Category;
import azelha.karimerri.services.CategoryService;

@CrossOrigin(origins = { "http://10.0.2.2" })
@RestController
public class CategoryController {

	@Autowired
	private CategoryService categoryService;

	@GetMapping(path = "/categories/{id}")
	public Category editCategoryForm(@PathVariable Integer id) {
		return categoryService.getCategoryById(id);
	}

	@GetMapping(path = "/categories")
	public List<Category> listCategories() {
		return categoryService.getAllCategories();
	}

}
