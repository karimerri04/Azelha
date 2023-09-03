package azelha.karimerri.entites;

import java.io.Serializable;

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

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "articles")
public class Article implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Column(name = "barcode_number")
	private String barcode_number;
	@Column(name = "barcode_type")
	private String barcode_type;
	@Column(name = "barcode_formats")
	private String barcode_formats;
	@Column(name = "mpn")
	private String mpn;
	@Column(name = "model")
	private String model;
	@Column(name = "asin")
	private String asin;
	@Column(name = "package_quantity")
	private String package_quantity;
	@Column(name = "size")
	private String size;
	@Column(name = "length")
	private String length;
	@Column(name = "width")
	private String width;
	@Column(name = "points")
	private Integer points;
	@Column(name = "height")
	private String height;
	@Column(name = "weight")
	private String weight;
	@Column(name = "description")
	private String description;
	@Column(name = "image")
	private String image;
	@Column(name = "status")
	private String status;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "scan_id")
	@EqualsAndHashCode.Exclude
	private Scan scan;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
	@JoinColumn(name = "product_id")
	@EqualsAndHashCode.Exclude
	// @JsonIgnore
	private Product product;

}
