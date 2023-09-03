package azelha.karimerri.entites;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.data.geo.Metrics;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "distances")
@EqualsAndHashCode
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Distance implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private Integer value;

	@Enumerated(EnumType.STRING)
	private Metrics metrics;

	/*
	 * @JsonIgnore
	 * 
	 * @OneToOne(mappedBy = "distance") private Address address;
	 */
}
