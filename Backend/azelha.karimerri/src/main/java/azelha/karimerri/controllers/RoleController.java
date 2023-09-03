package azelha.karimerri.controllers;
/**
 *
 *//*
	 * package com.karimerri.aladin_api.controllers;
	 *
	 * import java.util.ArrayList; import java.util.HashMap; import java.util.List;
	 * import java.util.Map;
	 *
	 * import javax.validation.Valid;
	 *
	 * import org.springframework.beans.factory.annotation.Autowired; import
	 * org.springframework.stereotype.Controller; import
	 * org.springframework.ui.Model; import
	 * org.springframework.validation.BindingResult; import
	 * org.springframework.web.bind.annotation.GetMapping; import
	 * org.springframework.web.bind.annotation.ModelAttribute; import
	 * org.springframework.web.bind.annotation.PathVariable; import
	 * org.springframework.web.bind.annotation.PostMapping; import
	 * org.springframework.web.servlet.mvc.support.RedirectAttributes;
	 *
	 * import com.karimerri.aladin_api.entities.Permission; import
	 * com.karimerri.aladin_api.entities.Role; import
	 * com.karimerri.aladin_api.securities.SecurityService; import
	 * com.karimerri.aladin_api.validators.RoleValidator;
	 *
	 * @Controller //@Secured(SecurityUtil.MANAGE_ROLES) public class RoleController
	 * extends AlaDinAdminBaseController { private static final String viewPrefix =
	 * "roles/";
	 *
	 * @Autowired protected SecurityService securityService;
	 *
	 * @Autowired private RoleValidator roleValidator;
	 *
	 * @PostMapping(value = "/roles") public String
	 * createRole(@Valid @ModelAttribute("role") Role role, BindingResult result,
	 * Model model, RedirectAttributes redirectAttributes) {
	 * roleValidator.validate(role, result); if (result.hasErrors()) return
	 * viewPrefix + "create_role"; final Role persistedRole =
	 * securityService.createRole(role);
	 * logger.debug("Created new role with id : {} and name : {}",
	 * persistedRole.getId(), persistedRole.getName());
	 * redirectAttributes.addFlashAttribute("info", "Role created successfully");
	 * return "redirect:/roles"; }
	 *
	 * @GetMapping(path = "/roles/new") public String createRoleForm(Model model) {
	 * final Role role = new Role(); model.addAttribute("role", role); //
	 * model.addAttribute("permissionsList",securityService.getAllPermissions());
	 *
	 * return viewPrefix + "create_role"; }
	 *
	 * @GetMapping(path = "/roles/{id}") public String editRoleForm(@PathVariable
	 * Integer id, Model model) { final Role role = securityService.getRoleById(id);
	 * final Map<Integer, Permission> assignedPermissionMap = new HashMap<>(); final
	 * List<Permission> permissions = role.getPermissions(); for (final Permission
	 * permission : permissions) assignedPermissionMap.put(permission.getId(),
	 * permission); final List<Permission> rolePermissions = new ArrayList<>();
	 * final List<Permission> allPermissions = securityService.getAllPermissions();
	 * for (final Permission permission : allPermissions) if
	 * (assignedPermissionMap.containsKey(permission.getId()))
	 * rolePermissions.add(permission); else rolePermissions.add(null);
	 * role.setPermissions(rolePermissions); model.addAttribute("role", role); //
	 * model.addAttribute("permissionsList",allPermissions); return viewPrefix +
	 * "edit_role"; }
	 *
	 * @GetMapping(path = "/roles") public String listRoles(Model model) { final
	 * List<Role> list = securityService.getAllRoles(); model.addAttribute("roles",
	 * list); return viewPrefix + "roles"; }
	 *
	 * @ModelAttribute("permissionsList") public List<Permission> permissionsList()
	 * { return securityService.getAllPermissions(); }
	 *
	 * @PostMapping(path = "/roles/{id}") public String
	 * updateRole(@ModelAttribute("role") Role role, BindingResult result, Model
	 * model, RedirectAttributes redirectAttributes) { final Role persistedRole =
	 * securityService.updateRole(role);
	 * logger.debug("Updated role with id : {} and name : {}",
	 * persistedRole.getId(), persistedRole.getName());
	 * redirectAttributes.addFlashAttribute("info", "Role updated successfully");
	 * return "redirect:/roles"; }
	 *
	 * }
	 */