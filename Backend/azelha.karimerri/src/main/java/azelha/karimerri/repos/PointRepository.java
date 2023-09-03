package azelha.karimerri.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import azelha.karimerri.entites.Point;

public interface PointRepository extends JpaRepository<Point, Integer> {

}
