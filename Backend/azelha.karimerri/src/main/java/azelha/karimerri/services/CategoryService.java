package azelha.karimerri.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import azelha.karimerri.entites.Category;
import azelha.karimerri.exceptions.AzelhaException;
import azelha.karimerri.repos.CategoryRepository;

@Service
@Transactional
public class CategoryService {

	@Autowired
	CategoryRepository categoryRepository;

	public List<Category> getAllCategories() {
		return categoryRepository.findAll();
	}

	public Category getCategoryById(Integer id) {
		return categoryRepository.findById(id).get();
	}

	public Category getCategoryByName(String name) {
		return categoryRepository.getByName(name);
	}

	public Category updateCategory(Category category) {
		final Category persistedCategory = getCategoryById(category.getId());
		if (persistedCategory == null)
			throw new AzelhaException("Category " + category.getId() + " doesn't exist");
		persistedCategory.setDescription(category.getDescription());
		persistedCategory.setPosition(category.getPosition());
		persistedCategory.setStatus(category.getStatus());
		return categoryRepository.save(persistedCategory);
	}
}
