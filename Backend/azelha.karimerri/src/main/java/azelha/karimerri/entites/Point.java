package azelha.karimerri.entites;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "points")
@EqualsAndHashCode
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Point implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	private Double latitude;
	private Double longitude;

	// @JsonIgnore
	@OneToOne(cascade = CascadeType.PERSIST)
	@EqualsAndHashCode.Exclude
	@JoinColumn(name = "address_id", referencedColumnName = "id")
	private Address address;

}