package azelha.karimerri.entites;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "ecocards")
@EqualsAndHashCode
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class EcoCard implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@ManyToOne(cascade = CascadeType.PERSIST)
	@EqualsAndHashCode.Exclude
	@JoinColumn(name = "user_id")
	private User user;

	/*
	 * @JsonIgnore
	 * 
	 * @OneToMany(mappedBy = "ecocard", fetch = FetchType.LAZY, cascade =
	 * CascadeType.PERSIST)
	 * 
	 * @EqualsAndHashCode.Exclude private Set<Exchange> exchanges = new
	 * HashSet<Exchange>();
	 */

	@Column(name = "ecocard_number")
	private String ecoCardNum;
	// @JsonIgnore
	private String cvv;
	@Column(name = "exp_date")
	private String expDate;
	@Column(name = "card_holder_name")
	private String cardHolderName;
	@JsonIgnore
	@Column(name = "is_active")
	private Boolean isActive;
	@Column(name = "ecocard_type")
	private String ecoCardType;

}
