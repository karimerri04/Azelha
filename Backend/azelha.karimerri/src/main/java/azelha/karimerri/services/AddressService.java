package azelha.karimerri.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import azelha.karimerri.commons.AzelhaLogger;
import azelha.karimerri.entites.Address;
import azelha.karimerri.entites.Company;
import azelha.karimerri.entites.Point;
import azelha.karimerri.entites.User;
import azelha.karimerri.repos.AddressRepository;
import azelha.karimerri.repos.CompanyRepository;
import azelha.karimerri.repos.PointRepository;
import azelha.karimerri.repos.UserRepository;

@Service
@Transactional
public class AddressService {

	private static final AzelhaLogger logger = AzelhaLogger.getLogger(AddressService.class);

	@Autowired
	AddressRepository addressRepository;
	@Autowired
	UserRepository userRepository;
	@Autowired
	CompanyRepository companyRepository;
	@Autowired
	PointRepository pointRepository;

	public Address createAddress(Address address) {

		Company persistCompany = companyRepository.findById(0).get();
		address.setCompany(persistCompany);
		final User persistUser = userRepository.findById(address.getUser().getId()).get();
		address.setUser(persistUser);
		Point point = new Point();
		point.setLatitude(address.getPoint().getLatitude());
		point.setLongitude(address.getPoint().getLongitude());
		pointRepository.save(point);
		final Point persistPoint = pointRepository.findById(point.getId()).get();
		persistPoint.setLatitude(address.getPoint().getLatitude());
		persistPoint.setLongitude(address.getPoint().getLongitude());
		address.setPoint(persistPoint);

		final Address savedAddress = addressRepository.save(address);
		logger.info("New Address created. Addres zipCoee : {}", savedAddress.getPostalCode());
		return savedAddress;
	}

	public Address findActiveAddress(Integer id, Boolean isActive) {
		return addressRepository.findActiveAddress(id, isActive);
	}

	public List<Address> findByUserId(Integer id) {
		return addressRepository.findByUserId(id);
	}

	public List<Address> findByCompanyId(Integer id) {
		return addressRepository.findByCompanyId(id);
	}

	public Address findById(Integer id) {
		return addressRepository.findById(id).get();
	}

	public List<Address> getAllAddresses() {
		return addressRepository.findAll();
	}

	public List<Address> findByLocationNear(Point location) {
		return addressRepository.findByLocationNear(location);
	}

	public Address updateAddress(int id) {
		final Address persistedAddress = addressRepository.getOne(id);

		persistedAddress.setIsActive(false);

		final Address savedAddress = addressRepository.save(persistedAddress);
		return savedAddress;
	}

}
