package azelha.karimerri.entites;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "addresses")
@EqualsAndHashCode
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Address implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Column(name = "address_line1")
	private String addressLine1;

	@Column(name = "address_line2")
	private String addressLine2;

	private String city;

	private String state;

	private String country;

	// @JsonIgnore
	@Column(name = "is_active")
	private Boolean isActive;

	@Column(name = "postal_code")
	private String postalCode;

	@JsonIgnore
	@OneToOne(mappedBy = "address")
	@EqualsAndHashCode.Exclude
	private Point point;

	/*
	 * @OneToOne(cascade = CascadeType.ALL)
	 * 
	 * @JoinColumn(name = "distance_id", referencedColumnName = "id") private
	 * Distance distance;
	 */

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "company_id")
	@EqualsAndHashCode.Exclude
	private Company company;

	@JsonIgnore
	@OneToMany(mappedBy = "address", fetch = FetchType.LAZY, orphanRemoval = true)
	@EqualsAndHashCode.Exclude
	private Set<Scan> scans;

	@JsonIgnore
	@ManyToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "user_id")
	@EqualsAndHashCode.Exclude
	private User user;
}
