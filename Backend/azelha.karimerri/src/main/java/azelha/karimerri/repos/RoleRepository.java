/**
 *
 */
package azelha.karimerri.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import azelha.karimerri.entites.Role;

public interface RoleRepository extends JpaRepository<Role, Integer> {

	Role findByName(String name);

}
