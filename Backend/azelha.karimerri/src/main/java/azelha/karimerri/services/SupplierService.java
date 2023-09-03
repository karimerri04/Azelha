package azelha.karimerri.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import azelha.karimerri.entites.Supplier;
import azelha.karimerri.repos.SupplierRepository;

@Service
@Transactional
public class SupplierService {

	@Autowired
	SupplierRepository supplierRepository;

	public List<Supplier> getAllSuppliers() {
		return supplierRepository.findAll();
	}

	public Supplier getSupplierById(Integer id) {
		return supplierRepository.findById(id).get();
	}
}
