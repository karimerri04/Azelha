package azelha.karimerri.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import azelha.karimerri.entites.Company;
import azelha.karimerri.repos.CompanyRepository;

@Service
@Transactional
public class CompanyService {

	@Autowired
	CompanyRepository companyRepository;

	public List<Company> getAllCompanies() {
		return companyRepository.findAll();
	}

	public Company getCompanyById(Integer id) {
		return companyRepository.findById(id).get();
	}
}
