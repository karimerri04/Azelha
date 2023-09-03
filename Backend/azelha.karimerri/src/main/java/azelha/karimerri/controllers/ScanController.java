package azelha.karimerri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import azelha.karimerri.entites.OperationResponse;
import azelha.karimerri.entites.OperationResponse.ResponseStatusEnum;
import azelha.karimerri.entites.Scan;
import azelha.karimerri.services.ItemService;
import azelha.karimerri.services.ScanService;

@CrossOrigin(origins = { "http://10.0.2.2" })
@RestController
public class ScanController {
	@Autowired
	protected ScanService scanService;

	@Autowired
	protected ItemService itemService;

	@GetMapping(path = "/scans/id/{id}")
	public Scan scanById(@PathVariable Integer id) {
		return scanService.getScanById(id);
	}

	@SuppressWarnings("unused")
	@PostMapping(path = "/scans/new", consumes = "application/json")
	public OperationResponse createScan(@RequestBody Scan scan) {

		System.out.println("the scan is" + scan.toString());

		final OperationResponse resp = new OperationResponse();
		final Scan persistedScan = scanService.createScan(scan);

		if (persistedScan == null) {
			resp.setOperationStatus(ResponseStatusEnum.ERROR);
			resp.setOperationMessage("Unable to add Scan - Scan allready exist ");
		} else {
			resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
			resp.setOperationMessage("Created new Scan with id : {} and name : {}" + persistedScan.getId()
					+ persistedScan.getCheckoutComment() + "info Scan created successfully");
		}
		return resp;
	}

	@GetMapping(path = "/scans/customer/{id}")
	public List<Scan> getScanbyCustomer(@PathVariable Integer id) {

		return scanService.getScansByCustomer(id);
	}

	@GetMapping(path = "/scans/customer/{address_id}/{status1}/{status2}")
	public List<Scan> getScansByStatut(@PathVariable Integer address_id, @PathVariable String status1,
			@PathVariable String status2) {

		return scanService.getScansByStatus(address_id, status1, status2);
	}

	@GetMapping(path = "/scans/")
	public Scan getScanbyNumber(@RequestParam(value = "name") String scanNumber) {
		return scanService.getScan(scanNumber);
	}

	@GetMapping(path = "/scans")
	public List<Scan> listScans() {

		return scanService.getAllScans();
	}

	@PutMapping(value = "/scans/update/{id}")
	public Scan updateScan(@PathVariable Integer id) {
		final Scan persistedScan = scanService.updateScan(id);

		return persistedScan;
	}

	@DeleteMapping(path = "/scans/delete/{id}")
	public OperationResponse deleteScan(@PathVariable Integer id) {

		OperationResponse resp = new OperationResponse();
		resp = scanService.deleteScanById(id);

		return resp;
	}
}
