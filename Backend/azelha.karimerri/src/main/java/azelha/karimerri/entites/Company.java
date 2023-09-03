package azelha.karimerri.entites;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "companies")
@EqualsAndHashCode
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Company implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private String name;

	private String logo;

	@JsonIgnore
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_date")
	private Date createDate = new Date();

	@JsonIgnore
	@EqualsAndHashCode.Exclude
	@OneToMany(mappedBy = "company", cascade = CascadeType.PERSIST)
	private Set<Address> addresses = new HashSet<Address>();

	@JsonIgnore
	@EqualsAndHashCode.Exclude
	@OneToMany(mappedBy = "company", cascade = CascadeType.PERSIST)
	private Set<Category> categories = new HashSet<Category>();

	@JsonIgnore
	@EqualsAndHashCode.Exclude
	@OneToMany(mappedBy = "company", cascade = CascadeType.PERSIST)
	private Set<Supplier> suppliers = new HashSet<Supplier>();

}
