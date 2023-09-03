package azelha.karimerri.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import azelha.karimerri.entites.Role;
import azelha.karimerri.repos.RoleRepository;

@Service
@Transactional
public class RoleService {
	@Autowired
	protected RoleRepository roleRepository;

	public List<Role> getAllRoles() {
		return roleRepository.findAll();

	}

}
