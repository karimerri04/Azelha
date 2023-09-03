/**
 *
 */
package azelha.karimerri.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import azelha.karimerri.entites.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	@Query("select u from User u where u.email=:email")
	User findByEmail(String email);

	@Query("select u from User u where u.otpNum=:otpNum")
	User getUserByOpt(Integer otpNum);

	@Query("select u from User u where u.phone=:phone")
	User getUserByPhone(String phone);
}
