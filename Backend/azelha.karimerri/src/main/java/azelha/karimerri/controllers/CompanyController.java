package azelha.karimerri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import azelha.karimerri.entites.Company;
import azelha.karimerri.services.CompanyService;

@CrossOrigin(origins = { "http://10.0.2.2" })
@RestController
public class CompanyController {

	@Autowired
	private CompanyService companyService;

	@GetMapping(path = "/company/{id}")
	public Company getSupplierById(@PathVariable Integer id) {
		return companyService.getCompanyById(id);
	}

	@GetMapping(path = "/companies")
	public List<Company> listCompanies() {
		return companyService.getAllCompanies();
	}

}