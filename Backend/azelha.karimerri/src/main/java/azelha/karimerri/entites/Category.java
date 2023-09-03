package azelha.karimerri.entites;

import java.io.Serializable;
import java.util.HashSet;
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
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "categories")
@EqualsAndHashCode
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Category implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Column(nullable = false, unique = true)
	private String name;

	@Column(length = 1024)
	private String description;

	private Integer position;

	private Boolean status;

	@Column(name = "default_image")
	private String defaultImage;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@EqualsAndHashCode.Exclude
	@JoinColumn(name = "company_id")
	private Company company;

	@JsonIgnore
	@EqualsAndHashCode.Exclude
	@OneToMany(mappedBy = "category", cascade = CascadeType.PERSIST)
	private Set<Product> products = new HashSet<Product>();

}
