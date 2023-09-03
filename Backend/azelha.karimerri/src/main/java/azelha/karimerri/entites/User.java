package azelha.karimerri.entites;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "users")
@EqualsAndHashCode
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	// @JsonIgnore
	@Column(nullable = false, name = "password_hash")
	@Size(min = 4)
	private String passwordHash;

	@Column(name = "full_name")
	private String fullName;
	@JsonIgnore
	private String gender;

	@Column(nullable = false, unique = true)
	private String email;

	private String phone;

	@JsonIgnore
	private String avatar;

	@JsonIgnore
	@Column(name = "password_reset_token")
	private String passwordResetToken;

	@JsonIgnore
	private Boolean status;

	@JsonIgnore
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_date")
	private Date createDate = new Date();

	@Column(name = "otp_num")
	private Integer otpNum;
	@JsonIgnore
	@Column(name = "token_expired")
	private Boolean tokenExpired;

	@JsonIgnore
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	@EqualsAndHashCode.Exclude
	private Set<Address> addresses;

	@JsonIgnore
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	@EqualsAndHashCode.Exclude
	private Set<Customer> customers;

	@JsonIgnore
	@ManyToMany(fetch = FetchType.EAGER)
	@EqualsAndHashCode.Exclude
	@JoinTable(name = "users_roles", joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"), inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "id"))
	private List<Role> roles;

	@JsonIgnore
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	@EqualsAndHashCode.Exclude
	private Set<EcoCard> ecoCards;

}
