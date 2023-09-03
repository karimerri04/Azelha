/**
 *
 */
package azelha.karimerri.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import azelha.karimerri.entites.Permission;

public interface PermissionRepository extends JpaRepository<Permission, Integer> {

}
