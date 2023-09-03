/**
 *
 */
package azelha.karimerri.entites;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "products")
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Product implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private Integer id;

	@Column(name = "product_code")
	private String productCode;

	@Column(name = "bar_code")
	private String barCode;

	private String name;

	@JsonIgnore
	private String overview;

	@JsonIgnore
	@Column(name = "browsing_name")
	private String browsingName;

	private String description;

	@Column(name = "is_favorite")
	private Boolean isFavorite;

	@JsonIgnore
	@Column(name = "standard_cost")
	private BigDecimal standardCost = new BigDecimal("0.0");

	@Column(name = "list_price")
	private BigDecimal listPrice = new BigDecimal("0.0");

	@JsonIgnore
	@Column(name = "target_level")
	private Integer targetLevel;

	@JsonIgnore
	@Column(name = "reorder_level")
	private Integer reorderLevel;

	@JsonIgnore
	@Column(name = "minimum_reorder_quantity")
	private String minimumReorderQuantity;

	@JsonIgnore
	@Column(name = "quantity_per_unit")
	private String quantityPerUnit;

	@Column(nullable = false, name = "default_image")
	private String defaultImage;
	@JsonIgnore
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "created_on")
	private Date createdOn = new Date();

	@JsonIgnore
	private Integer rank;
	@JsonIgnore
	@Column(name = "sale_price")
	private Double salePrice;

	private String sku;

	@JsonIgnore
	private Integer status;

	@JsonIgnore
	@Column(name = "points")
	private Integer points;

	@JsonIgnore
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "updated_on")
	private Date updatedOn = new Date();

	@JsonIgnore
	@ManyToOne(cascade = CascadeType.PERSIST)
	@EqualsAndHashCode.Exclude
	@JoinColumn(name = "category_id", nullable = false)
	private Category category;

	@JsonIgnore
	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
	private Set<Item> items = new HashSet<Item>();

}
