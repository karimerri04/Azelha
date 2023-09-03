package azelha.karimerri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import azelha.karimerri.entites.EcoCard;
import azelha.karimerri.entites.OperationResponse;
import azelha.karimerri.entites.OperationResponse.ResponseStatusEnum;
import azelha.karimerri.services.EcoCardService;

@CrossOrigin(origins = { "http://10.0.2.2" })
@RestController
public class EcoCardController {

	@Autowired
	private EcoCardService ecoCardService;

	@PostMapping(path = "/ecocard/new", consumes = "application/json")
	public OperationResponse createEcoCard(@RequestBody EcoCard ecoCard) {

		System.out.println("The recieved ecocard is:" + ecoCard.toString());

		final OperationResponse resp = new OperationResponse();
		final EcoCard persistedEcocardCard =

				ecoCardService.createCreditCard(ecoCard);

		if (persistedEcocardCard == null) {
			resp.setOperationStatus(ResponseStatusEnum.ERROR);
			resp.setOperationMessage("Unable to add CreditCard - CreditCard allready exist ");
		} else {
			resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
			resp.setOperationMessage(
					"Created new ecocard with id : {} and name :" + persistedEcocardCard.getCardHolderName()
							+ persistedEcocardCard.getEcoCardType() + "info ecocard created successfully");
		}

		return resp;
	}

	@GetMapping(path = "/ecocard/active/{id}/{isActive}")
	public EcoCard getEcoCardByCustomerId(@PathVariable Integer id, @PathVariable Boolean isActive) {
		return ecoCardService.getEcoCardByActiveCard(id, isActive);
	}

	@GetMapping(path = "/ecocard/user/{id}")
	public List<EcoCard> getEcoCardByUserId(@PathVariable Integer id) {
		return ecoCardService.getCreditCardByUserId(id);
	}

	@GetMapping(path = "/ecocard/{id}")
	public EcoCard getEcoCardById(@PathVariable Integer id) {
		return ecoCardService.getCreditCardById(id);
	}

	@GetMapping(path = "/ecocards")
	public List<EcoCard> listCards() {
		return ecoCardService.getAllCardes();
	}
}
