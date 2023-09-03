package azelha.karimerri.entites;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "exchanges")
@EqualsAndHashCode
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Exchange implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@ManyToOne(cascade = CascadeType.PERSIST)
	@EqualsAndHashCode.Exclude
	@JoinColumn(name = "ecocard_id")
	private EcoCard ecocard;

	private BigDecimal point;

	private Boolean status;
}
