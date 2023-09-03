/**
 *
 */
package azelha.karimerri.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import azelha.karimerri.entites.Customer;
import azelha.karimerri.repos.CustomerRepository;

@Service
@Transactional
public class CustomerService {
	@Autowired
	CustomerRepository customerRepository;

	public Customer createCustomer(Customer customer) {
		return customerRepository.save(customer);
	}

	public List<Customer> getAllCustomers() {
		return customerRepository.findAll();
	}

	public Customer getCustomerById(Integer id) {
		return customerRepository.findById(id).get();
	}

	public List<Customer> getCustomerByUserId(Integer id) {
		return customerRepository.findCustomersByUserId(id);
	}

}
