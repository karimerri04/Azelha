
package azelha.karimerri.entites;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "items")
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Item implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	@JsonIgnore
	@Column(name = "base_price")
	private BigDecimal basePrice;
	@JsonIgnore
	@Column(name = "base_item_total")
	private BigDecimal baseItemTotal;
	@JsonIgnore
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "created_at")
	private Date createdAt = new Date();
	@JsonIgnore
	@Column(name = "free_delivering")
	private Boolean freeDelivering;

	@Column(name = "item_name")
	private String itemName;

	@Column(name = "item_image")
	private String itemImage;

	@Column(name = "item_price")
	private BigDecimal itemPrice;

	@Column(name = "item_quantity")
	private BigDecimal itemQun;

	@JsonIgnore
	@Column(name = "item_total")
	private BigDecimal itemTotal;
	@JsonIgnore
	@Column(name = "item_weight")
	private BigDecimal itemWeight;
	@JsonIgnore
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "updated_at")
	private Date updatedAt = new Date();

	@JsonIgnore
	@Column(name = "unit_price")
	private BigDecimal unitPrice;
	@JsonIgnore
	@Column(name = "item_status")
	private Boolean itemStatus;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "scan_id")
	@EqualsAndHashCode.Exclude
	private Scan scab;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
	@JoinColumn(name = "product_id")
	@EqualsAndHashCode.Exclude
	private Product product;

}
