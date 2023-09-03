package azelha.karimerri.entites;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
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

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "scans")
@EqualsAndHashCode
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Scan implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Column(name = "scan_number")
	private String scanNumber;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "scan_date")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date scanDate;

	@JsonIgnore
	@Column(name = "is_changed")
	private Boolean isChanged;

	@JsonIgnore
	@Column(name = "articles_count")
	private Integer articlesCount;

	@JsonIgnore
	@Column(name = "articles_quantity")
	private BigDecimal articlesQuantity;

	@JsonIgnore
	@Column(name = "remote_ip")
	private String remoteIp;

	@Enumerated(EnumType.STRING)
	private ScanStatus status;

	@JsonIgnore
	@Column(name = "base_grand_total")
	private BigDecimal baseGrandTotal;

	@JsonIgnore
	@Column(name = "base_subtotal")
	private BigDecimal baseSubtotal;

	@Column(name = "checkout_comment")
	private String checkoutComment;

	@JsonIgnore
	@Column(name = "sub_total")
	private BigDecimal subTotal;

	@JsonIgnore
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "updated_at")
	private Date updatedAt = new Date();

	@JsonIgnore
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "exchanged_at")
	private Date exchangeAt = new Date();

	@ManyToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "customer_id")
	@EqualsAndHashCode.Exclude
	private Customer customer;

	@ManyToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "supplier_id")
	@EqualsAndHashCode.Exclude
	private Supplier supplier;

	@ManyToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "exchange_id")
	@EqualsAndHashCode.Exclude
	private Exchange exchange;

	@ManyToOne(cascade = CascadeType.PERSIST)
	@EqualsAndHashCode.Exclude
	@JoinColumn(name = "address_id")
	private Address address;

	@OneToMany(mappedBy = "scan", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
	@EqualsAndHashCode.Exclude
	private Set<Article> articles = new HashSet<Article>();

}
