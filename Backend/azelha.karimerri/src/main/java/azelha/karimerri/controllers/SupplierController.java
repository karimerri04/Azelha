package azelha.karimerri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import azelha.karimerri.entites.Supplier;
import azelha.karimerri.services.SupplierService;

@CrossOrigin(origins = { "http://10.0.2.2" })
@RestController
public class SupplierController {

	@Autowired
	private SupplierService supplierService;

	@GetMapping(path = "/suppliers/{id}")
	public Supplier getSupplierById(@PathVariable Integer id) {
		return supplierService.getSupplierById(id);
	}

	@GetMapping(path = "/suppliers")
	public List<Supplier> listSuppliers() {
		return supplierService.getAllSuppliers();
	}

}
