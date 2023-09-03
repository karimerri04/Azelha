package azelha.karimerri.services;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import azelha.karimerri.entites.Permission;
import azelha.karimerri.entites.Role;
import azelha.karimerri.entites.User;
import azelha.karimerri.exceptions.AzelhaException;
import azelha.karimerri.repos.PermissionRepository;
import azelha.karimerri.repos.RoleRepository;
import azelha.karimerri.repos.UserRepository;

@Service
@Transactional
public class UserService {
	private static final Logger logger = LogManager.getLogger(UserService.class);

	@Autowired
	UserRepository userRepository;

	@Autowired
	RoleRepository roleRepository;

	@Autowired
	PermissionRepository permissionRepository;

	public User findUserByEmail(String email) {
		return userRepository.findByEmail(email);
	}

	public User createUser(User user) {
		final User userByEmail = findUserByEmail(user.getEmail());
		if (userByEmail != null)
			throw new AzelhaException("Email " + user.getEmail() + " user already exist");

		final List<Role> persistedRoles = new ArrayList<>();
		persistedRoles.add(roleRepository.findByName("ROLE_USER"));

		user.setRoles(persistedRoles);
		user.setStatus(false);

		logger.debug("Exiting registerUser() and send back confirmation");

		return userRepository.save(user);
	}

	public User getUserByEmail(String email) {
		return userRepository.findByEmail(email);

	}

	public User getUserByOpt(int otpnum) {
		return userRepository.getUserByOpt(otpnum);
	}

	public User getUserByPhone(String phone) {
		return userRepository.getUserByPhone(phone);
	}

	public User getUserById(int id) {
		return userRepository.getOne(id);
	}

	public List<User> findAllUsers() {
		return userRepository.findAll();
	}

	public List<Role> getAllRoles() {
		return roleRepository.findAll();
	}

	public List<Permission> getAllPermissions() {
		return permissionRepository.findAll();
	}

	public Role getRoleById(Integer id) {
		return roleRepository.getOne(id);
	}

	public Role getRoleByName(String roleName) {
		return roleRepository.findByName(roleName);
	}

	public User updateUser(User user) {
		final User persistedUser = userRepository.getOne(user.getId());
		if (persistedUser == null)
			throw new AzelhaException("User " + user.getId() + " doesn't exist");
		persistedUser.setAddresses(user.getAddresses());
		persistedUser.setEmail(user.getEmail());
		persistedUser.setStatus(user.getStatus());
		return userRepository.save(persistedUser);
	}

	public User updateRoleUser(User user) {
		final User persistedUser = getUserById(user.getId());
		if (persistedUser == null)
			throw new AzelhaException("User " + user.getId() + " doesn't exist");

		final List<Role> updatedRoles = new ArrayList<>();
		final List<Role> roles = user.getRoles();
		if (roles != null)
			for (final Role role : roles)
				if (role.getId() != null)
					updatedRoles.add(roleRepository.getOne(role.getId()));
		persistedUser.setRoles(updatedRoles);
		return userRepository.save(persistedUser);
	}

	@SuppressWarnings("null")
	public void deleteUserById(int id) {
		final User persistedUser = userRepository.getOne(id);
		if (persistedUser == null)
			throw new AzelhaException("User " + persistedUser.getId() + " doesn't exist");
		userRepository.delete(persistedUser);
	}

	public String resetPassword(String email) {
		final User user = findUserByEmail(email);
		if (user == null)
			throw new AzelhaException("Invalid email address");
		final String uuid = UUID.randomUUID().toString();
		user.setPasswordResetToken(uuid);
		return uuid;
	}

	public User updatePassword(String phone, String password) {
		final User persistedUser = userRepository.getUserByPhone(phone);
		if (persistedUser == null)
			throw new AzelhaException("Invalid phone number");
		persistedUser.setPasswordHash(password);
		return userRepository.save(persistedUser);
	}

	public User updateStatus(Boolean status, String phone) {
		final User persistedUser = userRepository.getUserByPhone(phone);
		if (persistedUser == null)
			throw new AzelhaException("Invalid phone number");
		persistedUser.setStatus(status);
		return userRepository.save(persistedUser);
	}

	public Role updatePermissionRole(Role role) {
		final Role persistedRole = getRoleById(role.getId());
		if (persistedRole == null)
			throw new AzelhaException("Role " + role.getId() + " doesn't exist");
		persistedRole.setDescription(role.getDescription());
		final Set<Permission> updatedPermissions = new HashSet<>();
		final Set<Permission> permissions = role.getPermissions();
		if (permissions != null)
			for (final Permission permission : permissions)
				if (permission.getId() != null)
					updatedPermissions.add(permissionRepository.getOne(permission.getId()));
		persistedRole.setPermissions(updatedPermissions);
		return roleRepository.save(persistedRole);
	}

	public boolean verifyPasswordResetToken(String email, String token) {
		final User user = findUserByEmail(email);
		if (user == null)
			throw new AzelhaException("Invalid email address");
		if (!StringUtils.hasText(token) || !token.equals(user.getPasswordResetToken()))
			return false;
		return true;
	}
}
