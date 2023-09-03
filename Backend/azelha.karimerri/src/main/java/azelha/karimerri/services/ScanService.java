package azelha.karimerri.services;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import azelha.karimerri.commons.AzelhaLogger;
import azelha.karimerri.entites.Address;
import azelha.karimerri.entites.Article;
import azelha.karimerri.entites.Customer;
import azelha.karimerri.entites.EcoCard;
import azelha.karimerri.entites.Exchange;
import azelha.karimerri.entites.OperationResponse;
import azelha.karimerri.entites.OperationResponse.ResponseStatusEnum;
import azelha.karimerri.entites.Product;
import azelha.karimerri.entites.Scan;
import azelha.karimerri.entites.ScanStatus;
import azelha.karimerri.entites.Supplier;
import azelha.karimerri.entites.User;
import azelha.karimerri.repos.AddressRepository;
import azelha.karimerri.repos.ArticleRepository;
import azelha.karimerri.repos.CustomerRepository;
import azelha.karimerri.repos.EcoCardRepository;
import azelha.karimerri.repos.ExchangeRepository;
import azelha.karimerri.repos.ProductRepository;
import azelha.karimerri.repos.ScanRepository;
import azelha.karimerri.repos.SupplierRepository;
import azelha.karimerri.repos.UserRepository;

@Service
@Transactional
public class ScanService {
	private static final AzelhaLogger logger = AzelhaLogger.getLogger(ScanService.class);

	@Autowired
	ScanRepository scanRepository;

	@Autowired
	CustomerRepository customerRepository;

	@Autowired
	AddressRepository addressRepository;

	@Autowired
	SupplierRepository supplierRepository;

	@Autowired
	ExchangeRepository exchangeRepository;

	@Autowired
	ArticleRepository articleRepository;

	@Autowired
	EcoCardRepository ecoCardRepository;

	@Autowired
	ProductRepository productRepository;

	@Autowired
	UserRepository userRepository;

	public Scan getScanById(Integer id) {
		return scanRepository.findById(id).get();
	}

	public Scan createScan(Scan scan) {

		final User persistUser = userRepository.findById(scan.getCustomer().getUser().getId()).get();
		Customer customertNew = new Customer();
		customertNew.setUser(persistUser);
		final Customer persistCustomer = customerRepository.save(customertNew);
		final Address persistAddress = addressRepository.findById(scan.getAddress().getId()).get();
		final Supplier persistSupplier = supplierRepository.findById(scan.getSupplier().getId()).get();
		// final Customer newPersistCustomer =
		// customerRepository.findById(persistCustomer.getId()).get();

		final EcoCard persistCard = ecoCardRepository.getEcoCardByActiveCard(persistUser.getId(), true);
		// persistCard.setUser(persistUser);

		Exchange exchangeNew = new Exchange();
		exchangeNew.setPoint(scan.getExchange().getPoint());
		exchangeNew.setEcocard(persistCard);

		final Exchange persistExchange = exchangeRepository.save(exchangeNew);
		final Exchange newPersistExchange = exchangeRepository.findById(persistExchange.getId()).get();

		Scan scanNew = new Scan();
		final Scan persistedScan = scanRepository.save(scanNew);

		if (newPersistExchange != null) {
			persistedScan.setExchange(newPersistExchange);
		}

		Set<Article> persitsArticles = new HashSet<Article>();
		for (Article articleScan : scan.getArticles()) {
			final Product productPersist = productRepository.findById(articleScan.getProduct().getId()).get();
			System.out.println("the product is" + productPersist.getBarCode());
			if (productPersist != null) {
				articleScan.setProduct(productPersist);
				articleScan.setScan(persistedScan);
				final Article savedScanArticle = articleRepository.save(articleScan);
				logger.info("New ScanArticle created. ScanArticle Number ", savedScanArticle.getBarcode_number());
				persitsArticles.add(savedScanArticle);
			}
		}
		persistedScan.setScanNumber(UUID.randomUUID().toString());
		persistedScan.setScanDate(new Date(System.currentTimeMillis()));
		persistedScan.setStatus(ScanStatus.NEW);
		persistedScan.setCustomer(persistCustomer);
		persistedScan.setAddress(persistAddress);
		persistedScan.setSupplier(persistSupplier);
		persistedScan.setCheckoutComment(scan.getCheckoutComment());
		persistedScan.setArticles(persitsArticles);

		final Scan newSavedScan = scanRepository.save(persistedScan);

		logger.info("New scan created. Scan Number ", newSavedScan.getScanNumber());
		return newSavedScan;
	}

	public List<Scan> getAllScans() {
		return scanRepository.findAll();
	}

	public Scan getScan(String scanNumber) {
		return scanRepository.findByScanNumber(scanNumber);
	}

	public List<Article> getScanArticles(Integer id) {
		return articleRepository.findByCustomerScan(id);
	}

	public List<Scan> getScansByCustomer(Integer id) {
		return scanRepository.findByCustomerScans(id);
	}

	public List<Scan> getScansByStatus(Integer address_id, String status1, String status2) {
		return scanRepository.getScansByStatus(address_id, status1, status2);
	}

	public Scan updateScan(int id) {
		final Scan persistedScan = scanRepository.getOne(id);

		persistedScan.setStatus(ScanStatus.CANCELED);

		final Scan savedScan = scanRepository.save(persistedScan);
		return savedScan;
	}

	@SuppressWarnings("null")
	public OperationResponse deleteScanById(int id) {
		final OperationResponse resp = new OperationResponse();

		final Scan persistedScan = scanRepository.getOne(id);

		if (persistedScan == null) {
			resp.setOperationStatus(ResponseStatusEnum.ERROR);
			resp.setOperationMessage("Scan " + persistedScan.getId() + " doesn't exist");
		} else {
			scanRepository.delete(persistedScan);
			resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
			resp.setOperationMessage(
					"Deleted Scan with id" + persistedScan.getScanNumber() + "info Scan deleted successfully");
		}

		return resp;
	}

}
