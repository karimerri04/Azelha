package azelha.karimerri.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import azelha.karimerri.entites.Company;

public interface CompanyRepository extends JpaRepository<Company, Integer> {

}
