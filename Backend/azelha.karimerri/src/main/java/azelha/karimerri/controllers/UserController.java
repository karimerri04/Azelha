package azelha.karimerri.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import azelha.karimerri.entites.OperationResponse;
import azelha.karimerri.entites.OperationResponse.ResponseStatusEnum;
import azelha.karimerri.entites.Role;
import azelha.karimerri.entites.User;
import azelha.karimerri.services.RoleService;
import azelha.karimerri.services.UserService;

@RestController
public class UserController {

	@Autowired
	protected UserService userService;
	@Autowired
	protected RoleService roleService;

	@PostMapping(path = "/register", consumes = "application/json")
	public OperationResponse createUser(@RequestBody User user) {

		final OperationResponse resp = new OperationResponse();
		final User persistedUser = userService.createUser(user);

		if (persistedUser == null) {
			resp.setOperationStatus(ResponseStatusEnum.ERROR);
			resp.setOperationMessage("Unable to add User - User allready exist ");
		} else {
			resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
			resp.setOperationMessage("Created new User with id : {} and name : {}" + persistedUser.getId()
					+ persistedUser.getFullName() + "info User created successfully");
		}

		return resp;
	}

	/*
	 * @Secured("ROLE_USER")
	 * 
	 * @GetMapping(path = "/users/{id}") public User editUserForm(@PathVariable
	 * Integer id) { final User user = userService.getUserById(id); final
	 * Map<Integer, Role> assignedRoleMap = new HashMap<>(); final List<Role> roles
	 * = user.getRoles(); for (final Role role : roles)
	 * assignedRoleMap.put(role.getId(), role); final List<Role> userRoles = new
	 * ArrayList<>(); final List<Role> allRoles = roleService.getAllRoles(); for
	 * (final Role role : allRoles) if (assignedRoleMap.containsKey(role.getId()))
	 * userRoles.add(role); else userRoles.add(null); user.setRoles(userRoles);
	 * return user; }
	 */

	@GetMapping(path = "/users/email/{email}")
	public User getUserByEmail(@PathVariable String email) {
		return userService.getUserByEmail(email);
	}

	@GetMapping(value = "/users")
	public ResponseEntity<List<User>> listAllUsers() {
		List<User> users = userService.findAllUsers();
		if (users.isEmpty()) {
			return new ResponseEntity<List<User>>(HttpStatus.NO_CONTENT);// You many decide to return
																			// HttpStatus.NOT_FOUND
		}
		return new ResponseEntity<List<User>>(users, HttpStatus.OK);
	}

	@ModelAttribute("rolesList")
	public List<Role> rolesList() {
		return roleService.getAllRoles();
	}

	@PutMapping(value = "/user/{id}")
	public ResponseEntity<User> updateUser(@PathVariable("id") int id, @RequestBody User user) {
		System.out.println("Updating User " + id);

		User currentUser = userService.getUserById(id);

		if (currentUser == null) {
			System.out.println("User with id " + id + " not found");
			return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
		}

		currentUser.setFullName(user.getFullName());
		currentUser.setEmail(user.getEmail());
		currentUser.setGender(user.getGender());

		userService.updateUser(currentUser);
		return new ResponseEntity<User>(currentUser, HttpStatus.OK);
	}

	/*
	 * @RequestMapping(path = "/logout", method = RequestMethod.GET) public
	 * ResponseEntity<String> logout(HttpServletRequest request, HttpServletResponse
	 * response) { try { Authentication auth =
	 * SecurityContextHolder.getContext().getAuthentication(); if (auth != null) {
	 * new SecurityContextLogoutHandler().logout(request, response, auth); }
	 * response.sendRedirect(request.getContextPath() + "/index.html"); return
	 * ResponseEntity.ok().build(); } catch (IOException e) { return
	 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
	 * } }
	 */

	@GetMapping(value = "/user/{id}", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<User> getUser(@PathVariable("id") int id) {
		System.out.println("Fetching User with id " + id);
		User user = userService.getUserById(id);
		if (user == null) {
			System.out.println("User with id " + id + " not found");
			return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<User>(HttpStatus.OK);
	}

	@RequestMapping(value = "/user/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<User> deleteUser(@PathVariable("id") int id) {
		System.out.println("Fetching & Deleting User with id " + id);

		User user = userService.getUserById(id);
		if (user == null) {
			System.out.println("Unable to delete. User with id " + id + " not found");
			return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
		}

		userService.deleteUserById(id);
		return new ResponseEntity<User>(HttpStatus.NO_CONTENT);
	}

	@PutMapping(value = "/user/resetPassWord/{number}/{newPassword}")
	public OperationResponse updatePassword(@PathVariable("number") String number,
			@PathVariable("newPassword") String newPassword) {
		final OperationResponse resp = new OperationResponse();
		System.out.println("Updating User " + number);

		final User updatedUser = userService.updatePassword(number, newPassword);

		if (updatedUser == null) {
			resp.setOperationStatus(ResponseStatusEnum.ERROR);
			resp.setOperationMessage("Unable to add CreditCard - CreditCard allready exist ");
		} else {
			resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
			resp.setOperationMessage("Updated user password successfully");
		}

		return resp;
	}

}
