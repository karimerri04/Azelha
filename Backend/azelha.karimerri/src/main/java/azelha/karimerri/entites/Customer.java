package azelha.karimerri.entites;

import java.io.Serializable;
import java.util.Date;
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
@Table(name = "customers")
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Customer implements Serializable, Comparable<Customer> {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	// @JsonIgnore
	@ManyToOne(cascade = CascadeType.PERSIST)
	@EqualsAndHashCode.Exclude
	@JoinColumn(name = "user_id")
	private User user;

	@JsonIgnore
	@EqualsAndHashCode.Exclude
	@OneToMany(mappedBy = "customer", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
	private Set<Scan> scans;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_date")
	private Date createDate = new Date();

	public int compareTo(Customer c) {

		if (getCreateDate() == null || c.getCreateDate() == null)
			return 0;
		return getCreateDate().compareTo(c.getCreateDate());
	}
}
