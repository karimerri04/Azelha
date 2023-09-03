package azelha.karimerri.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import azelha.karimerri.commons.AzelhaLogger;
import azelha.karimerri.entites.EcoCard;
import azelha.karimerri.entites.User;
import azelha.karimerri.repos.EcoCardRepository;
import azelha.karimerri.repos.UserRepository;

@Service
@Transactional
public class EcoCardService {

	private static final AzelhaLogger logger = AzelhaLogger.getLogger(EcoCardService.class);

	@Autowired
	EcoCardRepository ecoCardRepository;

	@Autowired
	UserRepository userRepository;

	public EcoCard createCreditCard(EcoCard creditCard) {

		final User persistUser = userRepository.findById(creditCard.getUser().getId()).get();
		creditCard.setUser(persistUser);

		final EcoCard savedCreditCard = ecoCardRepository.save(creditCard);

		final List<EcoCard> persistCards = ecoCardRepository.getEcoCardByUserId(creditCard.getId());
		if (persistCards.size() >= 1) {
			creditCard.setIsActive(true);
		}
		creditCard.setUser(persistUser);

		logger.info("Container. EcoCard type : {}", savedCreditCard.getEcoCardType());
		return savedCreditCard;
	}

	public EcoCard getEcoCardByActiveCard(Integer id, Boolean isActive) {
		return ecoCardRepository.getEcoCardByActiveCard(id, isActive);
	}

	public List<EcoCard> getCreditCardByUserId(Integer id) {
		return ecoCardRepository.getEcoCardByUserId(id);
	}

	public EcoCard getCreditCardById(Integer id) {
		return ecoCardRepository.findById(id).get();
	}

	public List<EcoCard> getAllCardes() {
		return ecoCardRepository.findAll();
	}

}
