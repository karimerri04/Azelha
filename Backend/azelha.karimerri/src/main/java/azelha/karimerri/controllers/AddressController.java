package azelha.karimerri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import azelha.karimerri.entites.Address;
import azelha.karimerri.entites.OperationResponse;
import azelha.karimerri.entites.OperationResponse.ResponseStatusEnum;
import azelha.karimerri.entites.Point;
import azelha.karimerri.services.AddressService;

@CrossOrigin(origins = { "http://10.0.2.2", "http://localhost:3000" })
@RestController
public class AddressController {

	@Autowired
	private AddressService addressService;

	@PostMapping(path = "/address/new", consumes = "application/json")
	public OperationResponse createAddress(@RequestBody Address address) {

		System.out.println(address.toString());

		final OperationResponse resp = new OperationResponse();
		final Address persistedAddress = addressService.createAddress(address);

		if (persistedAddress == null) {
			resp.setOperationStatus(ResponseStatusEnum.ERROR);
			resp.setOperationMessage("Unable to add Address - Address allready exist ");
		} else {
			resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
			resp.setOperationMessage("Created new Address with id : {} and name : {}" + persistedAddress.getId()
					+ persistedAddress.getPostalCode() + "info Address created successfully");
		}

		return resp;
	}

	@GetMapping(path = "/addresses/active/{id}")
	public Address findActiveAddress(@PathVariable Integer id) {
		return addressService.findActiveAddress(id, true);
	}

	@GetMapping(path = "/addresses/user/{id}")
	public List<Address> getAddressByUserId(@PathVariable Integer id) {
		return addressService.findByUserId(id);
	}

	@GetMapping(path = "/addresses/company/{id}")
	public List<Address> getAddressByCompanyId(@PathVariable Integer id) {
		return addressService.findByCompanyId(id);
	}

	@GetMapping(path = "/addresses")
	public List<Address> listAddress() {
		return addressService.getAllAddresses();
	}

	@GetMapping(path = "/addresses/{location}")
	public List<Address> findByLocationNear(@PathVariable Point location) {
		return addressService.findByLocationNear(location);
	}

	@PutMapping(value = "/addresses/update/{id}")
	public Address updateAddress(@PathVariable Integer id) {
		final Address persistedAddress = addressService.updateAddress(id);

		return persistedAddress;
	}

}
