package azelha.karimerri.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import azelha.karimerri.entites.Scan;

public interface ScanRepository extends JpaRepository<Scan, Integer> {

	@Query("select s from Scan s where s.customer.id=:id")
	List<Scan> findByCustomerScans(Integer id);

	@Query("select s from Scan s where s.scanNumber=:scanNumber")
	Scan findByScanNumber(String scanNumber);

	@Query(value = "SELECT * FROM scans s WHERE s.address_id = ?1 and (s.status = ?2 or s.status = ?3)", nativeQuery = true)
	List<Scan> getScansByStatus(Integer address_id, String status1, String status2);

}
